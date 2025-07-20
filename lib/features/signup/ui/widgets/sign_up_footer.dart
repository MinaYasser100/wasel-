import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/utils/colors.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.login);
      },
      child: Text(
        "Already have an account? Login",
        style: TextStyle(color: ColorsTheme().whiteColor),
      ),
    );
  }
}
