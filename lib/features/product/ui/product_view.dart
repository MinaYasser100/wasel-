import 'package:flutter/material.dart';
import 'package:wasel/features/product/ui/widgets/product_body_view.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ProductsBodyView());
  }
}
