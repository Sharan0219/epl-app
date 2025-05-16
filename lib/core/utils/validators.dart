class Validators {
  Validators._();
  
  /// Validates if the input is a valid phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    
    // Basic phone validation - can be enhanced for specific formats
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }
  
  /// Validates if the input is a valid name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    
    return null;
  }
  
  /// Validates if the input is a valid email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    
    // Email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }
  
  /// Validates if the input is a valid password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }
  
  /// Validates if the input matches the password
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  /// Validates if the input is not empty
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'Please enter ${fieldName ?? 'this field'}';
    }
    
    return null;
  }
  
  /// Validates if the input is a valid OTP
  static String? validateOtp(String? value, {int length = 4}) {
    if (value == null || value.isEmpty) {
      return 'Please enter the verification code';
    }
    
    if (value.length != length) {
      return 'Please enter a valid $length-digit code';
    }
    
    // Check if it contains only digits
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Code can only contain digits';
    }
    
    return null;
  }
  
  /// Validates if the input is a valid address
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    
    if (value.length < 5) {
      return 'Please enter a valid address';
    }
    
    return null;
  }
}