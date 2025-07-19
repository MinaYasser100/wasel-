import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:wasel/core/dependency_injection/set_up_dependencies.dart';
import 'package:wasel/core/routing/app_router.dart';
import 'package:wasel/core/utils/theme_data_func.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Wait for all dependencies to be ready
  await GetIt.I.allReady();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeDataFunc(),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
