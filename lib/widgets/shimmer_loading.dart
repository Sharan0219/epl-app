import 'package:flutter/material.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const ShimmerLoading({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPulse(
            color: AppColors.primary,
            size: 50.0,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerLoadingBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerLoadingBox({
    Key? key,
    this.width,
    this.height = 20,
    this.borderRadius = 8,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade300
            : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}