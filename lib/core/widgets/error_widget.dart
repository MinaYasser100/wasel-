import 'package:flutter/material.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.styleMedium16sp(
            context,
          ).copyWith(color: ColorsTheme().errorColor),
        ),
      ),
    );
  }
}
