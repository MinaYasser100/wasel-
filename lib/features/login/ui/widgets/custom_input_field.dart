import 'package:flutter/material.dart';
import 'package:wasel/core/utils/colors.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  const CustomInputField({
    super.key,
    required this.icon,
    required this.hint,
    required this.obscure,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isObscured = ValueNotifier<bool>(obscure);

    return ValueListenableBuilder<bool>(
      valueListenable: isObscured,
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          obscureText: value,
          style: TextStyle(color: ColorsTheme().whiteColor),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white70),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: ColorsTheme().whiteColor.withValues(alpha: 0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: obscure
                ? IconButton(
                    icon: Icon(
                      value ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      isObscured.value = !value;
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}
