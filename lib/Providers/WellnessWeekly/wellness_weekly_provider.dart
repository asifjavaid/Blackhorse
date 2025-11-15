import 'package:ekvi/Services/WellnessWeekly/wellness_weekly_service.dart';
import 'package:ekvi/Models/WellnessWeekly/wellness_weekly_models.dart';
import 'package:flutter/material.dart';

class WellnessWeeklyProvider extends ChangeNotifier {
  final WellnessWeeklyService service = WellnessWeeklyService();

  bool _shouldShowPopup = false;
  WellnessWeeklyPopupData? _popupData;
  bool _isLoading = false;
  String? _error;

  bool get shouldShowPopup => _shouldShowPopup;
  WellnessWeeklyPopupData? get popupData => _popupData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> checkPopupStatus() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // final response = await _service.getPopupStatus();
      // _shouldShowPopup = response.shouldShowPopup;
      // _popupData = response.popupData;

      // Dummy response for now
      _shouldShowPopup = true;
      _popupData = WellnessWeeklyPopupData(
        title: "Your weekly\ncheck-in is ready",
        message:
            "Take a moment to see how your\nbody's been doing this week. Your\nreport is here to guide, support, and\nreflect with you.",
        buttonText: "View Wellness Weekly",
        reportAvailable: true,
        weekStartDate: "2024-01-15",
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      _shouldShowPopup = false;
      notifyListeners();
    }
  }

  Future<void> dismissPopup() async {
    try {
      // await _service.dismissPopup();

      _shouldShowPopup = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

// --------------------------Testing funcitons --------------------------------------------------------------
  void showPopup() {
    _shouldShowPopup = true;
    notifyListeners();
  }

  void hidePopup() {
    _shouldShowPopup = false;
    notifyListeners();
  }

// ----------------------------------------------------------------------------------------------------------

  void viewWellnessWeekly() {
    // will add functionality later
    hidePopup();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
