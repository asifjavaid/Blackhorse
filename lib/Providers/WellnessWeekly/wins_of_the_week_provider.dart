import 'package:ekvi/Models/WellnessWeekly/wins_of_the_week_model.dart';
import 'package:ekvi/Services/WellnessWeekly/wellness_weekly_service.dart';
import 'package:flutter/material.dart';

class WinsOfTheWeekProvider extends ChangeNotifier {
  WinsOfTheWeekModel? _winsData;
  bool _isLoading = false;
  String? _error;

  // Getters
  WinsOfTheWeekModel? get winsData => _winsData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // State checks
  bool get hasWins => _winsData?.hasWins ?? false;
  bool get hasMixedResults => _winsData?.hasMixedResults ?? false;
  bool get hasNoWins => _winsData?.hasNoWins ?? false;
  bool get hasNoData => _winsData?.hasNoData ?? false;

  // Initialize with current week data
  Future<void> initialize() async {
    await fetchWinsOfTheWeek();
  }

  // Fetch wins of the week data
  Future<void> fetchWinsOfTheWeek() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final weekStartDate = WellnessWeeklyService.getCurrentWeekStartDate();

      final result =
          await WellnessWeeklyService.getWinsOfTheWeek(weekStartDate);
      result.fold(
        (failure) => _error = failure.toString(),
        (data) => _winsData = data,
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
    await fetchWinsOfTheWeek();
  }

  // Clear data
  void clearData() {
    _winsData = null;
    _error = null;
    notifyListeners();
  }
}
