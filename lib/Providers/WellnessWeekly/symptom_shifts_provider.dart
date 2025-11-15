import 'package:ekvi/Models/WellnessWeekly/symptom_shifts_model.dart';
import 'package:ekvi/Services/WellnessWeekly/wellness_weekly_service.dart';
import 'package:flutter/material.dart';

class SymptomShiftsProvider extends ChangeNotifier {
  SymptomShiftsModel? _symptomShiftsData;
  bool _isLoading = false;
  String? _error;

  // Getters
  SymptomShiftsModel? get symptomShiftsData => _symptomShiftsData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // State checks
  bool get hasWins => _symptomShiftsData?.hasWins ?? false;
  bool get hasMixedResults => _symptomShiftsData?.hasMixedResults ?? false;
  bool get hasNoWins => _symptomShiftsData?.hasNoWins ?? false;
  bool get hasNoData => _symptomShiftsData?.hasNoData ?? false;

  // Get symptom shifts list
  List<SymptomShift> get symptomShifts =>
      _symptomShiftsData?.symptomShifts ?? [];

  // Initialize with current week data
  Future<void> initialize() async {
    await fetchSymptomShifts();
  }

  // Fetch symptom shifts data
  Future<void> fetchSymptomShifts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final weekStartDate = WellnessWeeklyService.getCurrentWeekStartDate();

      final result =
          await WellnessWeeklyService.getSymptomShifts(weekStartDate);
      result.fold(
        (failure) => _error = failure.toString(),
        (data) => _symptomShiftsData = data,
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
    await fetchSymptomShifts();
  }

  // Clear data
  void clearData() {
    _symptomShiftsData = null;
    _error = null;
    notifyListeners();
  }
}
