import 'package:ekvi/Components/FeatureAlert/feature_alert_dialog.dart';
import 'package:ekvi/Models/DailyTracker/Mood/mood_model.dart';
import 'package:ekvi/Models/Dashboard/feature_alert_model.dart';
import 'package:ekvi/Models/Dashboard/my_day_model.dart';
import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Services/Dashboard/dashboard_service.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/firebase_helper.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardProvider extends ChangeNotifier {
  PersistentTabController controllerForBottomNavigation = PersistentTabController(initialIndex: 0);
  MyDayModel myDay = MyDayModel();
  ScrollController hormoneGraphScrollController = ScrollController();
  FeatureAlertModel featureAlertModel = FeatureAlertModel(isFeatureAlertAvailable: false);
  bool isAlertFeatureAvailable = true;
  bool _isProgrammaticTabChange = false;
  DashboardMoodPanelType panelType = DashboardMoodPanelType.tracker;
  CategoryMood moodData = DataInitializations.categoriesData().mood;
  PanelController panelController = PanelController();

  String greeting = "";

  bool get isProgrammaticTabChange => _isProgrammaticTabChange;

  DashboardProvider() {
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await FirebaseHelper().initialize();
  }

  void handleFeelToday(BuildContext context) {
    panelType = DashboardMoodPanelType.tracker;
    panelController.open();
    notifyListeners();
  }

  void handleSaveFeelToday(BuildContext context) async {
    var provider = Provider.of<MoodProvider>(context, listen: false);
    var dailyTrackerProvider = Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!, listen: false);
    provider.handleTimeSelection(4);
    dailyTrackerProvider.updateSelectedDateOfUserForTracking(DateFormat('yyyy-MM-dd').format(DateTime.now()), showLoader: false);
    MoodResponseModel? response = await provider.saveMoodData(context, navigate: false, validateTags: true);
    DashboardMoodPanelType? panel = getPanelCategory(response?.answer ?? []);
    if (panel != null) {
      panelType = panel;
    }
    notifyListeners();
  }

  void setBottomNavIndex(int index) {
    controllerForBottomNavigation.jumpToTab(index);
    notifyListeners();
  }

  void setProgrammaticTabChange(bool value) {
    _isProgrammaticTabChange = value;
    notifyListeners();
  }

  void reInitializeController(int index) {
    controllerForBottomNavigation = PersistentTabController(initialIndex: index);
    notifyListeners();
  }

  String _getGreetingBasedOnHour(int hour, BuildContext context) {
    if (hour >= 0 && hour < 12) {
      return AppLocalizations.of(context)!.goodMorning;
    } else if (hour >= 12 && hour < 18) {
      return AppLocalizations.of(context)!.goodAfternoon;
    } else {
      return AppLocalizations.of(context)!.goodEvening;
    }
  }

  Future<void> setGreeting(BuildContext context) async {
    final currentGreeting = _getGreetingBasedOnHour(DateTime.now().hour, context);
    greeting = currentGreeting;
    notifyListeners();
  }

  Future<void> callDashboardApi() async {
    fetchDashboardMyDay();
    fetchDashboardMood();
  }

  Future<void> fetchDashboardMood() async {
    var moodProvider = Provider.of<MoodProvider>(AppNavigation.currentContext!, listen: false);
    String date = DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
    moodData = await moodProvider.fetchMoodData(date, "AllDay", showLoader: false);
  }

  Future<void> fetchDashboardMyDay() async {
    CustomLoading.showLoadingIndicator();
    var result = await DashboardService.fetchMyDayFromApi();
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        myDay.isDataLoaded = false;
      },
      (r) async {
        myDay = r;
        await setGreeting(AppNavigation.currentContext!);

        CustomLoading.hideLoadingIndicator();
        fetchFeatureAlert();
        if (myDay.isOnboarded == false) AppNavigation.navigateTo(AppRoutes.onboarding);
        notifyListeners();
      },
    );
  }

  Future<void> fetchFeatureAlert() async {
    var result = await DashboardService.fetchAlertFromAPI();
    result.fold(
      (l) {},
      (r) {
        if (r.isFeatureAlertAvailable ?? false) {
          showFeatureAlertDialog();
        }
      },
    );
  }

  Future<void> showFeatureAlertDialog() async {
    return showDialog<void>(
      context: AppNavigation.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const FeatureAlertDialog();
      },
    );
  }

  DashboardMoodPanelType? getPanelCategory(List<String> trackedMoods) {
    const moodCategories = {
      DashboardMoodPanelType.notalone: ["Suicidal"],
      DashboardMoodPanelType.toughtime: ["Obsessive thoughts", "Guilty", "Fearful", "Self critical", "Angry", "Anxious", "Sad", "Depressed"],
      DashboardMoodPanelType.bitoff: ["Indifferent", "Insecure", "Sensitive", "Apathetic", "Confused", "Mood swings"],
      DashboardMoodPanelType.roll: ["Euphoric", "Calm", "Happy", "Hopeful", "Self-compassion", "Grateful", "Relaxed", "Content"],
    };
    for (var category in moodCategories.keys) {
      if (trackedMoods.any((mood) => moodCategories[category]!.contains(mood))) {
        return category;
      }
    }

    return null;
  }
}
