import 'package:flutter/material.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/cart/ui/widgets/circular_button.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class QuantityControls extends StatelessWidget {
  final int quantity;
  final int productId;
  final ProductsCartCubit cartCubit;

  const QuantityControls({
    super.key,
    required this.quantity,
    required this.productId,
    required this.cartCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Quantity: ',
          style: AppTextStyles.styleRegular14sp(
            context,
          ).copyWith(color: ColorsTheme().primaryDark.withValues(alpha: 0.7)),
        ),
        CircularButton(
          icon: Icons.remove,
          color: ColorsTheme().primaryColor,
          onPressed: () => cartCubit.decrementQuantity(productId),
        ),
        const SizedBox(width: 8),
        Text('$quantity', style: AppTextStyles.styleMedium16sp(context)),
        const SizedBox(width: 8),
        CircularButton(
          icon: Icons.add,
          color: ColorsTheme().primaryColor,
          onPressed: () => cartCubit.incrementQuantity(productId),
        ),
      ],
    );
  }
}
