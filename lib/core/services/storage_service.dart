import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Key constants
  static const String _userIdKey = 'userId';
  static const String _phoneNumberKey = 'phoneNumber';
  static const String _profileCompleteKey = 'profileComplete';
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _audioEnabledKey = 'audioEnabled';
  static const String _userNameKey = 'userName';
  static const String _userExamKey = 'userExam';
  static const String _userImageKey = 'userImage';
  static const String _lastSessionKey = 'lastSession';

  // User ID
  String getUserId() => _prefs.getString(_userIdKey) ?? '';
  Future<bool> setUserId(String userId) => _prefs.setString(_userIdKey, userId);

  // Phone Number
  String getPhoneNumber() => _prefs.getString(_phoneNumberKey) ?? '';
  Future<bool> setPhoneNumber(String phoneNumber) => _prefs.setString(_phoneNumberKey, phoneNumber);

  // Profile Completion
  bool isProfileComplete() => _prefs.getBool(_profileCompleteKey) ?? false;
  Future<bool> setProfileComplete(bool isComplete) => _prefs.setBool(_profileCompleteKey, isComplete);

  // Dark Mode
  bool isDarkMode() => _prefs.getBool(_isDarkModeKey) ?? false;
  Future<bool> setDarkMode(bool isDarkMode) => _prefs.setBool(_isDarkModeKey, isDarkMode);

  // Audio Settings
  bool isAudioEnabled() => _prefs.getBool(_audioEnabledKey) ?? true;
  Future<bool> setAudioEnabled(bool isEnabled) => _prefs.setBool(_audioEnabledKey, isEnabled);

  // User Name
  String getUserName() => _prefs.getString(_userNameKey) ?? '';
  Future<bool> setUserName(String name) => _prefs.setString(_userNameKey, name);

  // User Exam
  String getUserExam() => _prefs.getString(_userExamKey) ?? '';
  Future<bool> setUserExam(String exam) => _prefs.setString(_userExamKey, exam);

  // User Image
  String getUserImage() => _prefs.getString(_userImageKey) ?? '';
  Future<bool> setUserImage(String imageUrl) => _prefs.setString(_userImageKey, imageUrl);

  // Last Session Timestamp
  int getLastSessionTimestamp() => _prefs.getInt(_lastSessionKey) ?? 0;
  Future<bool> setLastSessionTimestamp(int timestamp) => _prefs.setInt(_lastSessionKey, timestamp);

  // Generic methods for any data types
  // Added methods that were missing
  bool? getBool(String key) => _prefs.getBool(key);
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  
  String? getString(String key) => _prefs.getString(key);
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);
  
  int? getInt(String key) => _prefs.getInt(key);
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);
  
  double? getDouble(String key) => _prefs.getDouble(key);
  Future<bool> setDouble(String key, double value) => _prefs.setDouble(key, value);

  // Game Settings
  Future<bool> setGameSettings({required Map<String, dynamic> settings}) async {
    for (var entry in settings.entries) {
      if (entry.value is String) {
        await _prefs.setString(entry.key, entry.value);
      } else if (entry.value is bool) {
        await _prefs.setBool(entry.key, entry.value);
      } else if (entry.value is int) {
        await _prefs.setInt(entry.key, entry.value);
      } else if (entry.value is double) {
        await _prefs.setDouble(entry.key, entry.value);
      }
    }
    return true;
  }

  Map<String, dynamic> getGameSettings() {
    return {
      'timerEnabled': _prefs.getBool('timerEnabled') ?? true,
      'skipEnabled': _prefs.getBool('skipEnabled') ?? true,
      'musicEnabled': _prefs.getBool('musicEnabled') ?? true,
      'defaultTimerSeconds': _prefs.getInt('defaultTimerSeconds') ?? 60,
      'lastPlayedDate': _prefs.getString('lastPlayedDate') ?? '',
    };
  }

  // Clear all user data (for logout)
  Future<void> clearUserData() async {
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_phoneNumberKey);
    await _prefs.remove(_profileCompleteKey);
    await _prefs.remove(_userNameKey);
    await _prefs.remove(_userExamKey);
    await _prefs.remove(_userImageKey);
    await _prefs.remove(_lastSessionKey);
    // Don't clear theme and audio preferences on logout
  }

  // Clear all data (for testing/reset)
  Future<bool> clearAll() => _prefs.clear();
}