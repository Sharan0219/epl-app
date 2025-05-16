class QuestionModel {
  final String id;
  final String type; // 'mcq', 'fill_blank', etc.
  final String question;
  final List<String>? options; // For multiple choice questions
  final int timeLimit; // In seconds

  QuestionModel({
    required this.id,
    required this.type,
    required this.question,
    this.options,
    this.timeLimit = 30,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      type: json['type'] ?? 'mcq',
      question: json['question'] ?? '',
      options: json['options'] != null 
          ? List<String>.from(json['options'])
          : null,
      timeLimit: json['timeLimit'] ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'question': question,
      'options': options,
      'timeLimit': timeLimit,
    };
  }
}