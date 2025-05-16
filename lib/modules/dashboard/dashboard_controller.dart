import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/routes/app_pages.dart';
import 'package:exam_prep_app/core/services/auth_service.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';
import 'package:exam_prep_app/core/services/api_service.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:exam_prep_app/models/stats_model.dart';
import 'package:exam_prep_app/models/activity_model.dart';
import 'package:exam_prep_app/models/exam_model.dart';
import 'package:intl/intl.dart';


class DashboardController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final StorageService _storageService = Get.find<StorageService>();
  final ApiService _apiService = Get.find<ApiService>();
  
  // Observable variables
  final RxBool isLoading = true.obs;
  
  // User info
  late String userName;
  late String userExam;
  late String userImage;
  late String userInitials;
  
  // Dashboard data
  late String greeting;
  late String todayDate;
  late String dailyChallengeTitle;
  late String dailyChallengeDescription;
  late StatsModel stats;
  late List<ActivityModel> recentActivities;
  late List<ExamModel> featuredExams;
  
  @override
  void onInit() {
    super.onInit();
    _loadUserInfo();
    _loadDashboardData();
  }
  
  void _loadUserInfo() {
    // Get user info from storage
    userName = _storageService.getUserName();
    userExam = _storageService.getUserExam();
    userImage = _storageService.getUserImage();
    
    // Get user initials for avatar
    if (userName.isNotEmpty) {
      List<String> nameParts = userName.split(' ');
      if (nameParts.length > 1) {
        userInitials = '${nameParts[0][0]}${nameParts[1][0]}';
      } else {
        userInitials = userName.substring(0, 1);
      }
    } else {
      userInitials = 'U';
    }
    
    // Set greeting based on time of day
    int hour = DateTime.now().hour;
    if (hour < 12) {
      greeting = 'Morning';
    } else if (hour < 17) {
      greeting = 'Afternoon';
    } else {
      greeting = 'Evening';
    }
    
    // Set today's date
    todayDate = DateFormat('EEEE, d MMMM').format(DateTime.now());
  }
  
  Future<void> _loadDashboardData() async {
    isLoading.value = true;
    
    try {
      // Get daily challenge data from API
      final challengeData = await _apiService.getMockDailyChallenge();
      dailyChallengeTitle = challengeData['title'] ?? 'Daily Challenge';
      dailyChallengeDescription = challengeData['description'] ?? 'Test your knowledge with these challenging questions!';
      
      // Load user stats
      stats = StatsModel(
        totalScore: 1250,
        rank: 42,
        accuracy: 78,
        challengesCompleted: 15,
      );
      
      // Load recent activities
      recentActivities = [
        ActivityModel(
          title: 'Completed Daily Challenge',
          subtitle: 'General Knowledge Quiz',
          time: '1h ago',
          icon: Icons.task_alt_rounded,
          iconColor: AppColors.success,
        ),
        ActivityModel(
          title: 'Earned 150 Points',
          subtitle: 'Science Quiz',
          time: '3h ago',
          icon: Icons.stars_rounded,
          iconColor: AppColors.secondary,
        ),
        ActivityModel(
          title: 'Improved Accuracy',
          subtitle: 'From 72% to 78%',
          time: '1d ago',
          icon: Icons.trending_up_rounded,
          iconColor: AppColors.accent,
        ),
      ];
      
      // Load featured exams
      featuredExams = [
        ExamModel(
          name: 'UPSC Prelims',
          questionsCount: 100,
          difficulty: 'Advanced',
          difficultyColor: AppColors.error,
          color: AppColors.primary,
          icon: Icons.library_books_rounded,
        ),
        ExamModel(
          name: 'Banking',
          questionsCount: 75,
          difficulty: 'Intermediate',
          difficultyColor: AppColors.warning,
          color: AppColors.secondary,
          icon: Icons.account_balance_rounded,
        ),
        ExamModel(
          name: 'SSC',
          questionsCount: 50,
          difficulty: 'Beginner',
          difficultyColor: AppColors.success,
          color: AppColors.accent,
          icon: Icons.school_rounded,
        ),
        ExamModel(
          name: 'GATE',
          questionsCount: 65,
          difficulty: 'Advanced',
          difficultyColor: AppColors.error,
          color: AppColors.info,
          icon: Icons.engineering_rounded,
        ),
      ];
      
      isLoading.value = false;
    } catch (e) {
      // Set default values in case of error
      dailyChallengeTitle = 'Daily Challenge';
      dailyChallengeDescription = 'Test your knowledge with these challenging questions!';
      
      stats = StatsModel(
        totalScore: 0,
        rank: 0,
        accuracy: 0,
        challengesCompleted: 0,
      );
      
      recentActivities = [];
      featuredExams = [];
      
      isLoading.value = false;
    }
  }
  
  Future<void> refreshDashboard() async {
    await _loadDashboardData();
  }
  
  void startDailyChallenge() {
    Get.toNamed(Routes.GAME_ROOM);
  }
  
  void viewAllActivity() {
    // Navigate to activity history screen (not implemented in MVP)
    Get.snackbar(
      'Coming Soon',
      'Activity history will be available in the next update!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void viewExamDetails(ExamModel exam) {
    // Navigate to exam details screen (not implemented in MVP)
    Get.snackbar(
      'Coming Soon',
      'Exam details will be available in the next update!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void showProfileOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).cardTheme.color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile header with drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            // Profile info
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.lightSurface,
                  backgroundImage: userImage.isNotEmpty
                      ? NetworkImage(userImage)
                      : null,
                  child: userImage.isEmpty
                      ? Text(
                          userInitials,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Preparing for $userExam',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Options
            _buildProfileOption(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                Get.back();
                // Navigate to edit profile screen (not implemented in MVP)
                Get.snackbar(
                  'Coming Soon',
                  'Profile editing will be available in the next update!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                Get.back();
                // Navigate to settings screen (not implemented in MVP)
                Get.snackbar(
                  'Coming Soon',
                  'Settings will be available in the next update!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
            
            _buildProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                Get.back();
                // Navigate to help screen (not implemented in MVP)
                Get.snackbar(
                  'Coming Soon',
                  'Help & Support will be available in the next update!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
            
            const SizedBox(height: 8),
            
            const Divider(),
            
            _buildProfileOption(
              icon: Icons.logout,
              title: 'Logout',
              textColor: AppColors.error,
              iconColor: AppColors.error,
              onTap: () {
                Get.back();
                _showLogoutConfirmation();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required Function() onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textMuted,
      ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
  
  void _showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _authService.signOut();
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void openMenu() {
    // Open drawer or menu (not implemented in MVP)
    Get.snackbar(
      'Coming Soon',
      'Additional menu options will be available in the next update!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}