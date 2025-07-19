import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart' show ColorsTheme;
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class DetailsAddToCart extends StatelessWidget {
  const DetailsAddToCart({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: BlocBuilder<ProductsCartCubit, ProductsCartState>(
        builder: (context, state) {
          final cartCubit = context.read<ProductsCartCubit>();
          final quantity = cartCubit.getQuantity(product.id);

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorsTheme().whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: ColorsTheme().primaryDark.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (quantity == 0)
                  ElevatedButton(
                    onPressed: () => cartCubit.addToCart(product.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsTheme().primaryColor,
                      foregroundColor: ColorsTheme().whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: AppTextStyles.styleBold16sp(context),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: ColorsTheme().primaryColor,
                            ),
                            onPressed: () =>
                                cartCubit.decrementQuantity(product.id),
                          ),
                          Text(
                            '$quantity',
                            style: AppTextStyles.styleMedium16sp(context),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: ColorsTheme().primaryColor,
                            ),
                            onPressed: () =>
                                cartCubit.incrementQuantity(product.id),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: ColorsTheme().errorColor,
                        ),
                        onPressed: () => cartCubit.removeFromCart(product.id),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
