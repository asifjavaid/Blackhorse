import 'package:ekvi/Models/DailyTracker/Fatigue/fatigue_model.dart';
import 'package:ekvi/Models/DailyTracker/Fatigue/fatigue_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Fatigue/fatigue_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FatigueProvider extends ChangeNotifier {
  CategoryFatigue fatigueData = DataInitializations.categoriesData().fatigue;
  List<String> fatigueLevels = ["Very mild", "Mild", "Moderate", "Severe", "Very severe"];
  SymptomFeedback fatigueSymptomFeedback = SymptomFeedback();
  InsightsGraphModel insightsAverageFatigueChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumFatigueChartData = InsightsGraphModel();
  FatigueTagList fatigueTagCounts = FatigueTagList();

  void resetFatigueSelection() {
    fatigueData = DataInitializations.categoriesData().fatigue;
    notifyListeners();
  }

  void handleFatigueNotes(String notes) {
    fatigueData.fatigueNotes = notes;

    AppNavigation.goBack();
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = fatigueData.fatigueTime[index];
    for (var option in fatigueData.fatigueTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleFatiqueLevelSelection(int level) {
    fatigueData.fatigueLevel = level;
    notifyListeners();
  }

  void handleFatigueOptionsSelection(int index) {
    OptionModel selectedOption = fatigueData.fatigueOptions[index];
    for (var option in fatigueData.fatigueOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleFatigueDurationSelection(int index) {
    OptionModel selectedOption = fatigueData.durationOptions[index];
    for (var option in fatigueData.durationOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool validateFatigueData(BuildContext context) {
    try {
      fatigueData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveFatigueData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateFatigueData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await FatigueService.saveFatigueAnswers(await fatigueData.convertTo(provider.selectedDateOfUserForTracking.date));
      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          CustomLoading.hideLoadingIndicator();
        },
        (r) async {
          CustomLoading.hideLoadingIndicator();
          AppNavigation.goBack();
          provider.consultBackendForCompletedCategories();
          notifyListeners();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> fetchFatigueData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await FatigueService.getFatigueDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        fatigueData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  void fetchFatigueFeedbackStatus() async {
    var result = await FatigueService.getFatigueFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        fatigueSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateFatigueFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Fatigue", feedback: answer).log();
    var result = await FatigueService.updateFatigueFeedbackStatus(fatigueSymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        fatigueSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageFatigueChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageFatigueChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await FatigueService.fetchInsightsAverageFatigueGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageFatigueChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumFatiguChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    insightsMaximumFatigueChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await FatigueService.fetchInsightsMaximumFatigueGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumFatigueChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsFatiguTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    fatigueTagCounts.isDataLoaded = false;
    notifyListeners();

    var result = await FatigueService.fetchInsightsFatigueTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        fatigueTagCounts = r;
        notifyListeners();
      },
    );
  }

  String getGraphTenure(
    List<DateTime> selectedMonths,
  ) {
    switch (selectedMonths.length) {
      case 0:
        return "yearly";
      case 1:
        return "daily";
      case 3:
        return "weekly";

      default:
        return "weekly";
    }
  }
}
