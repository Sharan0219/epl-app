import 'package:get/get.dart';
import 'package:exam_prep_app/core/routes/app_pages.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';

// Mock Firebase classes
class User {
  final String uid;
  final String? phoneNumber;
  
  User({required this.uid, this.phoneNumber});
}

class PhoneAuthCredential {
  final String verificationId;
  final String smsCode;
  
  PhoneAuthCredential({required this.verificationId, required this.smsCode});
}

class FirebaseAuthException implements Exception {
  final String code;
  final String message;
  
  FirebaseAuthException({required this.code, required this.message});
}

class AuthService extends GetxService {
  final StorageService _storageService = Get.find<StorageService>();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    
    // Check if user is logged in from storage
    final userId = _storageService.getUserId();
    if (userId.isNotEmpty) {
      user.value = User(
        uid: userId,
        phoneNumber: _storageService.getPhoneNumber(),
      );
    }
  }

  String get userId => user.value?.uid ?? '';
  bool get isLoggedIn => user.value != null;
  bool get isProfileComplete => _storageService.isProfileComplete();

  // Mock phone verification
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String, int?) codeSent,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Always send OTP for demo purposes
      final String verificationId = '123456';
      codeSent(verificationId, null);
    } catch (e) {
      verificationFailed(
        FirebaseAuthException(
          code: 'unknown',
          message: 'Failed to verify phone number',
        ),
      );
    }
  }

  // Mock sign in with credential
  Future<User> signInWithCredential(PhoneAuthCredential credential) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Create a mock user
    final mockUser = User(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      phoneNumber: '+1234567890',
    );
    
    // Update user value
    user.value = mockUser;
    
    // Save to storage
    _storageService.setUserId(mockUser.uid);
    _storageService.setPhoneNumber(mockUser.phoneNumber ?? '');
    
    return mockUser;
  }

  Future<void> signOut() async {
    // Clear user data
    user.value = null;
    _storageService.clearUserData();
    
    // Navigate to login
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<bool> checkIfUserExists() async {
    if (userId.isEmpty) return false;
    
    // For demo, return true if profile is complete
    return _storageService.isProfileComplete();
  }

  Future<void> createUserProfile({
    required String name,
    required String examPreparingFor,
    required String address,
    String? profileImageUrl,
    String? panCardUrl,
  }) async {
    if (userId.isEmpty) throw Exception('User not authenticated');
    
    // Save profile data to storage
    _storageService.setUserName(name);
    _storageService.setUserExam(examPreparingFor);
    if (profileImageUrl != null) {
      _storageService.setUserImage(profileImageUrl);
    }
    
    // Mark profile as complete
    _storageService.setProfileComplete(true);
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    if (userId.isEmpty) return null;
    
    // Return profile data from storage
    return {
      'uid': userId,
      'phoneNumber': user.value?.phoneNumber,
      'name': _storageService.getUserName(),
      'examPreparingFor': _storageService.getUserExam(),
      'address': 'Sample Address', // This would come from Firestore
      'profileImageUrl': _storageService.getUserImage(),
      'createdAt': DateTime.now().toString(),
      'updatedAt': DateTime.now().toString(),
    };
  }
}