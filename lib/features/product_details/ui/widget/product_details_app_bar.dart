import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/utils/colors.dart';

class ProductDetailsAppBar extends StatelessWidget {
  const ProductDetailsAppBar({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 350.0,
      backgroundColor: ColorsTheme().primaryLight.withValues(alpha: 0.3),
      flexibleSpace: FlexibleSpaceBar(
        background: FadeIn(
          duration: const Duration(milliseconds: 600),
          child: Hero(
            tag: 'product_${product.id}',
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorsTheme().primaryLight.withValues(alpha: 0.3),
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: ColorsTheme().primaryLight,
                    child: Icon(
                      Icons.error,
                      color: ColorsTheme().errorColor,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
