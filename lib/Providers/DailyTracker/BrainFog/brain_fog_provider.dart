import 'package:ekvi/Models/DailyTracker/BrainFog/brain_fog_model.dart';
import 'package:ekvi/Models/DailyTracker/BrainFog/brain_fog_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/BrainFog/brain_fog_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrainFogProvider extends ChangeNotifier {
  CategoryBrainFog brainFogData = DataInitializations.categoriesData().brainFog;
  List<String> brainFogLevels = ["Very mild", "Mild", "Moderate", "Severe", "Very severe"];
  SymptomFeedback brainFogSymptomFeedback = SymptomFeedback();
  InsightsGraphModel insightsAverageBrainFogChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumBrainFogChartData = InsightsGraphModel();
  BrainFogTagList brainFogTagCounts = BrainFogTagList();

  void resetBrainFogSelection() {
    brainFogData = DataInitializations.categoriesData().brainFog;
    notifyListeners();
  }

  void handleBrainFogNotes(String notes) {
    brainFogData.brainFogNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = brainFogData.brainFogTime[index];
    for (var option in brainFogData.brainFogTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleBrainFogLevelSelection(int level) {
    brainFogData.brainFogLevel = level;
    notifyListeners();
  }

  void handleBrainFogOptionsSelection(int index) {
    OptionModel selectedOption = brainFogData.brainFogOptions[index];
    for (var option in brainFogData.brainFogOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleBrainFogDurationSelection(int index) {
    OptionModel selectedOption = brainFogData.durationOptions[index];
    for (var option in brainFogData.durationOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool validateBrainFogData(BuildContext context) {
    try {
      brainFogData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveBrainFogData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateBrainFogData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await BrainFogService.saveBrainFogAnswers(await brainFogData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchBrainFogData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await BrainFogService.getBrainFogDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        brainFogData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  void fetchBrainFogFeedbackStatus() async {
    var result = await BrainFogService.getBrainFogFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        brainFogSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateBrainFogFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "BrainFog", feedback: answer).log();
    var result = await BrainFogService.updateBrainFogFeedbackStatus(brainFogSymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        brainFogSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageBrainFogChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageBrainFogChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();
    var result = await BrainFogService.fetchInsightsAverageBrainFogGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageBrainFogChartData =  r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumBrainFogChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    insightsMaximumBrainFogChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await BrainFogService.fetchInsightsMaximumBrainFogGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumBrainFogChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsBrainFogTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    brainFogTagCounts.isDataLoaded = false;
    notifyListeners();

    var result = await BrainFogService.fetchInsightsBrainFogTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        brainFogTagCounts = r;
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
