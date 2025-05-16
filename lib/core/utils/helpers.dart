import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:exam_prep_app/core/theme/app_theme.dart';

class Helpers {
  Helpers._();

  /// Shows a snackbar with the given message
  static void showSnackBar({
    required String message,
    String? title,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title ?? (isError ? 'Error' : 'Success'),
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError 
          ? AppColors.error.withOpacity(0.9)
          : AppColors.success.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: duration,
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  /// Shows a loading dialog
  static void showLoading({String? message}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? AppColors.darkSurface : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Hides the loading dialog
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  /// Shows a confirmation dialog
  static Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'No',
    bool isDanger = false,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              cancelText,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              confirmText,
              style: TextStyle(
                color: isDanger ? AppColors.error : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    
    return result ?? false;
  }

  /// Formats a date
  static String formatDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  /// Formats a time
  static String formatTime(DateTime time, {String format = 'HH:mm'}) {
    return DateFormat(format).format(time);
  }

  /// Formats the given duration as MM:SS
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  /// Formats a number with commas
  static String formatNumber(int number) {
    return NumberFormat('#,###').format(number);
  }

  /// Formats a phone number
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 10) {
      return phoneNumber;
    }
    
    // Format for international numbers
    String countryCode = phoneNumber.substring(0, phoneNumber.length - 10);
    String firstPart = phoneNumber.substring(phoneNumber.length - 10, phoneNumber.length - 7);
    String secondPart = phoneNumber.substring(phoneNumber.length - 7, phoneNumber.length - 4);
    String thirdPart = phoneNumber.substring(phoneNumber.length - 4);
    
    return '+$countryCode $firstPart $secondPart $thirdPart';
  }

  /// Generates a random color
  static Color getRandomColor() {
    final random = Random();
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      AppColors.success,
      AppColors.info,
    ];
    
    return colors[random.nextInt(colors.length)];
  }

  /// Gets the initials from a name
  static String getInitials(String name) {
    if (name.isEmpty) return '';
    
    List<String> nameSplit = name.split(' ');
    if (nameSplit.length > 1) {
      return '${nameSplit[0][0]}${nameSplit[1][0]}'.toUpperCase();
    } else {
      return name.substring(0, min(2, name.length)).toUpperCase();
    }
  }

  /// Shows a bottom sheet menu
  static void showBottomSheetMenu({
    required List<Widget> children,
    String? title,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            if (title != null) ...[
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            
            const SizedBox(height: 20),
            
            ...children,
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// Toggles the theme mode
  static void toggleThemeMode() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  /// Sets the status bar color based on the current theme
  static void setStatusBarColor(BuildContext context) {
    // This requires flutter/services.dart and SystemChrome
    // Leaving implementation details as they're typically in main.dart
  }
}