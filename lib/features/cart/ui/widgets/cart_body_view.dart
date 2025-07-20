import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/core/utils/constant.dart';
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
            double totalCartPrice = cartItems.fold(0.0, (sum, item) {
              final product = item['product'] as Product;
              final quantity = context.read<ProductsCartCubit>().getQuantity(
                product.id,
              );
              return sum + product.price * quantity;
            });
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
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsTheme().whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '\$${totalCartPrice.toStringAsFixed(2)}',
                          style: AppTextStyles.styleBold20sp(
                            context,
                          ).copyWith(color: ColorsTheme().primaryDark),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            final authBox = await Hive.openBox(
                              ConstantVariable.authBox,
                            );
                            final isLoggedIn = authBox.get(
                              ConstantVariable.authKey,
                              defaultValue: false,
                            );
                            // Log للتحقق
                            debugPrint('isLoggedIn: $isLoggedIn');
                            debugPrint('authBox values: ${authBox.toMap()}');
                            if (isLoggedIn) {
                              context.go(Routes.checkout); // صفحة الـ Checkout
                            } else {
                              context.push(Routes.login); // صفحة الـ Login
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsTheme().primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Checkout',
                            style: AppTextStyles.styleBold20sp(
                              context,
                            ).copyWith(color: ColorsTheme().whiteColor),
                          ),
                        ),
                      ],
                    ),
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
