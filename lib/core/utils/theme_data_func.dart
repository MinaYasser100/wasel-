import 'package:flutter/material.dart';
import 'package:wasel/core/utils/colors.dart';

ThemeData themeDataFunc() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsTheme().whiteColor,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsTheme().primaryColor),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsTheme().primaryColor,
      foregroundColor: ColorsTheme().whiteColor,
    ),
    useMaterial3: true,
  );
}
