import 'package:flutter/material.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/login/ui/widgets/custom_input_field.dart';

class AuthContainer extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLoginPressed;

  const AuthContainer({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsTheme().whiteColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          CustomInputField(
            icon: Icons.email_outlined,
            hint: "Email",
            obscure: false,
            controller: emailController,
          ),
          const SizedBox(height: 16),
          CustomInputField(
            icon: Icons.lock_outline,
            hint: "Password",
            obscure: true,
            controller: passwordController,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: ColorsTheme().primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () {
                      if (!emailController.text.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter a valid email containing @',
                            ),
                          ),
                        );
                        return;
                      }
                      onLoginPressed();
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: Text(
              "Forgot password?",
              style: TextStyle(color: ColorsTheme().whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
