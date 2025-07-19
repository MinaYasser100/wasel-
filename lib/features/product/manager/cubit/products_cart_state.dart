part of 'products_cart_cubit.dart';

@immutable
sealed class ProductsCartState {}

final class ProductsCartInitial extends ProductsCartState {}

class ProductsCartUpdated extends ProductsCartState {
  final Map<int, int> cartItems;
  ProductsCartUpdated(this.cartItems);
}
