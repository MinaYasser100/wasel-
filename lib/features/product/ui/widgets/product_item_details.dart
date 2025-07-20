import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class ProductItemDetails extends StatelessWidget {
  final Product product;
  final int quantity;

  const ProductItemDetails({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.styleBold16sp(context),
          ),
          const SizedBox(height: 4),
          Text(
            product.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.styleRegular12sp(
              context,
            ).copyWith(color: ColorsTheme().primaryDark),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: AppTextStyles.styleBold18sp(
              context,
            ).copyWith(color: ColorsTheme().primaryColor),
          ),
          const SizedBox(height: 8),
          if (quantity > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: ColorsTheme().primaryColor),
                  onPressed: () {
                    final cartCubit = context.read<ProductsCartCubit>();
                    cartCubit.decrementQuantity(product.id);
                  },
                ),
                Text(
                  '$quantity',
                  style: AppTextStyles.styleMedium14sp(context),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: ColorsTheme().primaryColor),
                  onPressed: () {
                    final cartCubit = context.read<ProductsCartCubit>();
                    cartCubit.incrementQuantity(product.id);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    final cartCubit = context.read<ProductsCartCubit>();
                    cartCubit.removeFromCart(product.id);
                  },
                  child: Icon(Icons.delete, color: ColorsTheme().errorColor),
                ),
              ],
            ),
          ] else ...[
            ElevatedButton(
              onPressed: () {
                final cartCubit = context.read<ProductsCartCubit>();
                cartCubit.addToCart(product.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Product added to cart!',
                      style: AppTextStyles.styleRegular14sp(
                        context,
                      ).copyWith(color: ColorsTheme().whiteColor),
                    ),
                    backgroundColor: ColorsTheme().primaryColor,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.only(
                      top: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsTheme().primaryLight,
                foregroundColor: ColorsTheme().whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              child: Text(
                'Add to Cart',
                style: AppTextStyles.styleRegular12sp(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
