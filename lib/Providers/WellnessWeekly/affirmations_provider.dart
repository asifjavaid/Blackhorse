import 'package:ekvi/Models/WellnessWeekly/affirmations_model.dart';
import 'package:ekvi/Services/WellnessWeekly/wellness_weekly_service.dart';
import 'package:flutter/material.dart';

class AffirmationsProvider extends ChangeNotifier {
  AffirmationsModel? _affirmationsData;
  bool _isLoading = false;
  String? _error;

  // Getters
  AffirmationsModel? get affirmationsData => _affirmationsData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // State checks
  bool get hasWins => _affirmationsData?.hasWins ?? false;
  bool get hasMixedResults => _affirmationsData?.hasMixedResults ?? false;
  bool get hasNoWins => _affirmationsData?.hasNoWins ?? false;
  bool get hasNoData => _affirmationsData?.hasNoData ?? false;

  // Get affirmations list
  List<Affirmation> get affirmations => _affirmationsData?.affirmations ?? [];

  // Get metadata
  AffirmationsMetadata? get metadata => _affirmationsData?.metadata;

  // Initialize with current week data
  Future<void> initialize() async {
    await fetchAffirmations();
  }

  // Fetch affirmations data
  Future<void> fetchAffirmations() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final weekStartDate = WellnessWeeklyService.getCurrentWeekStartDate();

      final result = await WellnessWeeklyService.getAffirmations(weekStartDate);
      result.fold(
        (failure) => _error = failure.toString(),
        (data) => _affirmationsData = data,
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
    await fetchAffirmations();
  }

  // Clear data
  void clearData() {
    _affirmationsData = null;
    _error = null;
    notifyListeners();
  }
}
