import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF5E35B1);      // Deep Purple
  static const Color primaryLight = Color(0xFF9162E4);
  static const Color primaryDark = Color(0xFF3B1F74);
  
  // Accent Colors
  static const Color accent = Color(0xFF00BCD4);       // Cyan
  static const Color accentLight = Color(0xFF62EFFF);
  static const Color accentDark = Color(0xFF008BA3);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFFF9800);    // Orange
  static const Color secondaryLight = Color(0xFFFFBB52);
  static const Color secondaryDark = Color(0xFFC66900);
  
  // Background Colors
  static const Color lightBackground = Color(0xFFF7F9FC);
  static const Color darkBackground = Color(0xFF192A51);
  
  // Surface Colors
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF273C65);
  
  // Text Colors
  static const Color textDark = Color(0xFF2B3445);
  static const Color textLight = Color(0xFFF7F9FC);
  static const Color textMuted = Color(0xFF8D99AE);
  static const Color textMutedDark = Color(0xFFADB9CC);
  static const Color textHint = Color(0xFFADB9CC);
  static const Color textHintDark = Color(0xFF8D99AE);
  
  // Functional Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);
  
  // Divider Colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF3F4A66);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF7B42F6),    // Purple
    Color(0xFF5E35B1),    // Deep Purple
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFF00E5FF),    // Cyan
    Color(0xFF00BCD4),    // Cyan
  ];
  
  static const List<Color> successGradient = [
    Color(0xFF66BB6A),
    Color(0xFF4CAF50),
  ];
  
  static const List<Color> warningGradient = [
    Color(0xFFFFD54F),
    Color(0xFFFFC107),
  ];
  
  static const List<Color> errorGradient = [
    Color(0xFFEF5350),
    Color(0xFFE53935),
  ];
  
  // Button Colors
  static const Color buttonTextLight = Color(0xFFFFFFFF);
  static const Color disabledButton = Color(0xFFBDBDBD);
  static const Color disabledButtonText = Color(0xFF757575);
  
  // Card Colors
  static const Color cardBorderLight = Color(0xFFEAEEF5);
  static const Color cardBorderDark = Color(0xFF3F4A66);
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);
  
  // Animation Colors
  static const List<Color> loadingAnimationColors = [
    primary,
    accent,
    secondary,
  ];
}