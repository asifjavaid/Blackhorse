import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/DailyTracker/Headache/headache_insights_models.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Headache/headache_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadacheProvider extends ChangeNotifier {
  SymptomCategoriesModel categoriesData = DataInitializations.categoriesData();
  SymptomFeedback headacheSymptomFeedback = SymptomFeedback();

  // Insights data properties
  InsightsGraphModel insightsAverageHeadacheChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumHeadacheChartData = InsightsGraphModel();
  HeadacheTagList insightsHeadacheTagsData = HeadacheTagList();
  InsightsGraphModel insightsHeadacheDurationChartData = InsightsGraphModel();

  void resetHeadacheSelection() {
    categoriesData = DataInitializations.categoriesData();
    notifyListeners();
  }

  void handleHeadacheNotes(String notes) {
    categoriesData.bodyPain.headache.headacheNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void handleEventOptionSelection(
      PainEventsCategory category, OptionModel option, int index,
      [int? impactLevel]) {
    switch (index) {
      case 0: // When did it happen?
        for (var opt in categoriesData.bodyPain.headache.painTimeOptions) {
          if (opt.text == option.text) {
            opt.isSelected = true;
          } else {
            opt.isSelected = false;
          }
        }
        break;
      case 1: // How painful was it?
        categoriesData.bodyPain.headache.painLevel = int.parse(option.text);
        break;
      case 2: // Felt like
        for (var opt in categoriesData.bodyPain.headache.feltLikeOptions) {
          if (opt.text == option.text) {
            opt.isSelected = !opt.isSelected;
          }
        }
        break;
      case 3: // Location
        for (var opt in categoriesData.bodyPain.headache.locationOptions) {
          if (opt.text == option.text) {
            opt.isSelected = !opt.isSelected;
          }
        }
        break;
      case 4: // Type
        for (var opt in categoriesData.bodyPain.headache.typeOptions) {
          if (opt.text == option.text) {
            opt.isSelected = !opt.isSelected;
          }
        }
        break;
      case 5: // Onset
        for (var opt in categoriesData.bodyPain.headache.onsetOptions) {
          if (opt.text == option.text) {
            opt.isSelected = true;
          } else {
            opt.isSelected = false;
          }
        }
        break;
      case 6: // Impact on life
        switch (option.text) {
          case "Work":
            categoriesData.bodyPain.headache.impactGrid.workValue =
                impactLevel!;
            break;
          case "Social life":
            categoriesData.bodyPain.headache.impactGrid.socialLifeValue =
                impactLevel!;
            break;
          case "Sleep":
            categoriesData.bodyPain.headache.impactGrid.sleepValue =
                impactLevel!;
            break;
          case "Quality of life":
            categoriesData.bodyPain.headache.impactGrid.qualityOfLifeValue =
                impactLevel!;
            break;
        }
        break;
    }
    notifyListeners();
  }

  void setDateTime(DateTime time) {
    categoriesData.bodyPain.headache.durationTime = time;
    notifyListeners();
  }

  bool validateHeadacheData(BuildContext context) {
    try {
      categoriesData.bodyPain.headache.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveHeadacheData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateHeadacheData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var requestData = await categoriesData.bodyPain.headache
          .convertTo(provider.selectedDateOfUserForTracking.date);
      var result = await HeadacheService.saveHeadacheAnswers(requestData);
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
      HelperFunctions.showNotification(
          AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> fetchHeadacheData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await HeadacheService.getHeadacheDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        categoriesData.bodyPain.headache.updateFrom(r);
        notifyListeners();
      },
    );
  }

  void fetchHeadacheFeedbackStatus() async {
    var result = await HeadacheService.getHeadacheFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(
            AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        headacheSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateHeadacheFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Headache", feedback: answer)
        .log();
    var result = await HeadacheService.updateHeadacheFeedbackStatus(
        headacheSymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        headacheSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageHeadacheChart(
      String tenure, List<DateTime> selectedMonths, int selectedYear,
      {bool loading = true, bool notify = true}) async {
    insightsAverageHeadacheChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await HeadacheService.fetchInsightsAverageHeadacheGraphFromApi(
        tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        notifyListeners();
        return insightsAverageHeadacheChartData;
      },
      (r) {
        insightsAverageHeadacheChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  // Insights methods
  Future<void> fetchInsightsMaximumHeadacheChart(
      String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    insightsMaximumHeadacheChartData.isDataLoaded = false;
    notifyListeners();

    var result = await HeadacheService.fetchInsightsMaximumHeadacheGraphFromApi(
        tenure, selectedMonths, selectedYear);

    result.fold(
      (l) {
        debugPrint('Failed to fetch maximum headache chart: $l');
      },
      (r) {
        insightsMaximumHeadacheChartData = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchInsightsHeadacheTagsAndGridData(
      String tenure, List<DateTime> selectedMonths, int selectedYear,
      {bool loading = true, bool notify = true}) async {
    insightsHeadacheTagsData.isDataLoaded = false;
    notifyListeners();

    var result = await HeadacheService.fetchInsightsHeadacheTagsAndGridData(
        tenure, selectedMonths, selectedYear);

    result.fold(
      (l) {
        debugPrint('Failed to fetch headache tags: $l');
      },
      (r) {
        insightsHeadacheTagsData = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchInsightsHeadacheDurationChart(
      String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    insightsHeadacheDurationChartData.isDataLoaded = false;
    notifyListeners();

    var result =
        await HeadacheService.fetchInsightsHeadacheDurationGraphFromApi(
            tenure, selectedMonths, selectedYear);

    result.fold(
      (l) {
        debugPrint('Failed to fetch headache duration chart: $l');
      },
      (r) {
        insightsHeadacheDurationChartData = r;
        notifyListeners();
      },
    );
  }
}
