import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_model.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_in_circle_model.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_tags_count.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/PainRelief/pain_relief_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PainReliefProvider extends ChangeNotifier {
  CategoryPainRelief categoryPainRelief = DataInitializations.categoriesData().painRelief;
  List<String> painReliefLevels = ["None", "Mild", "Moderate", "Good", "Excellent"];

  InsightsGraphModel insightsAverageIntensityChartData = InsightsGraphModel();
  InsightsGraphModel insightsAverageEffectivenessChartData = InsightsGraphModel();
  PainReliefTagsCount painReliefTagsCounts = PainReliefTagsCount(isDataLoaded: false);
  InsightsPainReliefInCircleModel painReliefInCircleModel = InsightsPainReliefInCircleModel(trackingData: {});

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

  void handlePainReliefNotes(String notes) {
    categoryPainRelief.painReliefNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void resetPainReliefSelection() {
    categoryPainRelief = DataInitializations.categoriesData().painRelief;
    notifyListeners();
  }

  void handleTimeSelection(int index) {
    var selectedOption = categoryPainRelief.painReliefOptionalModel[index];
    for (var option in categoryPainRelief.painReliefOptionalModel) {
      option.isSelected = option.text == selectedOption.text;
    }
    notifyListeners();
  }

  void handleEnjoymentSelection(int level) {
    categoryPainRelief.enjoymentScale = level;
    notifyListeners();
  }

  void handlePainReliefPractice(String practice) {
    if (categoryPainRelief.practices.contains(practice)) {
      categoryPainRelief.practices.remove(practice);
    } else {
      categoryPainRelief.practices.add(practice);
    }
    notifyListeners();
  }

  bool validatePainReliefData(BuildContext context, bool isShow) {
    try {
      categoryPainRelief.validate();
      return true;
    } catch (e) {
      if (isShow) HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  Future<void> savePainReliefLog(BuildContext context) async {
    var provider = context.read<DailyTrackerProvider>();
    if (!validatePainReliefData(context, true)) return;

    CustomLoading.showLoadingIndicator();
    try {
      final logData = await categoryPainRelief.convertTo(provider.selectedDateOfUserForTracking.date);
      final result = await PainReliefService.savePainReliefLog(logData);
      result.fold(
        (l) => HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString()),
        (r) {
          provider.consultBackendForCompletedCategories();
          AppNavigation.goBack();
        },
      );
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    } finally {
      CustomLoading.hideLoadingIndicator();
    }
    notifyListeners();
  }

  Future<void> fetchCategoryPainRelief(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await PainReliefService.getPainReliefTrackingData(date, timeOfDay);
      result.fold(
        (l) => HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString()),
        (r) {
          categoryPainRelief.updateFrom(r);
        },
      );
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    } finally {
      CustomLoading.hideLoadingIndicator();
      notifyListeners();
    }
  }

  Future<InsightsGraphModel> fetchInsightsAverageEnjoymentChartData(
    String tenure,
    List<DateTime> selectedMonths,
    int selectedYear, {
    bool loading = true,
    bool notify = true,
  }) async {
    insightsAverageEffectivenessChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    final result = await PainReliefService.fetchAverageEnjoymentGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) => InsightsGraphModel(),
      (r) {
        insightsAverageEffectivenessChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchPainReliefTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    painReliefTagsCounts.isDataLoaded = false;
    notifyListeners();

    final result = await PainReliefService.fetchInsightTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) => painReliefTagsCounts = PainReliefTagsCount(isDataLoaded: false),
      (r) => painReliefTagsCounts = r,
    );
    notifyListeners();
  }

  Future<void> fetchPainReliefInCirclesData(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await PainReliefService.getInCirclesData(tenure, selectedMonths, selectedYear);
      result.fold(
        (l) => painReliefInCircleModel = InsightsPainReliefInCircleModel(isDataLoaded: false),
        (r) => painReliefInCircleModel = r,
      );
    } catch (_) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    } finally {
      CustomLoading.hideLoadingIndicator();
      notifyListeners();
    }
  }

  Future<void> fetchInsightsPainReliefTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    painReliefTagsCounts.isDataLoaded = false;
    notifyListeners();

    var result = await PainReliefService.fetchInsightPainReliefTagsCountFromApi(tenure, selectedMonths, selectedYear);

    result.fold(
      (l) {
        painReliefTagsCounts = PainReliefTagsCount(isDataLoaded: false);
        notifyListeners();
      },
      (r) {
        painReliefTagsCounts = r;
        notifyListeners();
      },
    );
  }
}
