import 'package:exam_prep_app/models/question_model.dart';

class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final int totalQuestions;
  final int timeLimit; // In seconds
  final List<QuestionModel> questions;
  final Map<String, dynamic> settings;
  final String? imageUrl;
  final String? category;
  final int? difficulty; // 1-5 scale
  final DateTime? availableFrom;
  final DateTime? availableTo;
  final bool isCompleted;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.totalQuestions,
    required this.timeLimit,
    required this.questions,
    required this.settings,
    this.imageUrl,
    this.category,
    this.difficulty,
    this.availableFrom,
    this.availableTo,
    this.isCompleted = false,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    // Parse questions list
    List<QuestionModel> questionsList = [];
    if (json['questions'] != null) {
      questionsList = List<QuestionModel>.from(
        (json['questions'] as List).map(
          (q) => QuestionModel.fromJson(q),
        ),
      );
    }

    return ChallengeModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,
      timeLimit: json['timeLimit'] ?? 300, // Default 5 minutes
      questions: questionsList,
      settings: json['settings'] ?? {},
      imageUrl: json['imageUrl'],
      category: json['category'],
      difficulty: json['difficulty'],
      availableFrom: json['availableFrom'] != null 
          ? (json['availableFrom'] is DateTime 
              ? json['availableFrom'] 
              : DateTime.parse(json['availableFrom']))
          : null,
      availableTo: json['availableTo'] != null 
          ? (json['availableTo'] is DateTime 
              ? json['availableTo'] 
              : DateTime.parse(json['availableTo']))
          : null,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'totalQuestions': totalQuestions,
      'timeLimit': timeLimit,
      'questions': questions.map((q) => q.toJson()).toList(),
      'settings': settings,
      'imageUrl': imageUrl,
      'category': category,
      'difficulty': difficulty,
      'availableFrom': availableFrom?.toIso8601String(),
      'availableTo': availableTo?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  ChallengeModel copyWith({
    String? id,
    String? title,
    String? description,
    int? totalQuestions,
    int? timeLimit,
    List<QuestionModel>? questions,
    Map<String, dynamic>? settings,
    String? imageUrl,
    String? category,
    int? difficulty,
    DateTime? availableFrom,
    DateTime? availableTo,
    bool? isCompleted,
  }) {
    return ChallengeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      timeLimit: timeLimit ?? this.timeLimit,
      questions: questions ?? this.questions,
      settings: settings ?? this.settings,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}