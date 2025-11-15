class WellbeingPracticesModel {
  final String weekStartDate;
  final String state;
  final List<WellbeingPractice> practices;
  final WellbeingSummary summary;

  WellbeingPracticesModel({
    required this.weekStartDate,
    required this.state,
    required this.practices,
    required this.summary,
  });

  factory WellbeingPracticesModel.fromJson(Map<String, dynamic> json) {
    return WellbeingPracticesModel(
      weekStartDate: json['week_start_date'] ?? '',
      state: json['state'] ?? 'no_data',
      practices: (json['practices'] as List<dynamic>?)
              ?.map((practice) => WellbeingPractice.fromJson(practice))
              .toList() ??
          [],
      summary: WellbeingSummary.fromJson(json['summary'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week_start_date': weekStartDate,
      'state': state,
      'practices': practices.map((practice) => practice.toJson()).toList(),
      'summary': summary.toJson(),
    };
  }

  // Helper methods to check state
  bool get hasWins => state == 'wins';
  bool get hasMixedResults => state == 'mixed';
  bool get hasNoWins => state == 'no_wins';
  bool get hasNoData => state == 'no_data';
}

class WellbeingPractice {
  final String practiceName;
  final String emoji;
  final int count;
  final String category;

  WellbeingPractice({
    required this.practiceName,
    required this.emoji,
    required this.count,
    required this.category,
  });

  factory WellbeingPractice.fromJson(Map<String, dynamic> json) {
    return WellbeingPractice(
      practiceName: json['practiceName'] ?? '',
      emoji: json['emoji'] ?? '🌟',
      count: json['count'] ?? 0,
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'practiceName': practiceName,
      'emoji': emoji,
      'count': count,
      'category': category,
    };
  }

  // Helper methods
  bool get isMovementCategory => category == 'movement';
  bool get isSelfCareCategory => category == 'self_care';
  bool get isNutritionCategory => category == 'nutrition';
  bool get isSleepCategory => category == 'sleep';
}

class WellbeingSummary {
  final int totalPractices;
  final int totalEntries;
  final int selfCareCount;
  final int movementCount;

  WellbeingSummary({
    required this.totalPractices,
    required this.totalEntries,
    required this.selfCareCount,
    required this.movementCount,
  });

  factory WellbeingSummary.fromJson(Map<String, dynamic> json) {
    return WellbeingSummary(
      totalPractices: json['total_practices'] ?? 0,
      totalEntries: json['total_entries'] ?? 0,
      selfCareCount: json['self_care_count'] ?? 0,
      movementCount: json['movement_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_practices': totalPractices,
      'total_entries': totalEntries,
      'self_care_count': selfCareCount,
      'movement_count': movementCount,
    };
  }
}
