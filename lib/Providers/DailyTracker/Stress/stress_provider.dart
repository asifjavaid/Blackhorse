import 'package:ekvi/Models/DailyTracker/Stress/stress_model.dart';
import 'package:ekvi/Models/DailyTracker/Stress/stress_tag_count.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Stress/stress_service.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StressProvider extends ChangeNotifier {
  CategoryStress stressData = DataInitializations.categoriesData().stress;
  SymptomFeedback stressSymptomFeedback = SymptomFeedback(isFeedbackSaved: true);
  InsightsGraphModel insightsAverageStressChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumStressChartData = InsightsGraphModel();
  StressTagList stressTagCounts = StressTagList(stressTags: []);

  void resetStressSelection() {
    stressData = DataInitializations.categoriesData().stress;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = stressData.stressTime[index];
    for (var option in stressData.stressTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleStressLevelSelection(int level) {
    stressData.stressLevel = level;
    notifyListeners();
  }

  void handleStressOptionsSelection(int index) {
    OptionModel selectedOption = stressData.stressOptions[index];

    for (var option in stressData.stressOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleStressNotes(String notes) {
    stressData.stressNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void saveStressData(BuildContext context) async {
    StressResponseModel payload = StressResponseModel();
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    try {
      payload = await stressData.convertTo(provider.selectedDateOfUserForTracking.date);
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
      return;
    }
    CustomLoading.showLoadingIndicator();
    var result = await StressService.saveStressAnswers(payload);
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
  }

  void fetchStressFeedbackStatus() async {
    var result = await StressService.getStressFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        stressSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateStressFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Stress", feedback: answer).log();
    var result = await StressService.updateStressFeedbackStatus(stressSymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));

        stressSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchStressData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await StressService.getStressDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();

        stressData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageStressChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageStressChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await StressService.fetchInsightsAverageStressGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageStressChartData =r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumStressChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    insightsMaximumStressChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await StressService.fetchInsightsMaximumStressGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumStressChartData =r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsStressTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    stressTagCounts.isDataLoaded = false;
    notifyListeners();

    var result = await StressService.fetchInsightsStressTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        stressTagCounts = r;
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
