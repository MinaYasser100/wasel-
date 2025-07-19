import 'package:flutter/material.dart';
import 'package:wasel/core/routing/app_router.dart';
import 'package:wasel/core/utils/theme_data_func.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: themeDataFunc(),
      routerConfig: AppRouter.router,
    );
  }
}
