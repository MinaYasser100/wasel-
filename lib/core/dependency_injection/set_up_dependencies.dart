import 'package:get_it/get_it.dart';
import 'package:wasel/core/helper_network/dio_helper.dart';
import 'package:wasel/core/internet_check/cubit/internet_check__cubit.dart';
import 'package:wasel/features/product/data/repo/product_repo/product_repo_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // register singletons
  // register dio helper
  getIt.registerSingleton<DioHelper>(DioHelper());
  // register product repo
  getIt.registerSingleton<ProductRepoImpl>(ProductRepoImpl());
  // register connectivity cubit for internet
  getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
}
