import 'package:ekvi/Models/DailyTracker/Bloating/bloating_model.dart';
import 'package:ekvi/Models/DailyTracker/Bloating/bloating_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Bloating/bloating_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloatingProvider extends ChangeNotifier {
  CategoryBloating bloatingData = DataInitializations.categoriesData().bloating;
  List<String> bloatingLevels = ["Very mild", "Mild", "Moderate", "Severe", "Very severe"];
  SymptomFeedback bloatingSymptomFeedback = SymptomFeedback();
  InsightsGraphModel insightsAverageBloatingChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumBloatingChartData = InsightsGraphModel();
  BloatingTagList bloatingTagCounts = BloatingTagList();

  void resetBloatingSelection() {
    bloatingData = DataInitializations.categoriesData().bloating;
    notifyListeners();
  }

  void handleBloatingNotes(String notes) {
    bloatingData.bloatingNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = bloatingData.bloatingTime[index];
    for (var option in bloatingData.bloatingTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleBloatingLevelSelection(int level) {
    bloatingData.bloatingLevel = level;
    notifyListeners();
  }

  void handleBloatingOptionsSelection(int index) {
    OptionModel selectedOption = bloatingData.bloatingOptions[index];
    for (var option in bloatingData.bloatingOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleBloatingDurationSelection(int index) {
    OptionModel selectedOption = bloatingData.durationOptions[index];
    for (var option in bloatingData.durationOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool validateBloatingData(BuildContext context) {
    try {
      bloatingData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveBloatingData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateBloatingData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await BloatingService.saveBloatingAnswers(await bloatingData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchBloatingData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await BloatingService.getBloatingDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        bloatingData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  void fetchBloatingFeedbackStatus() async {
    var result = await BloatingService.getBloatingFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        bloatingSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateBloatingFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Bloating", feedback: answer).log();
    var result = await BloatingService.updateBloatingFeedbackStatus(bloatingSymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        bloatingSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageBloatingChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageBloatingChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await BloatingService.fetchInsightsAverageBloatingGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageBloatingChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumBloatingChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    insightsMaximumBloatingChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await BloatingService.fetchInsightsMaximumBloatingGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumBloatingChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsBloatingTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    bloatingTagCounts.isDataLoaded = false;
    notifyListeners();

    var result = await BloatingService.fetchInsightsBloatingTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        bloatingTagCounts = r;
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
