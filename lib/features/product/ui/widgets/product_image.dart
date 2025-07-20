import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/utils/colors.dart';

class ProductImage extends StatelessWidget {
  final Product product;

  const ProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.push(Routes.productDetails, extra: product);
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Hero(
            tag: 'product_${product.id}',
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Center(
                  child: SpinKitThreeBounce(
                    color: ColorsTheme().primaryColor,
                    size: 24.0,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
