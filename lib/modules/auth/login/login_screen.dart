import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:exam_prep_app/widgets/app_button.dart';
import 'package:exam_prep_app/core/controllers/theme_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 32,
                                height: 32,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.school_rounded,
                                    size: 24,
                                    color: AppColors.primary,
                                  );
                                },
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
                                  size: 24,
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
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .moveY(begin: -10, end: 0),
                      
                      const SizedBox(height: 40),
                      
                      // Welcome text
                      Text(
                        'Welcome Back',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: isDarkMode ? Colors.white : AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .moveX(begin: -20, end: 0),
                      
                      const SizedBox(height: 8),
                      
                      // Subtitle
                      Text(
                        'Sign in to continue your learning journey',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDarkMode ? Colors.white70 : AppColors.textMuted,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 500.ms)
                      .moveX(begin: -20, end: 0),
                      
                      const SizedBox(height: 60),
                      
                      // Illustration
                      Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: isDarkMode 
                                ? Colors.white.withOpacity(0.05)
                                : AppColors.primary.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.phone_android_rounded,
                              size: 80,
                              color: isDarkMode 
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms)
                      .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1)),
                      
                      const SizedBox(height: 60),
                      
                      // Phone number input section title
                      Text(
                        'Enter your phone number',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 700.ms),
                      
                      const SizedBox(height: 16),
                      
                      // Phone number input
                      Container(
                        decoration: BoxDecoration(
                          color: isDarkMode 
                              ? AppColors.darkSurface
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                controller.phoneNumber = number.phoneNumber ?? '';
                                // Set isPhoneNumberValid to true for any input
                                controller.isPhoneNumberValid.value = true;
                              },
                              onInputValidated: (bool value) {
                                // Always enable the button for demo
                                controller.isPhoneNumberValid.value = true;
                              },
                              selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                setSelectorButtonAsPrefixIcon: true,
                                leadingPadding: 16,
                                trailingSpace: false,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              initialValue: PhoneNumber(isoCode: 'IN'),
                              formatInput: true,
                              keyboardType: TextInputType.phone,
                              inputDecoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  color: isDarkMode 
                                      ? Colors.white38
                                      : AppColors.textHint,
                                  fontSize: 16,
                                ),
                                errorStyle: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 800.ms)
                      .moveY(begin: 20, end: 0),
                      
                      const SizedBox(height: 16),
                      
                      // Phone number validation message
                      Obx(() => controller.phoneError.isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: AppColors.error,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      controller.phoneError.value,
                                      style: TextStyle(
                                        color: AppColors.error,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Continue button
                      AppButton(
                        text: 'Continue',
                        isLoading: controller.isLoading.value,
                        onPressed: controller.sendOTP,
                        isGradient: true,
                        borderRadius: 16,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 900.ms)
                      .moveY(begin: 20, end: 0),
                      
                      const SizedBox(height: 20),
                      
                      // Terms and conditions
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'By continuing, you agree to our ',
                            style: TextStyle(
                              color: isDarkMode 
                                  ? Colors.white60
                                  : AppColors.textMuted,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: isDarkMode 
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: isDarkMode 
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 1000.ms),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}