import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/utils/colors.dart';

import 'product_image.dart';
import 'product_item_details.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Map>('cartBox').listenable(),
      builder: (context, box, child) {
        final cartItem = box.get(product.id.toString());
        final quantity = cartItem?['quantity'] ?? 0;
        return Card(
          elevation: 8,
          shadowColor: ColorsTheme().primaryDark.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: ColorsTheme().primaryLight.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          color: ColorsTheme().whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProductImage(product: product),
              ProductItemDetails(product: product, quantity: quantity),
            ],
          ),
        );
      },
    );
  }
}
