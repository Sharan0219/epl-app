import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_prep_app/core/services/auth_service.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';
import 'package:exam_prep_app/core/services/api_service.dart';
import 'package:exam_prep_app/core/services/audio_service.dart';

Future<void> initServices() async {
  // Initialize shared preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  Get.put(StorageService(sharedPrefs), permanent: true);

  // Initialize API service
  Get.put(ApiService(), permanent: true);

  // Initialize Auth service (without Firebase for now)
  Get.put(AuthService(), permanent: true);

  // Initialize Audio service
  Get.put(AudioService(), permanent: true);
}