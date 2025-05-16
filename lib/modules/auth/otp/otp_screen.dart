import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:exam_prep_app/widgets/app_button.dart';
import 'package:exam_prep_app/core/controllers/theme_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode 
                    ? [Color(0xFF192A51), Color(0xFF0F172A)]
                    : [Colors.white, Color(0xFFF9FAFC)],
              ),
            ),
          ),
          
          // Background decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode 
                    ? AppColors.primary.withOpacity(0.05)
                    : AppColors.primary.withOpacity(0.05),
              ),
            ),
          ),
          
          Positioned(
            bottom: -80,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode 
                    ? AppColors.accent.withOpacity(0.07)
                    : AppColors.accent.withOpacity(0.07),
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isDarkMode 
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: isDarkMode
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 20,
                                color: isDarkMode 
                                    ? Colors.white
                                    : AppColors.textDark,
                              ),
                            ),
                          ),
                          
                          // Theme toggle
                          GestureDetector(
                            onTap: themeController.toggleTheme,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isDarkMode 
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: isDarkMode
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              child: Icon(
                                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                                size: 20,
                                color: isDarkMode 
                                    ? AppColors.primaryLight
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .moveY(begin: -10, end: 0),
                    
                    const SizedBox(height: 40),
                    
                    // Title
                    Text(
                      'Verification Code',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: isDarkMode ? Colors.white : AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .moveX(begin: -20, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    // Subtitle with phone number
                    Obx(() => Text(
                      'Enter the 4-digit code sent to ${controller.formattedPhoneNumber}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDarkMode ? Colors.white70 : AppColors.textMuted,
                      ),
                    ))
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 300.ms)
                    .moveX(begin: -20, end: 0),
                    
                    const SizedBox(height: 60),
                    
                    // OTP Animation
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: isDarkMode 
                              ? Colors.white.withOpacity(0.05)
                              : AppColors.primary.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.lock_outline_rounded,
                            size: 60,
                            color: isDarkMode 
                                ? AppColors.primaryLight
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .fadeIn(duration: 800.ms, delay: 400.ms)
                    .scale(
                      begin: Offset(0.95, 0.95),
                      end: Offset(1, 1),
                      duration: Duration(seconds: 2),
                      curve: Curves.easeInOut,
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // OTP input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        textStyle: TextStyle(
                          color: isDarkMode ? Colors.white : AppColors.textDark,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(16),
                          fieldHeight: 64,
                          fieldWidth: 64,
                          activeFillColor: isDarkMode 
                              ? AppColors.darkSurface
                              : Colors.white,
                          inactiveFillColor: isDarkMode 
                              ? AppColors.darkSurface
                              : Colors.white,
                          selectedFillColor: isDarkMode 
                              ? AppColors.darkSurface
                              : Colors.white,
                          activeColor: AppColors.primary,
                          inactiveColor: isDarkMode 
                              ? Colors.white.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.2),
                          selectedColor: AppColors.primary,
                        ),
                        cursorColor: AppColors.primary,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: controller.otpController,
                        keyboardType: TextInputType.number,
                        boxShadows: isDarkMode
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                        onCompleted: (value) {
                          controller.verifyOTP();
                        },
                        onChanged: (value) {
                          controller.otp = value;
                        },
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 500.ms),
                    
                    const SizedBox(height: 16),
                    
                    // Error message
                    Obx(() => controller.otpError.isEmpty
                        ? const SizedBox.shrink()
                        : Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: AppColors.error,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      controller.otpError.value,
                                      style: TextStyle(
                                        color: AppColors.error,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Verify button
                    Obx(() => AppButton(
                      text: 'Verify',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.otp.length == 4
                          ? controller.verifyOTP
                          : null,
                      isGradient: true,
                      borderRadius: 16,
                    ))
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 600.ms)
                    .moveY(begin: 20, end: 0),
                    
                    const SizedBox(height: 24),
                    
                    // Resend code section
                    Center(
                      child: Column(
                        children: [
                          Obx(() => Container(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: isDarkMode 
                                  ? Colors.white.withOpacity(0.05)
                                  : AppColors.primary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              controller.canResend.value
                                  ? "Didn't receive the code?"
                                  : "Resend code in ${controller.resendTime.value}s",
                              style: TextStyle(
                                color: isDarkMode 
                                    ? Colors.white70
                                    : AppColors.textMuted,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                          
                          const SizedBox(height: 12),
                          
                          Obx(() => controller.canResend.value
                              ? TextButton.icon(
                                  onPressed: controller.resendOTP,
                                  icon: Icon(
                                    Icons.refresh_rounded,
                                    size: 18,
                                    color: isDarkMode 
                                        ? AppColors.primaryLight
                                        : AppColors.primary,
                                  ),
                                  label: Text(
                                    'Resend Code',
                                    style: TextStyle(
                                      color: isDarkMode 
                                          ? AppColors.primaryLight
                                          : AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 700.ms),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}