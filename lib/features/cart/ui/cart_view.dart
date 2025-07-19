import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/cart/manager/cubit/cart_cubit.dart';
import 'package:wasel/features/cart/ui/widgets/cart_body_view.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCartCubit()),
        BlocProvider(
          create: (context) => CartCubit(context.read<ProductsCartCubit>()),
        ),
      ],

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: ColorsTheme().whiteColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Cart',
            style: TextStyle(
              color: ColorsTheme().whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorsTheme().primaryColor,
          elevation: 4,
          centerTitle: true,
        ),
        body: CartBodyView(),
      ),
    );
  }
}
