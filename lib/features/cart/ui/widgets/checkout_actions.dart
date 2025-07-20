import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/cart/manager/cubit/cart_cubit.dart';
import 'package:wasel/features/login/manager/login_cubit.dart';

class CheckoutActions extends StatelessWidget {
  final double totalCartPrice;

  const CheckoutActions({super.key, required this.totalCartPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    style: AppTextStyles.styleBold20sp(showContext),
                  ),
                  content: Text(
                    'Are you sure you want to complete this purchase for \$${totalCartPrice.toStringAsFixed(2)}?',
                    style: AppTextStyles.styleRegular16sp(showContext),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(showContext),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsTheme().primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(showContext);
                        ScaffoldMessenger.of(showContext).showSnackBar(
                          const SnackBar(
                            content: Text('Purchase completed successfully!'),
                          ),
                        );
                        context.read<CartCubit>().clearCart();
                        context.go(Routes.productList);
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: ColorsTheme().whiteColor),
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
    );
  }
}
