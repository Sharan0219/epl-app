import 'package:get/get.dart';
import 'package:exam_prep_app/core/routes/app_pages.dart';
import 'package:exam_prep_app/core/services/auth_service.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final StorageService _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    print("SplashController initialized");
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 2));
    print("Splash delay complete");

    // Add explicit navigation regardless of auth status
    // You can uncomment the conditional logic later
    Get.offAllNamed(Routes.LOGIN);

    /*
    // For testing, let's print the current state
    print("isLoggedIn: ${_authService.isLoggedIn}");
    print("isProfileComplete: ${_authService.isProfileComplete}");

    // Check authentication status
    if (_authService.isLoggedIn) {
      if (_authService.isProfileComplete) {
        // User is logged in and profile is complete, go to dashboard
        print("Navigating to DASHBOARD");
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        // User is logged in but profile is incomplete, go to profile screen
        print("Navigating to PROFILE");
        Get.offAllNamed(Routes.PROFILE);
      }
    } else {
      // User is not logged in, go to login screen
      print("Navigating to LOGIN");
      Get.offAllNamed(Routes.LOGIN);
    }
    */
  }
}