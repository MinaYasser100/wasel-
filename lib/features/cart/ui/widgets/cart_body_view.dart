import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/core/widgets/error_widget.dart';
import 'package:wasel/features/cart/manager/cubit/cart_cubit.dart';
import 'package:wasel/features/cart/ui/widgets/cart_item_card.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class CartBodyView extends StatelessWidget {
  const CartBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(context.read<ProductsCartCubit>()),
        ),
      ],
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: SpinKitThreeBounce(
                color: ColorsTheme().primaryColor,
                size: 24.0,
              ),
            );
          } else if (state is CartError) {
            return CustomError(message: state.message);
          } else if (state is CartLoaded) {
            final cartItems = state.cartItems;
            if (cartItems.isEmpty) {
              return Center(
                child: Text(
                  'Cart is empty',
                  style: AppTextStyles.styleBold18sp(
                    context,
                  ).copyWith(color: ColorsTheme().primaryDark),
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = cartItems[index];
                      final product = item['product'] as Product;
                      return CartItemCard(product: product, index: index);
                    }, childCount: cartItems.length),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
