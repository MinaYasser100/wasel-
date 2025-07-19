import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';
import 'package:wasel/features/product_details/ui/widget/product_details_body_view.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCartCubit(),
      child: Scaffold(body: ProductDetailsBodyView(product: product)),
    );
  }
}
