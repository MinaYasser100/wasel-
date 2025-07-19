import 'package:go_router/go_router.dart';
import 'package:wasel/core/helper_network/model/product_model.dart';
import 'package:wasel/core/routing/animation_route.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/features/cart/ui/cart_view.dart';
import 'package:wasel/features/product/ui/product_view.dart';
import 'package:wasel/features/product_details/ui/product_details_view.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.productList,
    routes: [
      GoRoute(
        path: Routes.productList,
        pageBuilder: (context, state) => fadeTransitionPage(ProductsView()),
      ),
      GoRoute(
        path: Routes.productDetails,
        pageBuilder: (context, state) {
          final product = state.extra as Product?;
          if (product == null) throw Exception('Product not found');
          return fadeTransitionPage(ProductDetailsView(product: product));
        },
      ),
      GoRoute(
        path: Routes.cart,
        pageBuilder: (context, state) => fadeTransitionPage(CartView()),
      ),
    ],
  );
}

// Future<String> getFirstScreen() async {
//   final isOnboardingSeen = OnboardingHive().isOnboardingSeen();
//   if (!isOnboardingSeen) {
//     return Routes.onboarding;
//   }
//   // Ensure MonitoringSystemHiveService is ready
//   final monitoringService =
//       await GetIt.I.getAsync<MonitoringSystemHiveService>();
//   final farmOwnerStatus = monitoringService.getFarmOwnerStatus();

//   if (farmOwnerStatus == null) {
//     return Routes.userTypeSelectionScreen;
//   } else if (!farmOwnerStatus) {
//     return Routes.layoutScreens;
//   } else if (farmOwnerStatus &&
//       monitoringService.getFarmerSelectedPlants().isEmpty) {
//     return Routes.plantsSelectionScreen;
//   } else {
//     return Routes.layoutScreens;
//   }
// }
