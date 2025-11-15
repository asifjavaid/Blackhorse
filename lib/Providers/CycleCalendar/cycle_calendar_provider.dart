import 'dart:async';
// import 'dart:developer';
// import 'dart:math';
// import 'package:collection/collection.dart';
import 'package:ekvi/Models/Cycle/cycle_predictions.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_helper.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/CycleCalendar/cycle_predictions_ui_helper.dart';
import 'package:ekvi/Services/Cycle/cycle_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';

class CycleCalendarProvider extends ChangeNotifier {
  bool isEditMode = false;
  bool _shouldViewInstructions = true;
  Map<DateTime, List<CycleDayEvent>> _events = {};
  Map<DateTime, List<CycleDayEvent>> originalEvents = {};
  PanelController panelController = PanelController();
  bool showNotificationText = false;
  PanelType panelType = PanelType.viewSymptoms;
  SelectedCycleDay selectedCycleDay = SelectedCycleDay();
  CycleCalendarAPI cycleCalendarData = CycleCalendarAPI();
  List<OptionModel> bleedingIntensityOptions = DataInitializations.categoriesData().bleeding.options;

  Map<DateTime, List<CycleDayEvent>> get events => _events;

  CycleCalendarProvider() {
    _checkIfInstructionsViewed();
  }

  Future<void> _checkIfInstructionsViewed() async {
    bool? instructionsViewed = await SharedPreferencesHelper.getBoolPrefValue(key: 'calendarInstructionsViewed');
    _shouldViewInstructions = instructionsViewed == null || !instructionsViewed;
    notifyListeners();
  }

  void setInstructionsViewed() async {
    _shouldViewInstructions = false;
    notifyListeners();
    await SharedPreferencesHelper.setBoolPrefValue(key: 'calendarInstructionsViewed', value: true);
  }

  bool get shouldViewInstructions => _shouldViewInstructions;

  void toggleEditMode(bool editMode, {bool restore = false}) {
    if (editMode) {
      if (selectedCycleDay.date == null) {
        DateTime now = DateTime.now();
        DateTime todayUTC = DateTime.utc(now.year, now.month, now.day);
        selectedCycleDay = SelectedCycleDay(date: todayUTC, events: _events[todayUTC] ?? []);
      }
      // Save the current state to originalEvents before making any edits
      originalEvents = Map.from(_events);
      _events = CycleHelper.clonePeriodEvents(_events);
    } else if (restore) {
      // Restore the original events and clear the backup
      _events = Map.from(originalEvents);
      originalEvents.clear();
    }

    // Update the edit mode state
    isEditMode = editMode;
    notifyListeners();
  }

  void handleCycleCalendarInformation() {
    if (panelType == PanelType.viewSymptoms) {
      resetViewCycleCalendarSymptoms();
    }
    panelType = PanelType.viewCycleCalendarInformation;
    panelController.isPanelOpen ? panelController.close() : panelController.open();
    notifyListeners();
  }

  void resetViewCycleCalendarSymptoms() {
    if (panelType == PanelType.viewSymptoms) {
      panelController.isPanelOpen ? panelController.close() : panelController.open();
      notifyListeners();
    }
  }

  void handleViewCycleDaySymptoms(DateTime date, _) {
    if (selectedCycleDay.date != null && isSameDay(selectedCycleDay.date, date)) {
      resetViewCycleCalendarSymptoms();
    } else {
      selectedCycleDay = SelectedCycleDay(
        date: date,
        events: _events[date] ?? [],
      );
      panelType = PanelType.viewSymptoms;
      panelController.open();
    }
    notifyListeners();
  }

  List<CycleDayEvent> getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  Widget eventMarkerBuilder(_, DateTime date, List<dynamic> events) {
    final eventsOfDay = getEventsForDay(date);
    return Align(alignment: Alignment.topCenter, child: CyclePredictionsUIHelper.eventMarkerForEvents(date, eventsOfDay));
  }

  void handlePeriodEditing(DateTime date) {
    if (_events[date]?.isNotEmpty ?? false) {
      _events.remove(date);
    } else {
      _events.update(
        date,
        (existingEvents) => [CycleDayEvent(type: "Bleeding", status: "tracked", intensity: "Moderate")],
        ifAbsent: () => [CycleDayEvent(type: "Bleeding", status: "tracked", intensity: "Moderate")],
      );
    }
    selectedCycleDay = SelectedCycleDay(
      date: date,
      events: _events[date] ?? [],
    );

    notifyListeners();
  }

  void updateIntensityForSelectedDate(DateTime? date, String intensity) {
    if (date != null) {
      _events.update(
        date,
        (existingEvents) => [CycleDayEvent(type: "Bleeding", status: "tracked", intensity: intensity)],
        ifAbsent: () => [CycleDayEvent(type: "Bleeding", status: "tracked", intensity: intensity)],
      );
      selectedCycleDay = SelectedCycleDay(
        date: date,
        events: _events[date] ?? [],
      );
      notifyListeners();
    }
  }

  Future<void> addPeriodDates(List<DateTime> dates) async {
    if (dates.isNotEmpty) {
      final payload = await CycleHelper.computeAddPeriodPayload(dates, _events);
      final result = await CycleService.addPeriodDates(data: payload);
      result.fold((l) => HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage), (r) => null);
    }
  }

  Future<void> removePeriodDates(List<DateTime> dates) async {
    if (dates.isNotEmpty) {
      final payload = CycleHelper.computeRemovePeriodPayload(dates);
      final result = await CycleService.removePeriodDates(data: payload);
      result.fold((l) => HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage), (r) => null);
    }
  }

  Future<void> updateCycleCalendarData() async {
    CustomLoading.showLoadingIndicator();

    try {
      final dateRanges = await CycleHelper.computeDifferencesInDates(originalEvents, _events);
      final updateFutures = <Future<void>>[addPeriodDates(dateRanges.addedDates), removePeriodDates(dateRanges.removedDates)];
      await Future.wait(updateFutures);
      toggleEditMode(!isEditMode);
      await fetchCycleCalendarData(showNotificationText: true, showLoader: false);
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    } finally {
      CustomLoading.hideLoadingIndicator();
      notifyListeners();
    }
  }

  Future<void> fetchCycleCalendarData({bool? showNotificationText, bool showLoader = true}) async {
    if (showLoader) CustomLoading.showLoadingIndicator();

    var result = await CycleService.getCycleCalendarDataFromAPI();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
        if (showLoader) CustomLoading.hideLoadingIndicator();
      },
      (r) async {
        try {
          cycleCalendarData = r;
          _events = CycleHelper.generateEvents(r);
          if (showNotificationText ?? false) {
            _showTemporaryNotification();
          }
          notifyListeners();
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, "Error while handling server response");
        } finally {
          if (showLoader) CustomLoading.hideLoadingIndicator();
        }
      },
    );
  }

  void _showTemporaryNotification() {
    toggleNotificationText(true);
    Timer(const Duration(seconds: 1), () {
      toggleNotificationText(false);
      toggleEditMode(false);
    });
  }

  void toggleNotificationText(bool show) {
    showNotificationText = show;
    notifyListeners();
  }
}
