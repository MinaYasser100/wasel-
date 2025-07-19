import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';

class ProductSliverAppBar extends StatelessWidget {
  const ProductSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorsTheme().primaryColor, ColorsTheme().primaryLight],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Products',
                  style: AppTextStyles.styleBold24sp(
                    context,
                  ).copyWith(color: ColorsTheme().whiteColor),
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: ColorsTheme().whiteColor,
                  ),
                  onPressed: () {
                    context.push(Routes.cart);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorsTheme().primaryColor,
    );
  }
}
