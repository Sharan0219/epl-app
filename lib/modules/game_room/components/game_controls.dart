import 'package:flutter/material.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'timer_widget.dart';

class GameControls extends StatelessWidget {
  // Use simple types instead of reactive types
  final bool isMusicPlaying;
  final Function() toggleMusic;
  final bool isTimerActive;
  final int timeRemaining;

  const GameControls({
    Key? key,
    required this.isMusicPlaying,
    required this.toggleMusic,
    required this.isTimerActive,
    required this.timeRemaining,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Volume control
          GestureDetector(
            onTap: toggleMusic,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isMusicPlaying
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
                color: isMusicPlaying
                    ? AppColors.primary
                    : Colors.white.withOpacity(0.6),
                size: 24,
              ),
            ),
          ),
          
          // Timer (if active)
          if (isTimerActive)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TimerWidget(
                  timeRemaining: timeRemaining,
                  totalTime: 30, // Assuming default time limit
                ),
              ),
            ),
        ],
      ),
    );
  }
}