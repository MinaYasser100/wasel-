import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/cart/manager/cubit/cart_cubit.dart';
import 'package:wasel/features/login/manager/login_cubit.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';
import 'package:hive/hive.dart';

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
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Checkout',
                              style: AppTextStyles.styleBold28sp(context)
                                  .copyWith(
                                    color: ColorsTheme().whiteColor,
                                    letterSpacing: 1,
                                  ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: ColorsTheme().whiteColor,
                              ),
                              onPressed: () => context.go(Routes.productList),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Cart Items
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Summary',
                                style: AppTextStyles.styleBold20sp(
                                  context,
                                ).copyWith(color: ColorsTheme().whiteColor),
                              ),
                              const SizedBox(height: 16),
                              ...cartItems.asMap().entries.map((entry) {
                                final item = entry.value;
                                final product = item['product'] as Product;
                                final quantity = context
                                    .read<ProductsCartCubit>()
                                    .getQuantity(product.id);
                                final totalPrice = product.price * quantity;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          product.thumbnail,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.title,
                                              style:
                                                  AppTextStyles.styleBold16sp(
                                                    context,
                                                  ).copyWith(
                                                    color: ColorsTheme()
                                                        .whiteColor,
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Quantity: $quantity',
                                              style:
                                                  AppTextStyles.styleRegular14sp(
                                                    context,
                                                  ).copyWith(
                                                    color: Colors.white70,
                                                  ),
                                            ),
                                            Text(
                                              '\$${totalPrice.toStringAsFixed(2)}',
                                              style:
                                                  AppTextStyles.styleBold14sp(
                                                    context,
                                                  ).copyWith(
                                                    color: ColorsTheme()
                                                        .whiteColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total:',
                                    style: AppTextStyles.styleBold20sp(
                                      context,
                                    ).copyWith(color: ColorsTheme().whiteColor),
                                  ),
                                  Text(
                                    '\$${totalCartPrice.toStringAsFixed(2)}',
                                    style: AppTextStyles.styleBold20sp(
                                      context,
                                    ).copyWith(color: ColorsTheme().whiteColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Confirm Purchase Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsTheme().whiteColor,
                              foregroundColor: ColorsTheme().primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (showContext) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Text(
                                    'Confirm Purchase',
                                    style: AppTextStyles.styleBold20sp(
                                      showContext,
                                    ),
                                  ),
                                  content: Text(
                                    'Are you sure you want to complete this purchase for \$${totalCartPrice.toStringAsFixed(2)}?',
                                    style: AppTextStyles.styleRegular16sp(
                                      showContext,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(showContext),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorsTheme().primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(showContext);
                                        ScaffoldMessenger.of(
                                          showContext,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Purchase completed successfully!',
                                            ),
                                          ),
                                        );
                                        context.read<CartCubit>().clearCart();
                                        context.go(Routes.productList);
                                      },
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color: ColorsTheme().whiteColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              'Confirm Purchase',
                              style: AppTextStyles.styleBold18sp(
                                context,
                              ).copyWith(color: ColorsTheme().primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              await context.read<AuthCubit>().logout();
                              final authBox = await Hive.openBox('authBox');
                              await authBox.put('isLoggedIn', false);
                              await authBox.delete('userId');
                              context.go(Routes.login);
                            },
                            child: Text(
                              'Logout',
                              style: AppTextStyles.styleBold18sp(
                                context,
                              ).copyWith(color: ColorsTheme().whiteColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Back to Products
                        Center(
                          child: TextButton(
                            onPressed: () => context.go(Routes.productList),
                            child: Text(
                              'Continue Shopping',
                              style: AppTextStyles.styleRegular16sp(
                                context,
                              ).copyWith(color: Colors.white70),
                            ),
                          ),
                        ),
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
