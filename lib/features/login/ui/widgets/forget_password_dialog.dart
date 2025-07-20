import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/login/manager/forget_password_cubit/forgot_password_cubit.dart';
import 'package:wasel/features/login/ui/widgets/custom_input_field.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final TextEditingController emailController;

  const ForgotPasswordDialog({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    final resetEmailController = TextEditingController(
      text: emailController.text,
    );

    return AlertDialog(
      backgroundColor: ColorsTheme().primaryLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Reset Password',
        style: AppTextStyles.styleBold20sp(context),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter your email to receive a password reset link.',
            style: AppTextStyles.styleRegular16sp(context),
          ),
          const SizedBox(height: 16),
          CustomInputField(
            icon: Icons.email_outlined,
            hint: "Email",
            obscure: false,
            controller: resetEmailController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset link sent to your email!'),
                ),
              );
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsTheme().primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: state is ForgotPasswordLoading
                  ? null
                  : () {
                      if (!resetEmailController.text.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter a valid email containing @',
                            ),
                          ),
                        );
                        return;
                      }
                      context
                          .read<ForgotPasswordCubit>()
                          .sendPasswordResetEmail(
                            email: resetEmailController.text.trim(),
                          );
                    },
              child: state is ForgotPasswordLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Send Reset Link',
                      style: TextStyle(color: ColorsTheme().whiteColor),
                    ),
            );
          },
        ),
      ],
    );
  }
}
