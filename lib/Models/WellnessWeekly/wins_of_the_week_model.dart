class WinsOfTheWeekModel {
  final String weekStartDate;
  final String state;
  final String? lowestPainDay;
  final int? lowPainDaysCount;
  final String? highestMoodDay;
  final int? highMoodDaysCount;

  WinsOfTheWeekModel({
    required this.weekStartDate,
    required this.state,
    this.lowestPainDay,
    this.lowPainDaysCount,
    this.highestMoodDay,
    this.highMoodDaysCount,
  });

  factory WinsOfTheWeekModel.fromJson(Map<String, dynamic> json) {
    return WinsOfTheWeekModel(
      weekStartDate: json['week_start_date'] ?? '',
      state: json['state'] ?? 'no_data',
      lowestPainDay: json['lowest_pain_day'],
      lowPainDaysCount: json['low_pain_days_count'],
      highestMoodDay: json['highest_mood_day'],
      highMoodDaysCount: json['high_mood_days_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week_start_date': weekStartDate,
      'state': state,
      'lowest_pain_day': lowestPainDay,
      'low_pain_days_count': lowPainDaysCount,
      'highest_mood_day': highestMoodDay,
      'high_mood_days_count': highMoodDaysCount,
    };
  }

  // Helper methods to check state
  bool get hasWins => state == 'wins';
  bool get hasMixedResults => state == 'mixed';
  bool get hasNoWins => state == 'no_wins';
  bool get hasNoData => state == 'no_data';
}
