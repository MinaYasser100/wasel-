import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wasel/features/product/data/repo/product_repo_impl.dart';
import 'package:wasel/features/product/manager/cubit/product_cubit.dart';
import 'package:wasel/features/product/ui/widgets/product_body_view.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(GetIt.instance<ProductRepoImpl>())..loadProducts(),
      child: const Scaffold(body: ProductsBodyView()),
    );
  }
}
