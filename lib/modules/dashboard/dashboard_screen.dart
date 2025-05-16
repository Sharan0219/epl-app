import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:exam_prep_app/widgets/app_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => controller.isLoading.value
            ? _buildLoadingScreen()
            : _buildDashboardContent(context)),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshDashboard,
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top App Bar with profile
            _buildProfileHeader(context),
            
            const SizedBox(height: 24),
            
            // Daily Challenge Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildDailyChallengeCard(context),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slide(begin: const Offset(0, 0.2)),
            
            const SizedBox(height: 24),
            
            // Stats Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildStatsSection(context),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 300.ms)
            .slide(begin: const Offset(0, 0.2)),
            
            const SizedBox(height: 24),
            
            // Recent Activity
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildRecentActivitySection(context),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slide(begin: const Offset(0, 0.2)),
            
            const SizedBox(height: 24),
            
            // Featured Exams
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildFeaturedExamsSection(context),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 500.ms)
            .slide(begin: const Offset(0, 0.2)),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Greeting and Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Good ${controller.greeting}',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userName,
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Preparing for ${controller.userExam}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Profile Picture and Menu
          Row(
            children: [
              // Profile Picture
              GestureDetector(
                onTap: () {
                  // Show profile options
                  controller.showProfileOptions();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.lightSurface,
                    backgroundImage: controller.userImage.isNotEmpty
                        ? CachedNetworkImageProvider(controller.userImage)
                        : null,
                    child: controller.userImage.isEmpty
                        ? Text(
                            controller.userInitials,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Menu
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: controller.openMenu,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallengeCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.startDailyChallenge,
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Daily Challenge Title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flash_on_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Daily Challenge',
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  speed: const Duration(milliseconds: 100),
                                ),
                              ],
                              totalRepeatCount: 1,
                              displayFullTextOnTap: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            controller.todayDate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Timer Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.timer,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Challenge Info
                Text(
                  controller.dailyChallengeTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  controller.dailyChallengeDescription,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 20),
                
                // Start Button
                AppButton(
                  text: 'Start Challenge',
                  onPressed: controller.startDailyChallenge,
                  backgroundColor: Colors.white,
                  textColor: AppColors.primary,
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.primary,
                  ),
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Your Statistics',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        
        const SizedBox(height: 16),
        
        // Stats Grid
        Row(
          children: [
            _buildStatCard(
              context,
              'Total Score',
              controller.stats.totalScore.toString(),
              Icons.stars_rounded,
              AppColors.secondary,
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              context,
              'Rank',
              '#${controller.stats.rank}',
              Icons.leaderboard_rounded,
              AppColors.accent,
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Row(
          children: [
            _buildStatCard(
              context,
              'Accuracy',
              '${controller.stats.accuracy}%',
              Icons.check_circle_outline_rounded,
              AppColors.success,
            ),
            const SizedBox(width: 16),
            _buildStatCard(
              context,
              'Challenges',
              controller.stats.challengesCompleted.toString(),
              Icons.emoji_events_rounded,
              AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with View All
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: controller.viewAllActivity,
              child: Text(
                'View All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Activity List
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.recentActivities.length,
          itemBuilder: (context, index) {
            final activity = controller.recentActivities[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Activity Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: activity.iconColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        activity.icon,
                        color: activity.iconColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Activity Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          activity.subtitle,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Activity Time
                  Text(
                    activity.time,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedExamsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Featured Exams',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        
        const SizedBox(height: 16),
        
        // Horizontal Scrollable Cards
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.featuredExams.length,
            itemBuilder: (context, index) {
              final exam = controller.featuredExams[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => controller.viewExamDetails(exam),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Exam Icon
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: exam.color.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                exam.icon,
                                color: exam.color,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Exam Name
                          Text(
                            exam.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Exam Details
                          Text(
                            '${exam.questionsCount} Questions',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Difficulty Level
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: exam.difficultyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              exam.difficulty,
                              style: TextStyle(
                                color: exam.difficultyColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}