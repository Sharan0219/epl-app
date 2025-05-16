class AnswerModel {
  final String questionId;
  final String answer;
  final bool isCorrect;
  final int timeSpent; // In seconds

  AnswerModel({
    required this.questionId,
    required this.answer,
    required this.isCorrect,
    this.timeSpent = 0,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      questionId: json['questionId'] ?? '',
      answer: json['answer'] ?? '',
      isCorrect: json['isCorrect'] ?? false,
      timeSpent: json['timeSpent'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answer': answer,
      'isCorrect': isCorrect,
      'timeSpent': timeSpent,
    };
  }
}