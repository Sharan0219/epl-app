import 'package:flutter/material.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color>? gradientColors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;

  const GradientContainer({
    Key? key,
    required this.child,
    this.gradientColors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.width,
    this.height,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: gradientColors ?? AppColors.primaryGradient,
        ),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}