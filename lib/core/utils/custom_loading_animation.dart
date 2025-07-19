import 'package:flutter/material.dart';
import 'package:wasel/core/theme/app_style.dart';
import 'package:wasel/core/utils/colors.dart';

class CustomLoadingAnimation extends StatefulWidget {
  const CustomLoadingAnimation({super.key});

  @override
  _CustomLoadingAnimationState createState() => _CustomLoadingAnimationState();
}

class _CustomLoadingAnimationState extends State<CustomLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 30, end: 50).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: _animation.value,
                height: _animation.value,
                decoration: BoxDecoration(
                  color: ColorsTheme().primaryColor,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
          Text(
            'Loading...',
            style: AppTextStyles.styleBold18sp(
              context,
            ).copyWith(color: ColorsTheme().primaryColor),
          ),
        ],
      ),
    );
  }
}
