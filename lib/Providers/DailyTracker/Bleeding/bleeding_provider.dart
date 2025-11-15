import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/Bleeding/bleeding_tag_count_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Models/DailyTracker/Bleeding/insights_bleeding_in_circles_chart_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Bleeding/bleeding_service.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BleedingProvider extends ChangeNotifier {
  CategoryBleeding bleedingData = DataInitializations.categoriesData().bleeding;
  InsightsGraphModel insightsAverageBleedingChartData = InsightsGraphModel();
  InisghtsBleedingInCircleModel insightsBlleedingInCircleData = InisghtsBleedingInCircleModel();
  InsightsGraphModel insightsBleedingPadsChartData = InsightsGraphModel();
  BleedingTagCount bleedingTagCount = BleedingTagCount();

  void handleTimeSelection(OptionModel selectedOption) {
    for (var option in bleedingData.painTimeOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handlePadsSelection(int pads) {
    bleedingData.pads = pads;
    notifyListeners();
  }

  void handleIntensitySelection(OptionModel selectedOption) {
    for (var option in bleedingData.options) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleColourSelection(OptionModel selectedOption) {
    for (var option in bleedingData.colour) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleConsistencySelection(OptionModel selectedOption) {
    for (var option in bleedingData.consistency) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleSaveBleedingData() async {
    var provider = Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!, listen: false);
    try {
      bleedingData.validate();
      CustomLoading.showLoadingIndicator();
      OptionModel? selectedOption = bleedingData.painTimeOptions.firstWhereOrNull((option) => option.isSelected);
      DailyTrackerAnswers data = await bleedingData.convertTo(provider.selectedDateOfUserForTracking.date, selectedOption!.text.replaceAll(" ", ""));
      await BleedingService.saveBleedingAnswers(data);
      AppNavigation.goBack();
      CustomLoading.hideLoadingIndicator();
      provider.consultBackendForCompletedCategories();
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
    }
  }

  Future<void> fetchBleedingData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await BleedingService.getBleedingAnswers(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        bleedingData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageBleedingChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageBleedingChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await BleedingService.fetchInsightsAverageBleedingGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageBleedingChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<void> fetchInsightsBleedingInCirclesChart(List<DateTime> selectedMonths, int selectedYear) async {
    insightsBlleedingInCircleData.isDataLoaded = false;
    notifyListeners();

    var result = await BleedingService.fetchInsightsBleedingInCirclesGraphFromApi(selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        insightsBlleedingInCircleData = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchInsightsBleedingTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    bleedingTagCount.isDataLoaded = false;
    notifyListeners();

    var result = await BleedingService.fetchInsightsBleedingTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        bleedingTagCount = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchInsightsBleedingPadsChart(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    insightsBleedingPadsChartData.isDataLoaded = false;
    notifyListeners();

    var result = await BleedingService.fetchInsightsBleedingPadsChartFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        insightsBleedingPadsChartData = r;
      },
    );
  }

  void resetBleedingSelection() {
    bleedingData = DataInitializations.categoriesData().bleeding;
    notifyListeners();
  }
}
