import 'package:flutter/material.dart';

class ExamModel {
  final String name;
  final int questionsCount;
  final String difficulty;
  final Color color;
  final Color difficultyColor;
  final IconData icon;

  ExamModel({
    required this.name,
    required this.questionsCount,
    required this.difficulty,
    required this.color,
    required this.difficultyColor,
    required this.icon,
  });
}