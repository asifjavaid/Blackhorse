import 'package:ekvi/Models/WellnessWeekly/wellbeing_practices_model.dart';
import 'package:ekvi/Services/WellnessWeekly/wellness_weekly_service.dart';
import 'package:flutter/material.dart';

class WellbeingPracticesProvider extends ChangeNotifier {
  WellbeingPracticesModel? _wellbeingPracticesData;
  bool _isLoading = false;
  String? _error;

  // Getters
  WellbeingPracticesModel? get wellbeingPracticesData =>
      _wellbeingPracticesData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // State checks
  bool get hasWins => _wellbeingPracticesData?.hasWins ?? false;
  bool get hasMixedResults => _wellbeingPracticesData?.hasMixedResults ?? false;
  bool get hasNoWins => _wellbeingPracticesData?.hasNoWins ?? false;
  bool get hasNoData => _wellbeingPracticesData?.hasNoData ?? false;

  // Get practices list
  List<WellbeingPractice> get practices =>
      _wellbeingPracticesData?.practices ?? [];

  // Get summary
  WellbeingSummary? get summary => _wellbeingPracticesData?.summary;

  // Initialize with current week data
  Future<void> initialize() async {
    await fetchWellbeingPractices();
  }

  // Fetch wellbeing practices data
  Future<void> fetchWellbeingPractices() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final weekStartDate = WellnessWeeklyService.getCurrentWeekStartDate();

      final result =
          await WellnessWeeklyService.getWellbeingPractices(weekStartDate);
      result.fold(
        (failure) => _error = failure.toString(),
        (data) => _wellbeingPracticesData = data,
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
    await fetchWellbeingPractices();
  }

  // Clear data
  void clearData() {
    _wellbeingPracticesData = null;
    _error = null;
    notifyListeners();
  }
}
