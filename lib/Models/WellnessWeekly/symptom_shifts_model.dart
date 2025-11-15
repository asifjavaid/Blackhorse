class SymptomShiftsModel {
  final String weekStartDate;
  final String state;
  final List<SymptomShift> symptomShifts;

  SymptomShiftsModel({
    required this.weekStartDate,
    required this.state,
    required this.symptomShifts,
  });

  factory SymptomShiftsModel.fromJson(Map<String, dynamic> json) {
    return SymptomShiftsModel(
      weekStartDate: json['week_start_date'] ?? '',
      state: json['state'] ?? 'no_data',
      symptomShifts: (json['symptom_shifts'] as List<dynamic>?)
              ?.map((shift) => SymptomShift.fromJson(shift))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week_start_date': weekStartDate,
      'state': state,
      'symptom_shifts': symptomShifts.map((shift) => shift.toJson()).toList(),
    };
  }

  // Helper methods to check state
  bool get hasWins => state == 'wins';
  bool get hasMixedResults => state == 'mixed';
  bool get hasNoWins => state == 'no_wins';
  bool get hasNoData => state == 'no_data';
}

class SymptomShift {
  final String symptom;
  final int percentChange;
  final double currentWeekAvg;
  final double previousWeekAvg;
  final String symptomType;
  final bool isImprovement;

  SymptomShift({
    required this.symptom,
    required this.percentChange,
    required this.currentWeekAvg,
    required this.previousWeekAvg,
    required this.symptomType,
    required this.isImprovement,
  });

  factory SymptomShift.fromJson(Map<String, dynamic> json) {
    return SymptomShift(
      symptom: json['symptom'] ?? '',
      percentChange: json['percent_change'] ?? 0,
      currentWeekAvg: (json['current_week_avg'] ?? 0.0).toDouble(),
      previousWeekAvg: (json['previous_week_avg'] ?? 0.0).toDouble(),
      symptomType: json['symptom_type'] ?? 'neutral',
      isImprovement: json['is_improvement'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symptom': symptom,
      'percent_change': percentChange,
      'current_week_avg': currentWeekAvg,
      'previous_week_avg': previousWeekAvg,
      'symptom_type': symptomType,
      'is_improvement': isImprovement,
    };
  }

  // Helper methods
  bool get isPositive => symptomType == 'positive';
  bool get isNegative => symptomType == 'negative';
  bool get isNeutral => symptomType == 'neutral';

  // Get icon path based on symptom
  String get iconPath {
    switch (symptom.toLowerCase()) {
      case 'pain':
        return 'assets/icons/pain.svg';
      case 'bleeding':
        return 'assets/icons/bleeding.svg';
      case 'mood':
        return 'assets/icons/mood.svg';
      case 'fatigue':
        return 'assets/icons/fatigue.svg';
      case 'bloating':
        return 'assets/icons/bloating.svg';
      case 'nausea':
        return 'assets/icons/nausea.svg';
      default:
        return 'assets/icons/pain.svg'; // Default fallback
    }
  }
}
