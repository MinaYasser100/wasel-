import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/features/product/data/repo/cart_repo/cart_repo.dart';

part 'products_cart_state.dart';

class ProductsCartCubit extends Cubit<ProductsCartState> {
  Map<int, int> cartItems = {}; // id -> quantity (محلي)

  ProductsCartCubit() : super(ProductsCartInitial()) {
    _loadCartFromHive(); // تحميل البيانات من Hive عند التشغيل
  }

  Future<void> _loadCartFromHive() async {
    final box = await CartRepo.box;
    cartItems = {
      for (var key in box.keys)
        int.parse(key): box.get(key)!['quantity'] as int,
    };
    emit(ProductsCartUpdated(cartItems));
  }

  void addToCart(int productId) {
    cartItems[productId] = cartItems[productId] ?? 0 + 1;
    CartRepo.addToCart(productId, cartItems[productId]!);
    emit(ProductsCartUpdated(cartItems));
  }

  void removeFromCart(int productId) {
    cartItems.remove(productId);
    CartRepo.updateQuantity(productId, 0);
    emit(ProductsCartUpdated(cartItems));
  }

  void incrementQuantity(int productId) {
    cartItems[productId] = (cartItems[productId] ?? 0) + 1;
    CartRepo.updateQuantity(productId, cartItems[productId]!);
    emit(ProductsCartUpdated(cartItems));
  }

  void decrementQuantity(int productId) {
    if (cartItems[productId] == 1) {
      removeFromCart(productId);
    } else if (cartItems[productId] != null && cartItems[productId]! > 1) {
      cartItems[productId] = cartItems[productId]! - 1;
      CartRepo.updateQuantity(productId, cartItems[productId]!);
      emit(ProductsCartUpdated(cartItems));
    }
  }

  int getQuantity(int productId) => cartItems[productId] ?? 0;
}
