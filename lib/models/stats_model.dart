class StatsModel {
  final int totalScore;
  final int rank;
  final int accuracy; // Percentage
  final int challengesCompleted;

  StatsModel({
    required this.totalScore,
    required this.rank,
    required this.accuracy,
    required this.challengesCompleted,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      totalScore: json['totalScore'] ?? 0,
      rank: json['rank'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      challengesCompleted: json['challengesCompleted'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalScore': totalScore,
      'rank': rank,
      'accuracy': accuracy,
      'challengesCompleted': challengesCompleted,
    };
  }
}