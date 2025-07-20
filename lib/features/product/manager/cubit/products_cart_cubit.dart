import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wasel/features/product/data/repo/cart_repo/cart_repo.dart';

part 'products_cart_state.dart';

class ProductsCartCubit extends Cubit<ProductsCartState> {
  Map<int, int> cartItems = {}; // id -> quantity (محلي)

  ProductsCartCubit() : super(ProductsCartInitial()) {
    _loadCartFromHive(); // تحميل البيانات من Hive عند التشغيل
  }

  Future<void> _loadCartFromHive() async {
    final box = await ProductCartRepo.box;
    cartItems = {
      for (var key in box.keys)
        int.parse(key): box.get(key)!['quantity'] as int,
    };
    emit(ProductsCartUpdated(cartItems));
  }

  void addToCart(int productId) async {
    final box = await ProductCartRepo.box;
    final currentQuantity = box.get(productId.toString())?['quantity'] ?? 0;
    cartItems[productId] = currentQuantity + 1;
    ProductCartRepo.addToCart(productId, cartItems[productId]!);
    emit(ProductsCartUpdated(cartItems));
  }

  void removeFromCart(int productId) async {
    cartItems.remove(productId);
    ProductCartRepo.updateQuantity(productId, 0);
    emit(ProductsCartUpdated(cartItems));
  }

  void incrementQuantity(int productId) async {
    final box = await ProductCartRepo.box;
    final currentQuantity = box.get(productId.toString())?['quantity'] ?? 0;
    cartItems[productId] = currentQuantity + 1;
    ProductCartRepo.updateQuantity(productId, cartItems[productId]!);
    emit(ProductsCartUpdated(cartItems));
  }

  void decrementQuantity(int productId) async {
    final box = await ProductCartRepo.box;
    final currentQuantity = box.get(productId.toString())?['quantity'] ?? 0;
    if (currentQuantity == 1) {
      removeFromCart(productId);
    } else if (currentQuantity > 1) {
      cartItems[productId] = currentQuantity - 1;
      ProductCartRepo.updateQuantity(productId, cartItems[productId]!);
      emit(ProductsCartUpdated(cartItems));
    }
  }

  int getQuantity(int productId) {
    final box = Hive.box<Map>('cartBox'); // قراءة مباشرة من cartBox
    final item = box.get(productId.toString());
    return item?['quantity'] ?? 0;
  }
}
