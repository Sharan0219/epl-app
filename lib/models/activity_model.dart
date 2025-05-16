import 'package:flutter/material.dart';

class ActivityModel {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color iconColor;

  ActivityModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.iconColor,
  });
}