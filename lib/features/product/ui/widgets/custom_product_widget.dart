import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/features/product/ui/widgets/product_item.dart';
import 'package:wasel/features/product/ui/widgets/product_sliver_app_bar.dart';

class CustomProductsWidget extends StatelessWidget {
  const CustomProductsWidget({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ProductSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = products[index];
              return FadeInUp(
                duration: Duration(milliseconds: 500 + (index * 100)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()
                    ..scale(1.0 + (index % 2 == 0 ? 0.01 : 0.0)),
                  transformAlignment: Alignment.center,
                  child: ProductItem(product: product),
                ),
              );
            }, childCount: products.length),
          ),
        ),
      ],
    );
  }
}
