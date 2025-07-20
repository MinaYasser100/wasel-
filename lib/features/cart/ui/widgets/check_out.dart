import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/cart/manager/cubit/cart_cubit.dart';
import 'package:wasel/features/cart/ui/widgets/checkout_header.dart';
import 'package:wasel/features/login/manager/login_cubit.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

import 'checkout_actions.dart';
import 'order_summary.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCartCubit()),
        BlocProvider(
          create: (context) => CartCubit(context.read<ProductsCartCubit>()),
        ),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorsTheme().primaryDark, ColorsTheme().primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorsTheme().whiteColor,
                    ),
                  );
                } else if (state is CartError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyles.styleBold18sp(
                        context,
                      ).copyWith(color: ColorsTheme().whiteColor),
                    ),
                  );
                } else if (state is CartLoaded) {
                  final cartItems = state.cartItems;
                  if (cartItems.isEmpty) {
                    return Center(
                      child: Text(
                        'Your cart is empty',
                        style: AppTextStyles.styleBold18sp(
                          context,
                        ).copyWith(color: ColorsTheme().whiteColor),
                      ),
                    );
                  }
                  double totalCartPrice = cartItems.fold(0.0, (sum, item) {
                    final product = item['product'] as Product;
                    final quantity = context
                        .read<ProductsCartCubit>()
                        .getQuantity(product.id);
                    return sum + product.price * quantity;
                  });

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckoutHeader(),
                        const SizedBox(height: 20),
                        OrderSummary(
                          cartItems: cartItems,
                          totalCartPrice: totalCartPrice,
                        ),
                        const SizedBox(height: 24),
                        CheckoutActions(totalCartPrice: totalCartPrice),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
