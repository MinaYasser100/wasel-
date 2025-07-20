import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class OrderSummary extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalCartPrice;

  const OrderSummary({
    super.key,
    required this.cartItems,
    required this.totalCartPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTextStyles.styleBold20sp(
              context,
            ).copyWith(color: ColorsTheme().whiteColor),
          ),
          const SizedBox(height: 16),
          ...cartItems.asMap().entries.map((entry) {
            final item = entry.value;
            final product = item['product'] as Product;
            final quantity = context.read<ProductsCartCubit>().getQuantity(
              product.id,
            );
            final totalPrice = product.price * quantity;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.thumbnail,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: AppTextStyles.styleBold16sp(
                            context,
                          ).copyWith(color: ColorsTheme().whiteColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Quantity: $quantity',
                          style: AppTextStyles.styleRegular14sp(
                            context,
                          ).copyWith(color: Colors.white70),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: AppTextStyles.styleBold14sp(
                            context,
                          ).copyWith(color: ColorsTheme().whiteColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: AppTextStyles.styleBold20sp(
                  context,
                ).copyWith(color: ColorsTheme().whiteColor),
              ),
              Text(
                '\$${totalCartPrice.toStringAsFixed(2)}',
                style: AppTextStyles.styleBold20sp(
                  context,
                ).copyWith(color: ColorsTheme().whiteColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
