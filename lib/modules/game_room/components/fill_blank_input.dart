import 'package:flutter/material.dart';
import 'package:exam_prep_app/core/theme/app_colors.dart';

class FillBlankInput extends StatefulWidget {
  final String questionId;
  final Function(String) onSubmit;
  final String? initialValue;
  final bool readOnly;

  const FillBlankInput({
    Key? key,
    required this.questionId,
    required this.onSubmit,
    this.initialValue,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<FillBlankInput> createState() => _FillBlankInputState();
}

class _FillBlankInputState extends State<FillBlankInput> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    
    // Auto-focus on the text field when the widget is built
    if (!widget.readOnly) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_controller.text.isEmpty || _isSubmitting) return;
    
    setState(() {
      _isSubmitting = true;
    });
    
    widget.onSubmit(_controller.text);
    
    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fill in the blank:',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.readOnly
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            readOnly: widget.readOnly,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Type your answer here...',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              suffixIcon: !widget.readOnly
                  ? IconButton(
                      icon: Icon(
                        _isSubmitting ? Icons.hourglass_top : Icons.send,
                        color: AppColors.primary,
                      ),
                      onPressed: _handleSubmit,
                    )
                  : widget.initialValue == null || widget.initialValue == 'SKIPPED'
                      ? const Icon(
                          Icons.skip_next,
                          color: Colors.orange,
                        )
                      : const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                        ),
            ),
            onSubmitted: (value) {
              if (!widget.readOnly && value.isNotEmpty) {
                widget.onSubmit(value);
              }
            },
          ),
        ),
        
        if (widget.readOnly && widget.initialValue != null && widget.initialValue != 'SKIPPED')
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Correct answer: ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                Text(
                  _getCorrectAnswer(widget.questionId),
                  style: const TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Mock function to get the correct answer
  // In a real app, this would come from the backend
  String _getCorrectAnswer(String questionId) {
    switch (questionId) {
      case 'q3':
        return 'Au';
      case 'q5':
        return 'Pacific';
      default:
        return 'N/A';
    }
  }
}