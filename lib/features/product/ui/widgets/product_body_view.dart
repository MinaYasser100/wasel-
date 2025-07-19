import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/product/manager/products_cubit/product_cubit.dart';
import 'package:wasel/features/product/ui/widgets/custom_product_widget.dart';

class ProductsBodyView extends StatelessWidget {
  const ProductsBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(
            child: SpinKitThreeBounce(
              color: ColorsTheme().primaryColor,
              size: 24.0,
            ),
          );
        } else if (state is ProductError) {
          return ErrorWidget(state.message);
        } else if (state is ProductLoaded) {
          final products = state.products;
          return CustomProductsWidget(products: products);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
