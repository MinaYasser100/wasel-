import 'package:flutter/material.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/utils/colors.dart';

import 'product_details_app_bar.dart';
import 'sliver_product_details_widget.dart';

class ProductDetailsBodyView extends StatelessWidget {
  const ProductDetailsBodyView({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorsTheme().primaryLight.withValues(alpha: 0.3),
            ColorsTheme().whiteColor,
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          // SliverAppBar مع تأثير Hero
          ProductDetailsAppBar(product: product),
          // تفاصيل المنتج
          SliverProductDetailsWidget(product: product),
        ],
      ),
    );
  }
}
