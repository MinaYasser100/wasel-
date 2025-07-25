import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage});

  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
