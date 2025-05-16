import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:exam_prep_app/core/routes/app_pages.dart';
import 'package:exam_prep_app/core/services/auth_service.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';
import 'package:exam_prep_app/core/utils/app_constants.dart';

// Mock implementation to replace FirebaseStorage
class MockStorageService {
  static final MockStorageService instance = MockStorageService._();
  
  MockStorageService._();
  
  Future<String> uploadFile(File file, String path) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return a fake URL
    return 'https://example.com/uploads/${path.replaceAll('/', '_')}';
  }
}

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = Get.find<AuthService>();
  final StorageService _storageService = Get.find<StorageService>();
  
  // Mock storage service instead of FirebaseStorage
  final _mockStorage = MockStorageService.instance;
  
  // Text controllers
  late TextEditingController nameController;
  late TextEditingController addressController;
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedExam = ''.obs;
  final Rx<File?> imageFile = Rx<File?>(null);
  final Rx<File?> panCardFile = Rx<File?>(null);
  
  // Image picker
  final ImagePicker _imagePicker = ImagePicker();
  
  @override
  void onInit() {
    super.onInit();
    
    nameController = TextEditingController();
    addressController = TextEditingController();
  }
  
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    } catch (e) {
      errorMessage.value = 'Failed to pick image. Please try again.';
    }
  }
  
  Future<void> pickPanCard() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );
      
      if (result != null) {
        panCardFile.value = File(result.files.single.path!);
      }
    } catch (e) {
      errorMessage.value = 'Failed to pick file. Please try again.';
    }
  }
  
  void submitProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      String? profileImageUrl;
      String? panCardUrl;
      
      // Upload profile image if selected
      if (imageFile.value != null) {
        profileImageUrl = await _uploadFile(
          imageFile.value!,
          '${AppConstants.profileImagesPath}/${_authService.userId}',
        );
      }
      
      // Upload PAN card if selected
      if (panCardFile.value != null) {
        panCardUrl = await _uploadFile(
          panCardFile.value!,
          '${AppConstants.documentsPath}/${_authService.userId}/pancard',
        );
      }
      
      // Create user profile
      await _authService.createUserProfile(
        name: nameController.text.trim(),
        examPreparingFor: selectedExam.value,
        address: addressController.text.trim(),
        profileImageUrl: profileImageUrl,
        panCardUrl: panCardUrl,
      );
      
      // Store user info in local storage
      _storageService.setUserName(nameController.text.trim());
      _storageService.setUserExam(selectedExam.value);
      if (profileImageUrl != null) {
        _storageService.setUserImage(profileImageUrl);
      }
      
      isLoading.value = false;
      
      // Navigate to dashboard
      Get.offAllNamed(Routes.DASHBOARD);
      
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = AppConstants.genericErrorMessage;
    }
  }
  
  Future<String> _uploadFile(File file, String path) async {
    try {
      // Use the mock storage service instead of Firebase
      return await _mockStorage.uploadFile(file, path);
    } catch (e) {
      throw Exception('File upload failed');
    }
  }
  
  void skipProfile() {
    // This is only for development/testing purposes
    Get.offAllNamed(Routes.DASHBOARD);
  }
  
  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    super.onClose();
  }
}