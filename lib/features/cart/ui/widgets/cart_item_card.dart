import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/cart/ui/widgets/circular_button.dart';
import 'package:wasel/features/cart/ui/widgets/product_details_cart.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final int index;

  const CartItemCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<ProductsCartCubit>();
    final quantity = cartCubit.getQuantity(product.id);
    final totalPrice = product.price * quantity;

    return FadeInUp(
      duration: Duration(milliseconds: 300 * (index + 1)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsTheme().primaryLight.withValues(alpha: 0.2),
              ColorsTheme().whiteColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorsTheme().primaryDark.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.thumbnail,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ProductDetails(
                product: product,
                quantity: quantity,
                totalPrice: totalPrice,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircularButton(
                icon: Icons.delete,
                color: ColorsTheme().errorColor,
                onPressed: () => cartCubit.removeFromCart(product.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
