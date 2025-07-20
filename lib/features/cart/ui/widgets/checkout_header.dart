import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Checkout',
          style: AppTextStyles.styleBold28sp(
            context,
          ).copyWith(color: ColorsTheme().whiteColor, letterSpacing: 1),
        ),
        IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsTheme().whiteColor),
          onPressed: () => context.go(Routes.productList),
        ),
      ],
    );
  }
}
