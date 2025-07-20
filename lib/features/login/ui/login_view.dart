import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasel/core/routing/routes.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';
import 'package:wasel/features/login/manager/login_cubit.dart';
import 'package:wasel/features/login/ui/widgets/auth_container.dart';
import 'package:wasel/features/login/ui/widgets/auth_footer.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login successful")));
            context.go(Routes.checkout); // غيّرها حسب مسار الشاشة الرئيسية
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorsTheme().primaryColor,
                    ColorsTheme().primaryLight,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 80,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock, color: Colors.white, size: 80),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome Back!',
                        style: AppTextStyles.styleBold28sp(context).copyWith(
                          color: ColorsTheme().whiteColor,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 40),
                      AuthContainer(
                        emailController: emailController,
                        passwordController: passwordController,
                        isLoading: state is AuthLoading,
                        onLoginPressed: () {
                          context.read<AuthCubit>().login(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      const AuthFooter(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
