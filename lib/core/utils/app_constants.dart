class AppConstants {
  AppConstants._();
  
  // API URLs
  static const String apiBaseUrl = 'https://api.examprep.example.com/v1';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String challengesCollection = 'challenges';
  static const String questionsCollection = 'questions';
  static const String answersCollection = 'answers';
  
  // Storage Paths
  static const String profileImagesPath = 'profile_images';
  static const String documentsPath = 'documents';
  
  // App Constants
  static const int otpLength = 4;
  static const int otpResendSeconds = 30;
  static const int defaultQuestionTimeLimit = 60; // seconds
  
  // Animation Durations
  static const int splashDuration = 2000; // milliseconds
  static const int normalAnimationDuration = 300; // milliseconds
  static const int pageTransitionDuration = 300; // milliseconds
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String authErrorMessage = 'Authentication failed. Please try again.';
  
  // Success Messages
  static const String profileUpdateSuccess = 'Profile updated successfully!';
  static const String challengeCompletedMessage = 'Challenge completed successfully!';
  
  // Common Strings
  static const String appName = 'Exam Prep';
  static const String welcomeMessage = 'Welcome to Exam Prep!';
  static const String dailyChallengeTitle = 'Daily Challenge';
  
  // Font Sizes
  static const double headingFontSize = 24.0;
  static const double subheadingFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double smallFontSize = 14.0;
  
  // Exam Types
  static const List<String> examTypes = [
    'UPSC',
    'SSC',
    'Banking',
    'CAT',
    'GATE',
    'NEET',
    'JEE',
    'CLAT',
    'GRE',
    'GMAT',
    'Other',
  ];
}