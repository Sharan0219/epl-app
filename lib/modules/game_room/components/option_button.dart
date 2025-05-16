import 'package:flutter/material.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OptionButton extends StatelessWidget {
  final String option;
  final String optionLabel; // A, B, C, D...
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;

  const OptionButton({
    Key? key,
    required this.option,
    required this.optionLabel,
    this.isSelected = false,
    this.isCorrect = false,
    this.showResult = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color labelColor;
    IconData? resultIcon;

    // Determine colors and icon based on state
    if (showResult) {
      if (isSelected) {
        if (isCorrect) {
          backgroundColor = AppColors.success.withOpacity(0.2);
          borderColor = AppColors.success;
          labelColor = AppColors.success;
          resultIcon = Icons.check_circle;
        } else {
          backgroundColor = AppColors.error.withOpacity(0.2);
          borderColor = AppColors.error;
          labelColor = AppColors.error;
          resultIcon = Icons.cancel;
        }
      } else if (isCorrect) {
        backgroundColor = AppColors.success.withOpacity(0.1);
        borderColor = AppColors.success.withOpacity(0.5);
        labelColor = AppColors.success;
        resultIcon = Icons.check_circle_outline;
      } else {
        backgroundColor = Colors.white.withOpacity(0.05);
        borderColor = Colors.transparent;
        labelColor = Colors.white.withOpacity(0.8);
        resultIcon = null;
      }
    } else {
      if (isSelected) {
        backgroundColor = AppColors.primary.withOpacity(0.2);
        borderColor = AppColors.primary;
        labelColor = AppColors.primary;
        resultIcon = null;
      } else {
        backgroundColor = Colors.white.withOpacity(0.05);
        borderColor = Colors.transparent;
        labelColor = Colors.white.withOpacity(0.8);
        resultIcon = null;
      }
    }

    return GestureDetector(
      onTap: showResult ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Option label (A, B, C, D)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: labelColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  optionLabel,
                  style: TextStyle(
                    color: labelColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Option text
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            
            // Result icon
            if (resultIcon != null)
              Icon(
                resultIcon,
                color: isCorrect ? AppColors.success : AppColors.error,
                size: 24,
              ),
          ],
        ),
      )
      .animate(
        target: isSelected ? 1 : 0,
      )
      .scale(
        begin: const Offset(1, 1),
        end: const Offset(1.02, 1.02),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}