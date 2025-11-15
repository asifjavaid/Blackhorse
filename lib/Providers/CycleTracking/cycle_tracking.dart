import 'package:ekvi/Models/Cycle/save_cycle_settings_model.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/Cycle/cycle_service.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CycleTrackingProvider extends ChangeNotifier {
  bool getMyPeriods = false;
  DateTime selectedCycleStartDate = DateTime.now();
  String periodRegularity = "My cycle is regular";
  bool _enableButton = true;
  final List<String> lengthOptions = ["Select", ...List.generate(90, (index) => (index + 1).toString())];

  var selectedCycleLength = "Select";
  var selectedPeriodLength = "Select";
  var sideNavProvider = Provider.of<SideNavManagerProvider>(AppNavigation.currentContext!, listen: false);
  var dashboardProvider = Provider.of<DashboardProvider>(AppNavigation.currentContext!, listen: false);

  void setEnableButton(bool value, {bool notify = true}) {
    _enableButton = value;
    if (notify) notifyListeners();
  }

  bool get enableButton => _enableButton;

  void setGetMyPeriods(bool value) {
    getMyPeriods = value;
    notifyListeners();
  }

  void setSelectedRegularity(String? value) {
    periodRegularity = value ?? "Select";
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setCycleLength(String? length) {
    selectedCycleLength = length!;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setPeriodLength(String? length) {
    selectedPeriodLength = length!;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setCycleStartDate(DateTime date) {
    selectedCycleStartDate = date;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  Future<void> getCycleTracking() async {
    var cycleId = await SharedPreferencesHelper.getStringPrefValue(key: "cycleId");
    bool cycleExists = cycleId != null ? true : false;

    if (cycleExists) {
      CustomLoading.showLoadingIndicator();
      var result = await CycleService.getCycleTrackingSettings();
      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          CustomLoading.hideLoadingIndicator();
          setEnableButton(false);
        },
        (r) async {
          selectedCycleLength = r.cycleLength!;
          selectedPeriodLength = r.periodLength!;
          setCycleStartDate(DateFormat("yyyy-MM-dd").parse(r.periodStartDate!));
          periodRegularity = r.periodRegularity!;
          setEnableButton(false);
          CustomLoading.hideLoadingIndicator();
          notifyListeners();
        },
      );
    }
  }

  Future<void> handleSaveCycleTracking({bool? cycleTrackingShouldPop}) async {
    // CustomLoading.showLoadingIndicator();
    var cycleId = await SharedPreferencesHelper.getStringPrefValue(key: "cycleId");
    bool update = cycleId != null ? true : false;

    var result = await CycleService.saveCycleTrackingSettings(
        update: update,
        data: SaveCycleTrackingSettingsModel(
            userId: await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
            cycleLength: selectedCycleLength,
            periodLength: selectedPeriodLength,
            periodStartDate: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(selectedCycleStartDate),
            periodRegularity: periodRegularity));
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
        // CustomLoading.hideLoadingIndicator();
      },
      (r) async {
        await SharedPreferencesHelper.setStringPrefValue(
          key: "cycleId",
          value: r.id!,
        );
        await CycleCalendarProvider().fetchCycleCalendarData(showLoader: false);
        // CustomLoading.hideLoadingIndicator();
        if (cycleTrackingShouldPop ?? false) {
          AppNavigation.goBack();
          dashboardProvider.callDashboardApi();
        } else {}
        sideNavProvider.onSelected(MenuItems(AppNavigation.currentContext!).bottomNavManager);
        notifyListeners();
      },
    );
  }
}
