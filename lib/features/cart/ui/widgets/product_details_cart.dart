import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/cart/ui/widgets/quantity_controls.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final int quantity;
  final double totalPrice;

  const ProductDetails({
    super.key,
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<ProductsCartCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: AppTextStyles.styleBold16sp(
            context,
          ).copyWith(color: ColorsTheme().primaryDark),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        QuantityControls(
          quantity: quantity,
          productId: product.id,
          cartCubit: cartCubit,
        ),
        const SizedBox(height: 12),
        Text(
          'Total: \$${totalPrice.toStringAsFixed(2)}',
          style: AppTextStyles.styleBold14sp(
            context,
          ).copyWith(color: ColorsTheme().accentColor),
        ),
      ],
    );
  }
}
