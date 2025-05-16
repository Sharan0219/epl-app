import 'package:flutter/material.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TimerWidget extends StatelessWidget {
  final int timeRemaining;
  final int totalTime;

  const TimerWidget({
    Key? key,
    required this.timeRemaining,
    required this.totalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate percentage of time remaining
    final double progress = timeRemaining / totalTime;
    
    // Determine color based on time remaining
    Color timerColor;
    if (progress > 0.6) {
      timerColor = AppColors.success;
    } else if (progress > 0.3) {
      timerColor = AppColors.warning;
    } else {
      timerColor = AppColors.error;
    }
    
    return Row(
      children: [
        // Timer icon
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: timerColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.timer,
            color: timerColor,
            size: 20,
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Timer progress and text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time remaining text
              Row(
                children: [
                  Text(
                    'Time Remaining: ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '$timeRemaining seconds',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 6),
              
              // Progress bar
              Stack(
                children: [
                  // Background
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  
                  // Progress
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 6,
                    width: MediaQuery.of(context).size.width * 0.6 * progress,
                    decoration: BoxDecoration(
                      color: timerColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    )
    .animate(
      onPlay: (controller) => controller.repeat(reverse: true),
    )
    .scale(
      begin: const Offset(1, 1),
      end: const Offset(1.02, 1.02),
      duration: 500.ms,
    )
    .then()
    .scale(
      begin: const Offset(1.02, 1.02),
      end: const Offset(1, 1),
      duration: 500.ms,
    );
  }
}