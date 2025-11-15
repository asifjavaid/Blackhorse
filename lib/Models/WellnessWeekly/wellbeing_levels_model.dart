class WellbeingLevelsModel {
  final bool hasSufficientData;
  final String state;
  final List<DailyAverage> dailyAverages;
  final WeeklySummary weeklySummary;

  WellbeingLevelsModel({
    required this.hasSufficientData,
    required this.state,
    required this.dailyAverages,
    required this.weeklySummary,
  });

  factory WellbeingLevelsModel.fromJson(Map<String, dynamic> json) {
    return WellbeingLevelsModel(
      hasSufficientData: json['has_sufficient_data'] ?? false,
      state: json['state'] ?? 'no_data',
      dailyAverages: (json['daily_averages'] as List<dynamic>?)
              ?.map((average) => DailyAverage.fromJson(average))
              .toList() ??
          [],
      weeklySummary: WeeklySummary.fromJson(json['weekly_summary'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'has_sufficient_data': hasSufficientData,
      'state': state,
      'daily_averages':
          dailyAverages.map((average) => average.toJson()).toList(),
      'weekly_summary': weeklySummary.toJson(),
    };
  }

  // Helper methods to check state
  bool get hasWins => state == 'wins';
  bool get hasMixedResults => state == 'mixed';
  bool get hasNoWins => state == 'no_wins';
  bool get hasNoData => state == 'no_data';
}

class DailyAverage {
  final String day;
  final double moodAvg;
  final double energyAvg;
  final double stressAvg;
  final String date;

  DailyAverage({
    required this.day,
    required this.moodAvg,
    required this.energyAvg,
    required this.stressAvg,
    required this.date,
  });

  factory DailyAverage.fromJson(Map<String, dynamic> json) {
    return DailyAverage(
      day: json['day'] ?? '',
      moodAvg: (json['mood_avg'] ?? 0.0).toDouble(),
      energyAvg: (json['energy_avg'] ?? 0.0).toDouble(),
      stressAvg: (json['stress_avg'] ?? 0.0).toDouble(),
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'mood_avg': moodAvg,
      'energy_avg': energyAvg,
      'stress_avg': stressAvg,
      'date': date,
    };
  }

  // Helper methods for data validation
  bool get hasValidMood => moodAvg > 0;
  bool get hasValidEnergy => energyAvg > 0;
  bool get hasValidStress => stressAvg > 0;
}

class WeeklySummary {
  final double moodWeeklyAvg;
  final double energyWeeklyAvg;
  final double stressWeeklyAvg;
  final int daysWithData;
  final double dataCompleteness;

  WeeklySummary({
    required this.moodWeeklyAvg,
    required this.energyWeeklyAvg,
    required this.stressWeeklyAvg,
    required this.daysWithData,
    required this.dataCompleteness,
  });

  factory WeeklySummary.fromJson(Map<String, dynamic> json) {
    return WeeklySummary(
      moodWeeklyAvg: (json['mood_weekly_avg'] ?? 0.0).toDouble(),
      energyWeeklyAvg: (json['energy_weekly_avg'] ?? 0.0).toDouble(),
      stressWeeklyAvg: (json['stress_weekly_avg'] ?? 0.0).toDouble(),
      daysWithData: json['days_with_data'] ?? 0,
      dataCompleteness: (json['data_completeness'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mood_weekly_avg': moodWeeklyAvg,
      'energy_weekly_avg': energyWeeklyAvg,
      'stress_weekly_avg': stressWeeklyAvg,
      'days_with_data': daysWithData,
      'data_completeness': dataCompleteness,
    };
  }

  // Helper methods for insights
  bool get hasGoodMood => moodWeeklyAvg >= 7.0;
  bool get hasGoodEnergy => energyWeeklyAvg >= 6.0;
  bool get hasLowStress => stressWeeklyAvg <= 4.0;
  bool get hasCompleteData => dataCompleteness >= 70.0;
}
