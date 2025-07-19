import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/product_details/ui/widget/details_add_to_cart.dart';

class SliverProductDetailsWidget extends StatelessWidget {
  const SliverProductDetailsWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 700),
              child: Text(
                product.title,
                style: AppTextStyles.styleBold24sp(context).copyWith(
                  fontWeight: FontWeight.w900,
                  color: ColorsTheme().primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Text(
                product.description,
                style: AppTextStyles.styleRegular16sp(context).copyWith(
                  color: ColorsTheme().primaryDark.withValues(alpha: 0.8),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 900),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.styleBold20sp(context).copyWith(
                      color: ColorsTheme().accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '4.5 (120 reviews)',
                        style: AppTextStyles.styleRegular14sp(
                          context,
                        ).copyWith(color: ColorsTheme().primaryDark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // زر "Add to Cart" مع كمية
            DetailsAddToCart(product: product),
          ],
        ),
      ),
    );
  }
}
