import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_in_circle_model.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_model.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_tags.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/SelfCare/selfcare_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelfcareProvider extends ChangeNotifier {
  CategorySelfCare categorySelfCare = DataInitializations.categoriesData().selfCare;
  List<String> enjoymentLevels = ["Draining", "Meh", "Okay", "Enjoyable", "Pure joy"];

  InsightsGraphModel insightsAverageIntensityChartData = InsightsGraphModel();
  InsightsGraphModel insightsAverageEnjoymentChartData = InsightsGraphModel();
  SelfCareTagsCount selfCareTagsCounts = SelfCareTagsCount(isDataLoaded: false);
  InsightsSelfCareInCircleModel selfCareInCircleModel = InsightsSelfCareInCircleModel(
    trackingData: {},
  );

  final List<Color> activeTrackColors = [
    AppColors.errorColor500,
    AppColors.errorColor500,
    AppColors.errorColor500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.successColor500,
    AppColors.successColor500,
    AppColors.successColor500,
  ];

  void handleSelfCareNotes(String notes) {
    categorySelfCare.selfCareNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void resetSelfCareSelection() {
    categorySelfCare = DataInitializations.categoriesData().selfCare;
    notifyListeners();
  }

  void handleTimeSelection(int index) {
    OptionModel selectedOption = categorySelfCare.selfCareOptionalModel[index];
    for (var option in categorySelfCare.selfCareOptionalModel) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleEnjoymentSelection(int level) {
    categorySelfCare.enjoymentScale = level;
    notifyListeners();
  }

  void handleSelfCarePractice(String practice) {
    if (categorySelfCare.practices.contains(practice)) {
      categorySelfCare.practices.remove(practice);
    } else {
      categorySelfCare.practices.add(practice);
    }

    notifyListeners();
  }

  bool validateSelfCareData(BuildContext context, bool isShow) {
    try {
      categorySelfCare.validate();
      return true;
    } catch (e) {
      isShow ? HelperFunctions.showNotification(context, e.toString()) : null;
      return false;
    }
  }

  Future<void> saveSelfCareLog(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateSelfCareData(context, true)) return;

    CustomLoading.showLoadingIndicator();
    try {
      final selfCareData = await categorySelfCare.convertTo(provider.selectedDateOfUserForTracking.date);
      final result = await SelfcareService.saveSelfcareLog(selfCareData);

      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
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

  Future<void> fetchCategorySelfcare(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await SelfcareService.getSelfcareTrackingData(date, timeOfDay);
      result.fold(
        (l) {
          CustomLoading.hideLoadingIndicator();
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
        },
        (r) {
          CustomLoading.hideLoadingIndicator();

          categorySelfCare.updateFrom(r);
          notifyListeners();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<InsightsGraphModel> fetchInsightsAverageEnjoymentChartData(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageEnjoymentChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await SelfcareService.fetchAverageEnjoymentGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageEnjoymentChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<void> fetchInsightsSelfcareTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    selfCareTagsCounts.isDataLoaded = false;
    notifyListeners();

    var result = await SelfcareService.fetchInsightSelfcareTagsCountFromApi(tenure, selectedMonths, selectedYear);

    result.fold(
      (l) {
        selfCareTagsCounts = SelfCareTagsCount(isDataLoaded: false);
        notifyListeners();
      },
      (r) {
        selfCareTagsCounts = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchSelfcareInCirclesData(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await SelfcareService.getSelfcareInCirclesData(tenure, selectedMonths, selectedYear);
      result.fold(
        (l) {
          CustomLoading.hideLoadingIndicator();
          selfCareInCircleModel = InsightsSelfCareInCircleModel(isDataLoaded: false);
          notifyListeners();
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
        },
        (r) {
          CustomLoading.hideLoadingIndicator();
          selfCareInCircleModel = r;
          notifyListeners();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }
}
