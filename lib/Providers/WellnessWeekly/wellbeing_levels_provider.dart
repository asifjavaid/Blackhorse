import 'package:ekvi/Models/WellnessWeekly/wellbeing_levels_model.dart';
import 'package:ekvi/Services/WellnessWeekly/wellness_weekly_service.dart';
import 'package:flutter/material.dart';

class WellbeingLevelsProvider extends ChangeNotifier {
  WellbeingLevelsModel? _wellbeingLevelsData;
  bool _isLoading = false;
  String? _error;

  // Getters
  WellbeingLevelsModel? get wellbeingLevelsData => _wellbeingLevelsData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // State checks
  bool get hasWins => _wellbeingLevelsData?.hasWins ?? false;
  bool get hasMixedResults => _wellbeingLevelsData?.hasMixedResults ?? false;
  bool get hasNoWins => _wellbeingLevelsData?.hasNoWins ?? false;
  bool get hasNoData => _wellbeingLevelsData?.hasNoData ?? false;
  bool get hasSufficientData =>
      _wellbeingLevelsData?.hasSufficientData ?? false;

  // Get daily averages list
  List<DailyAverage> get dailyAverages =>
      _wellbeingLevelsData?.dailyAverages ?? [];

  // Get weekly summary
  WeeklySummary? get weeklySummary => _wellbeingLevelsData?.weeklySummary;

  // Initialize with current week data
  Future<void> initialize() async {
    await fetchWellbeingLevels();
  }

  // Fetch wellbeing levels data
  Future<void> fetchWellbeingLevels() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final weekStartDate = WellnessWeeklyService.getCurrentWeekStartDate();

      final result =
          await WellnessWeeklyService.getWellbeingLevels(weekStartDate);
      result.fold(
        (failure) => _error = failure.toString(),
        (data) => _wellbeingLevelsData = data,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh data
  Future<void> refresh() async {
    await fetchWellbeingLevels();
  }

  // Clear data
  void clearData() {
    _wellbeingLevelsData = null;
    _error = null;
    notifyListeners();
  }
}
