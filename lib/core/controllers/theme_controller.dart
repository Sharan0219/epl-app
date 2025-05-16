import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';

class ThemeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  
  final RxBool _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  
  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }
  
  void _loadThemeMode() {
    _isDarkMode.value = _storageService.isDarkMode();
    _updateTheme();
  }
  
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _storageService.setDarkMode(_isDarkMode.value);
    _updateTheme();
  }
  
  void _updateTheme() {
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}