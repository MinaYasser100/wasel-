import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ProductsCartCubit productsCartCubit;

  CartCubit(this.productsCartCubit) : super(CartInitial()) {
    loadCart();
    // رصد تغييرات ProductsCartCubit
    productsCartCubit.stream.listen((state) {
      if (state is ProductsCartUpdated) {
        loadCart();
      }
    });
  }

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      // افتراضي إن CartCubit بيجيب البيانات من ProductsCartCubit
      final cartItems = await _getCartItemsFromProductsCubit();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  Future<List<Map<String, dynamic>>> _getCartItemsFromProductsCubit() async {
    final cartItems = <Map<String, dynamic>>[];
    final productIds = productsCartCubit.cartItems.keys.toList();
    for (var productId in productIds) {
      final quantity = productsCartCubit.getQuantity(productId);
      final product = Hive.box<Product>(
        'productsBox',
      ).get(productId.toString());
      if (product != null) {
        cartItems.add({'product': product, 'quantity': quantity});
      }
    }
    return cartItems;
  }

  // دالة لتفريغ السلة
  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      // تفريغ cartItems في ProductsCartCubit
      final box = Hive.box<Map>('cartBox');
      await box.clear(); // مسح كل البيانات من cartBox
      productsCartCubit.cartItems.clear(); // تفريغ القائمة المحلية
      emit(CartLoaded([])); // إصدار حالة سلة فاضية
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }
}
