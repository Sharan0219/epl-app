import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:exam_prep_app/widgets/app_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'game_room_controller.dart';
import 'components/question_card.dart';
import 'components/timer_widget.dart';
import 'components/game_controls.dart';

class GameRoomScreen extends GetView<GameRoomController> {
  const GameRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkBackground,
              Color(0xFF121A36),
            ],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return _buildLoadingScreen();
            } else if (controller.isGameOver.value) {
              return _buildGameOverScreen(context);
            } else {
              return _buildGameContent(context);
            }
          }),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: 24),
          Text(
            'Preparing your challenge...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameOverScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Trophy icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              size: 70,
              color: AppColors.primary,
            ),
          )
          .animate()
          .scale(
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
          ),
          
          SizedBox(height: 32),
          
          // Completion text
          Text(
            'Challenge Completed!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 200))
          .slideY(begin: 0.2, end: 0),
          
          SizedBox(height: 16),
          
          Text(
            'You have completed the daily challenge',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 300)),
          
          SizedBox(height: 48),
          
          // Score card
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildScoreItem(
                      title: 'Score',
                      value: '${controller.score.value}',
                      icon: Icons.stars_rounded,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    _buildScoreItem(
                      title: 'Correct',
                      value: '${controller.correctAnswers.value}/${controller.totalQuestions}',
                      icon: Icons.check_circle_outline_rounded,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    _buildScoreItem(
                      title: 'Time',
                      value: controller.formattedTotalTime,
                      icon: Icons.timer_outlined,
                    ),
                  ],
                ),
                
                SizedBox(height: 24),
                
                Text(
                  controller.performanceMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 500))
          .slideY(begin: 0.2, end: 0),
          
          SizedBox(height: 48),
          
          // Buttons
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'View Solutions',
                  isOutlined: true,
                  backgroundColor: Colors.transparent,
                  textColor: AppColors.primary,
                  onPressed: controller.viewSolutions,
                  icon: Icon(
                    Icons.visibility_outlined,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Return Home',
                  onPressed: controller.returnToDashboard,
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 700)),
        ],
      ),
    );
  }

  Widget _buildScoreItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildGameContent(BuildContext context) {
    return Column(
      children: [
        // Game header with progress and controls
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              // Question progress and settings
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Question counter
                  Obx(() => Text(
                    'Question ${controller.currentQuestionIndex.value + 1}/${controller.totalQuestions}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  
                  // Game settings button
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onPressed: controller.openGameSettings,
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              // Progress bar
              Obx(() => LinearProgressIndicator(
                value: (controller.currentQuestionIndex.value + 1) / controller.totalQuestions,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                borderRadius: BorderRadius.circular(10),
                minHeight: 6,
              )),
            ],
          ),
        ),
        
        SizedBox(height: 12),
        
        // Game controls (volume, timer)
        // UPDATE: Using non-reactive types now
        Obx(() => GameControls(
          isMusicPlaying: controller.isMusicPlaying.value,
          toggleMusic: controller.toggleMusic,
          isTimerActive: controller.showTimer,
          timeRemaining: controller.timeRemaining.value,
        )),
        
        // Main content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PageView.builder(
              controller: controller.pageController,
              physics: NeverScrollableScrollPhysics(), // Disable swiping
              itemCount: controller.questions.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                final question = controller.questions[index];
                
                return QuestionCard(
                  question: question,
                  onAnswerSelected: controller.submitAnswer,
                  selectedAnswer: controller.selectedAnswers[index],
                );
              },
            ),
          ),
        ),
        
        // Bottom navigation
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Skip button (if enabled)
              Obx(() => controller.skipEnabled.value
                  ? Expanded(
                      child: AppButton(
                        text: 'Skip',
                        isOutlined: true,
                        backgroundColor: Colors.transparent,
                        textColor: Colors.white,
                        onPressed: controller.skipQuestion,
                        icon: Icon(
                          Icons.skip_next_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : SizedBox.shrink()),
                  
              Obx(() => controller.skipEnabled.value
                  ? SizedBox(width: 16)
                  : SizedBox.shrink()),
              
              // Next/Submit button
              Expanded(
                child: Obx(() => AppButton(
                  text: controller.isLastQuestion
                      ? 'Submit'
                      : 'Next',
                  onPressed: controller.selectedAnswers[controller.currentQuestionIndex.value] != null
                      ? controller.nextQuestion
                      : null,
                  backgroundColor: controller.selectedAnswers[controller.currentQuestionIndex.value] != null
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.5),
                  icon: Icon(
                    controller.isLastQuestion
                        ? Icons.check_circle_outline_rounded
                        : Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}