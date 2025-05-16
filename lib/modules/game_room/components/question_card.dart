import 'package:flutter/material.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:exam_prep_app/models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final Function(String) onAnswerSelected;
  final String? selectedAnswer;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.onAnswerSelected,
    this.selectedAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: const Color(0xFF273C65),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question type badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        question.type == 'mcq'
                            ? Icons.check_box_outlined
                            : Icons.text_fields_outlined,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        question.type == 'mcq'
                            ? 'Multiple Choice'
                            : 'Fill in the Blank',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.1, end: 0),
            
            const SizedBox(height: 20),
            
            // Question text
            Text(
              question.question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: 100.ms)
            .slideY(begin: -0.05, end: 0),
            
            const SizedBox(height: 24),
            
            // Answers section
            Expanded(
              child: question.type == 'mcq'
                  ? _buildMultipleChoiceOptions()
                  : _buildFillInTheBlank(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceOptions() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: question.options?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final option = question.options![index];
        final isSelected = selectedAnswer == option;
        
        return GestureDetector(
          onTap: () {
            if (selectedAnswer == null) {
              onAnswerSelected(option);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          )
                        : Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms + (100.ms * index))
        .slideX(begin: 0.05, end: 0);
      },
    );
  }

  Widget _buildFillInTheBlank() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Instruction
        Text(
          'Type your answer below:',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms),
        
        const SizedBox(height: 16),
        
        // Answer text field
        TextFormField(
          initialValue: selectedAnswer != 'SKIPPED' ? selectedAnswer : '',
          readOnly: selectedAnswer != null,
          onChanged: (value) {},
          onFieldSubmitted: onAnswerSelected,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            hintText: 'Enter your answer...',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: selectedAnswer == null
                ? IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      // Would need to access the current value from controller
                    },
                  )
                : selectedAnswer != 'SKIPPED'
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                      )
                    : const Icon(
                        Icons.skip_next,
                        color: Colors.orange,
                      ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 300.ms),
      ],
    );
  }
}