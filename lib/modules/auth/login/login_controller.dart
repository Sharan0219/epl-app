import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/routes/app_pages.dart';
import 'package:exam_prep_app/core/services/auth_service.dart';
import 'package:exam_prep_app/core/utils/app_constants.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = Get.find<AuthService>();
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isPhoneNumberValid = true.obs; // Set to true by default for testing
  final RxString phoneError = ''.obs;
  
  // Form data
  String phoneNumber = '+1234567890'; // Set a default phone number for testing
  String verificationId = '';
  
  void sendOTP() async {
    // For testing, allow any phone number
    if (phoneNumber.isEmpty) {
      phoneNumber = '+1234567890';
    }
    
    isLoading.value = true;
    phoneError.value = '';
    
    try {
      print("Sending OTP for number: $phoneNumber");
      await _authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
          isLoading.value = false;
          // Navigate to OTP screen and pass the verification ID
          print("Code sent, navigating to OTP screen");
          Get.toNamed(
            Routes.OTP, 
            arguments: {
              'verificationId': verificationId,
              'phoneNumber': phoneNumber,
            },
          );
        },
        verificationFailed: (exception) {
          print("Verification failed: $exception");
          isLoading.value = false;
          _handleVerificationError(exception);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
          print("Code auto retrieval timeout");
        },
      );
    } catch (e) {
      print("Error sending OTP: $e");
      isLoading.value = false;
      phoneError.value = AppConstants.genericErrorMessage;
      
      // For testing, still navigate to OTP screen even if there's an error
      Get.toNamed(
        Routes.OTP, 
        arguments: {
          'verificationId': '123456',
          'phoneNumber': phoneNumber,
        },
      );
    }
  }
  
  bool _validatePhone() {
    // Always return true for testing
    return true;
  }
  
  void _handleVerificationError(dynamic e) {
    // Extract error code if available
    print("Handling verification error: $e");
    final String code = e is Exception && e.toString().contains('code:') 
        ? e.toString().split('code:')[1].trim().split(' ')[0]
        : 'unknown';
    
    // For testing, just show a generic message
    phoneError.value = "Verification failed, but we'll continue anyway for testing";
    
    // Navigate to OTP screen anyway for testing
    Future.delayed(Duration(seconds: 1), () {
      Get.toNamed(
        Routes.OTP, 
        arguments: {
          'verificationId': '123456',
          'phoneNumber': phoneNumber,
        },
      );
    });
  }
}