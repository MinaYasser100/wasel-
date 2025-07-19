import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/product/manager/cubit/products_cart_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Map>('cartBox').listenable(),
      builder: (context, box, child) {
        final cartItem = box.get(product.id.toString());
        final quantity = cartItem?['quantity'] ?? 0;

        // للتحقق من القيمة
        print('Product ID: ${product.id}, Quantity from cartBox: $quantity');

        return Card(
          elevation: 8,
          shadowColor: ColorsTheme().primaryDark.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: ColorsTheme().primaryLight.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          color: ColorsTheme().whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    context.push(Routes.productDetails, extra: product);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Hero(
                      tag: 'product_${product.id}',
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(
                            child: SpinKitThreeBounce(
                              color: ColorsTheme().primaryColor,
                              size: 24.0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.styleBold16sp(context),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.styleRegular12sp(
                        context,
                      ).copyWith(color: ColorsTheme().primaryDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.styleBold18sp(
                        context,
                      ).copyWith(color: ColorsTheme().primaryColor),
                    ),
                    const SizedBox(height: 8),
                    if (quantity > 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: ColorsTheme().primaryColor,
                            ),
                            onPressed: () {
                              final cartCubit = context
                                  .read<ProductsCartCubit>();
                              cartCubit.decrementQuantity(product.id);
                            },
                          ),
                          Text(
                            '$quantity',
                            style: AppTextStyles.styleMedium14sp(context),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: ColorsTheme().primaryColor,
                            ),
                            onPressed: () {
                              final cartCubit = context
                                  .read<ProductsCartCubit>();
                              cartCubit.incrementQuantity(product.id);
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              final cartCubit = context
                                  .read<ProductsCartCubit>();
                              cartCubit.removeFromCart(product.id);
                            },
                            child: Icon(
                              Icons.delete,
                              color: ColorsTheme().errorColor,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      ElevatedButton(
                        onPressed: () {
                          final cartCubit = context.read<ProductsCartCubit>();
                          cartCubit.addToCart(product.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsTheme().primaryLight,
                          foregroundColor: ColorsTheme().whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: AppTextStyles.styleRegular12sp(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
