import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wasel/core/internet_check/cubit/internet_check__cubit.dart';
import 'package:wasel/features/product/data/repo/product_repo/product_repo_impl.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';
import 'package:wasel/features/product/manager/products_cubit/product_cubit.dart';
import 'package:wasel/features/product/ui/widgets/product_body_view.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityCubit()),
        BlocProvider(
          create: (context) => ProductCubit(
            GetIt.instance<ProductRepoImpl>(),
            GetIt.instance<ConnectivityCubit>(),
            context,
          )..loadProducts(),
        ),
        BlocProvider(create: (context) => ProductsCartCubit()),
      ],
      child: const Scaffold(body: ProductsBodyView()),
    );
  }
}
