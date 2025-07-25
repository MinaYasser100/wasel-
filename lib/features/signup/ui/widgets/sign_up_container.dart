import 'package:flutter/material.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/login/ui/widgets/custom_input_field.dart';
import 'package:wasel/features/signup/ui/widgets/sign_up_footer.dart';

class SignUpContainer extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onSignUpPressed;

  const SignUpContainer({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onSignUpPressed,
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
          const SizedBox(height: 16),
          CustomInputField(
            icon: Icons.lock_outline,
            hint: "Confirm Password",
            obscure: true,
            controller: confirmPasswordController,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsTheme().whiteColor,
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
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                          ),
                        );
                        return;
                      }
                      onSignUpPressed();
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      "SIGN UP",
                      style: AppTextStyles.styleBold18sp(context),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          SignUpFooter(),
        ],
      ),
    );
  }
}
