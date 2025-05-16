import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_prep_app/core/routes/app_pages.dart';
import 'package:exam_prep_app/core/services/api_service.dart';
import 'package:exam_prep_app/core/services/audio_service.dart';
import 'package:exam_prep_app/core/services/storage_service.dart';
import 'package:exam_prep_app/models/question_model.dart';
import 'package:exam_prep_app/models/answer_model.dart';

class GameRoomController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final AudioService _audioService = Get.find<AudioService>();
  final StorageService _storageService = Get.find<StorageService>();
  
  // Page controller for questions
  late PageController pageController;
  
  // Observable variables
  final RxBool isLoading = true.obs;
  final RxBool isGameOver = false.obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxInt score = 0.obs;
  final RxInt correctAnswers = 0.obs;
  final RxInt timeRemaining = 30.obs;
  final RxBool isMusicPlaying = true.obs;
  final RxBool skipEnabled = true.obs;
  
  // Game state
  late List<QuestionModel> questions;
  late List<String?> selectedAnswers;
  late int totalQuestions;
  late bool showTimer;
  late int totalTime;
  String performanceMessage = 'Great job!';
  Timer? _questionTimer;
  
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _loadGameData();
    _startBackgroundMusic();
  }
  
  Future<void> _loadGameData() async {
    isLoading.value = true;
    
    try {
      // Load challenge data from API
      final challengeData = await _apiService.getMockDailyChallenge();
      
      // Parse questions
      final questionsData = challengeData['questions'] as List;
      questions = questionsData.map((q) => QuestionModel.fromJson(q)).toList();
      totalQuestions = questions.length;
      
      // Initialize selected answers list
      selectedAnswers = List.filled(totalQuestions, null);
      
      // Load game settings
      final settings = challengeData['settings'] as Map<String, dynamic>;
      skipEnabled.value = settings['skipEnabled'] ?? true;
      showTimer = settings['showTimer'] ?? true;
      isMusicPlaying.value = settings['musicEnabled'] ?? true;
      
      // Save settings to local storage
      _storageService.setGameSettings(settings: settings);
      
      isLoading.value = false;
      
      // Start timer for first question
      if (showTimer) {
        _startQuestionTimer();
      }
      
    } catch (e) {
      // Handle error - create mock data
      questions = [
        QuestionModel(
          id: 'q1',
          type: 'mcq',
          question: 'What is the capital of France?',
          options: ['London', 'Berlin', 'Paris', 'Madrid'],
          timeLimit: 30,
        ),
      ];
      totalQuestions = questions.length;
      selectedAnswers = List.filled(totalQuestions, null);
      skipEnabled.value = true;
      showTimer = true;
      
      isLoading.value = false;
      
      // Start timer for first question
      if (showTimer) {
        _startQuestionTimer();
      }
    }
  }
  
  void _startBackgroundMusic() {
    if (isMusicPlaying.value) {
      _audioService.playBackgroundMusic();
    }
  }
  
  void toggleMusic() {
    isMusicPlaying.value = !isMusicPlaying.value;
    
    if (isMusicPlaying.value) {
      _audioService.resumeBackgroundMusic();
    } else {
      _audioService.pauseBackgroundMusic();
    }
  }
  
  void _startQuestionTimer() {
    // Cancel any existing timer
    _questionTimer?.cancel();
    
    // Get time limit for current question
    final question = questions[currentQuestionIndex.value];
    timeRemaining.value = question.timeLimit;
    
    // Start new timer
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
        
        // Play sound when time is running low
        if (timeRemaining.value <= 5 && timeRemaining.value > 0) {
          _audioService.playTimerTickSound();
        }
      } else {
        // Time's up, auto-submit if answer not selected
        timer.cancel();
        if (selectedAnswers[currentQuestionIndex.value] == null) {
          // Timeout - no answer selected
          if (currentQuestionIndex.value < totalQuestions - 1) {
            nextQuestion();
          } else {
            endGame();
          }
        }
      }
    });
  }
  
  void submitAnswer(String answer) {
    // Play sound effect
    _audioService.playButtonClickSound();
    
    // Store the answer
    selectedAnswers[currentQuestionIndex.value] = answer;
    
    // Check if correct (for MCQ questions)
    final currentQuestion = questions[currentQuestionIndex.value];
    if (currentQuestion.type == 'mcq') {
      // For the mock data, let's assume the third option (index 2) is always correct
      if (answer == currentQuestion.options![2]) {
        // Correct answer
        _audioService.playCorrectAnswerSound();
        correctAnswers.value++;
        score.value += 10;
        
        // Add time bonus if answered quickly
        if (timeRemaining.value > currentQuestion.timeLimit / 2) {
          score.value += 5;
        }
      } else {
        // Incorrect answer
        _audioService.playWrongAnswerSound();
      }
    } else if (currentQuestion.type == 'fill_blank') {
      // For fill-in-the-blank, we'd need to check against correct answers
      // For demo purposes:
      if (currentQuestion.id == 'q3' && answer.toLowerCase() == 'au') {
        // Correct answer for gold symbol question
        _audioService.playCorrectAnswerSound();
        correctAnswers.value++;
        score.value += 15; // More points for fill-in-blank
      } else if (currentQuestion.id == 'q5' && answer.toLowerCase().contains('pacific')) {
        // Correct answer for largest ocean question
        _audioService.playCorrectAnswerSound();
        correctAnswers.value++;
        score.value += 15;
      } else {
        // Incorrect answer
        _audioService.playWrongAnswerSound();
      }
    }
  }
  
  void nextQuestion() {
    // Stop the current timer
    _questionTimer?.cancel();
    
    // If last question, end game
    if (currentQuestionIndex.value >= totalQuestions - 1) {
      endGame();
      return;
    }
    
    // Move to next question
    currentQuestionIndex.value++;
    pageController.animateToPage(
      currentQuestionIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    
    // Start timer for new question
    if (showTimer) {
      _startQuestionTimer();
    }
  }
  
  void skipQuestion() {
    if (!skipEnabled.value) return;
    
    // Play button click sound
    _audioService.playButtonClickSound();
    
    // Set answer as skipped
    selectedAnswers[currentQuestionIndex.value] = "SKIPPED";
    
    // Move to next question
    nextQuestion();
  }
  
  void onPageChanged(int index) {
    currentQuestionIndex.value = index;
    
    // Restart timer when page changes
    if (showTimer) {
      _startQuestionTimer();
    }
  }
  
  bool get isLastQuestion => currentQuestionIndex.value >= totalQuestions - 1;
  
  String get formattedTotalTime {
    // Calculate total time taken (assuming each question had a time limit)
    int totalSeconds = questions.fold(0, (prev, q) => prev + q.timeLimit);
    
    // Format into minutes and seconds
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
  
  void endGame() {
    // Cancel any active timer
    _questionTimer?.cancel();
    
    // Calculate performance message based on score
    if (correctAnswers.value == totalQuestions) {
      performanceMessage = 'Perfect! You aced the challenge!';
    } else if (correctAnswers.value >= totalQuestions * 0.8) {
      performanceMessage = 'Excellent work! You\'re doing great!';
    } else if (correctAnswers.value >= totalQuestions * 0.6) {
      performanceMessage = 'Good job! Keep practicing!';
    } else if (correctAnswers.value >= totalQuestions * 0.4) {
      performanceMessage = 'Nice effort! Room for improvement.';
    } else {
      performanceMessage = 'Keep practicing, you\'ll get better!';
    }
    
    // Play game over sound
    _audioService.playGameOverSound();
    
    // Show game over screen
    isGameOver.value = true;
  }
  
  void viewSolutions() {
    // Not implemented in MVP
    Get.snackbar(
      'Coming Soon',
      'Solutions will be available in the next update!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      colorText: Colors.white,
    );
  }
  
  void returnToDashboard() {
    // Stop background music
    _audioService.stopBackgroundMusic();
    
    // Return to dashboard
    Get.offAllNamed(Routes.DASHBOARD);
  }
  
  void openGameSettings() {
    // Show settings dialog
    Get.dialog(
      AlertDialog(
        title: Text('Game Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Music toggle
            ListTile(
              leading: Icon(
                isMusicPlaying.value ? Icons.music_note : Icons.music_off,
              ),
              title: Text('Background Music'),
              trailing: Switch(
                value: isMusicPlaying.value,
                onChanged: (value) {
                  Get.back();
                  toggleMusic();
                },
                activeColor: Colors.purple,
              ),
            ),
            
            // Skip toggle
            ListTile(
              leading: Icon(Icons.skip_next),
              title: Text('Allow Skipping'),
              trailing: Switch(
                value: skipEnabled.value,
                onChanged: (value) {
                  Get.back();
                  skipEnabled.value = value;
                },
                activeColor: Colors.purple,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              returnToDashboard();
            },
            child: Text(
              'Exit Game',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void onClose() {
    pageController.dispose();
    _questionTimer?.cancel();
    super.onClose();
  }
}