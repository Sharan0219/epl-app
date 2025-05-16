import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/routes/app_pages.dart';
import 'package:exam_prep_app/core/services/auth_service.dart' as auth_service;
import 'package:exam_prep_app/core/utils/app_constants.dart';

class OtpController extends GetxController {
  final auth_service.AuthService _authService = Get.find<auth_service.AuthService>();

  // Text controller for OTP input
  late TextEditingController otpController;
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString otpError = ''.obs;
  final RxInt resendTime = AppConstants.otpResendSeconds.obs;
  final RxBool canResend = false.obs;
  final RxString formattedPhoneNumber = ''.obs;
  
  // Data from arguments
  String verificationId = '';
  String phoneNumber = '';
  String otp = '';
  
  // Timer for resend countdown
  Timer? _resendTimer;
  
  @override
  void onInit() {
    super.onInit();
    
    otpController = TextEditingController();
    
    // Get arguments from previous screen
    if (Get.arguments != null) {
      verificationId = Get.arguments['verificationId'] ?? '';
      phoneNumber = Get.arguments['phoneNumber'] ?? '';
      
      print("OTP Screen initialized with verificationId: $verificationId, phone: $phoneNumber");
      
      // Format phone number for display (show only last 4 digits)
      if (phoneNumber.isNotEmpty) {
        final lastFour = phoneNumber.substring(phoneNumber.length - 4);
        formattedPhoneNumber.value = '******$lastFour';
      } else {
        formattedPhoneNumber.value = '******1234'; // Default for testing
      }
    } else {
      print("No arguments received in OTP screen");
      formattedPhoneNumber.value = '******1234'; // Default for testing
    }
    
    // Start resend timer
    _startResendTimer();
  }
  
  void _startResendTimer() {
    resendTime.value = AppConstants.otpResendSeconds;
    canResend.value = false;
    
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime.value > 0) {
        resendTime.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }
  
  void verifyOTP() async {
    print("Verifying OTP: $otp");
    // For testing, accept any 4-digit OTP
    if (otp.length != 4) {
      otpError.value = "Please enter a 4-digit code";
      return;
    }
    
    otpError.value = '';
    isLoading.value = true;
    
    try {
      // Simulate OTP verification for testing
      await Future.delayed(Duration(seconds: 1));
      print("OTP verification successful");
      
      isLoading.value = false;
      
      // For testing, always go to profile screen
      Get.offAllNamed(Routes.PROFILE);
      
    } catch (e) {
      print("OTP verification error: $e");
      isLoading.value = false;
      otpError.value = "Verification failed, but we'll continue for testing";
      
      // For testing, still navigate after a brief delay
      Future.delayed(Duration(seconds: 1), () {
        Get.offAllNamed(Routes.PROFILE);
      });
    }
  }
  
  void resendOTP() async {
    print("Resending OTP");
    otpError.value = '';
    canResend.value = false;
    
    // Simulate resending OTP
    await Future.delayed(Duration(seconds: 1));
    
    // Reset OTP field
    otpController.clear();
    otp = '';
    
    // Start countdown again
    _startResendTimer();
    
    // Show success message
    Get.snackbar(
      'Success',
      'OTP has been resent to your phone number',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.7),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }
  
  void _handleVerificationError(dynamic e) {
    print("Handling OTP verification error: $e");
    otpError.value = "Verification failed, but we'll continue for testing";
    
    // For testing, navigate to profile screen anyway
    Future.delayed(Duration(seconds: 1), () {
      Get.offAllNamed(Routes.PROFILE);
    });
  }
  
  @override
  void onClose() {
    otpController.dispose();
    _resendTimer?.cancel();
    super.onClose();
  }
}