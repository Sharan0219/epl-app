import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              )
              .animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              )
              .shimmer(
                duration: const Duration(seconds: 2),
              )
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: const Duration(seconds: 1),
              ),
              
              const SizedBox(height: 40),
              
              // App name
              const Text(
                'Exam Prep',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 800), delay: const Duration(milliseconds: 300))
              .slide(
                begin: const Offset(0, 0.5),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutQuad,
              ),
              
              const SizedBox(height: 16),
              
              // Tagline
              const Text(
                'Master Your Preparation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 800), delay: const Duration(milliseconds: 600))
              .slide(
                begin: const Offset(0, 0.5),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutQuad,
              ),
              
              const SizedBox(height: 80),
              
              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 800), delay: const Duration(milliseconds: 1000)),
            ],
          ),
        ),
      ),
    );
  }
}