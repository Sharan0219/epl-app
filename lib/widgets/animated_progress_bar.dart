import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final Duration animationDuration;
  final BorderRadius? borderRadius;

  const AnimatedProgressBar({
    Key? key,
    required this.progress,
    this.height = 10,
    this.backgroundColor,
    this.progressColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.divider,
        borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: animationDuration,
            width: progress * Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
            ),
          ),
        ],
      ),
    );
  }
}