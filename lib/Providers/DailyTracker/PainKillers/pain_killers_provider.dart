import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/pain_killers_model.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/painkillers_in_circles.model.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/painkillers_tags.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/user_pain_killer_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/PainKillers/pain_killer_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PainKillersProvider extends ChangeNotifier {
  CategoryPainKillers painKillerData = DataInitializations.categoriesData().painKillers;
  List<String> painKillerLevels = ["None", "Mild", "Moderate", "Good", "Excellent"];
  InsightsGraphModel insightsPainkillersAverageEffectivessChartData = InsightsGraphModel();
  InsightsGraphModel insightsPainkillersPillsChartData = InsightsGraphModel();
  PainkillersTagsCount painKillersTagsCounts = PainkillersTagsCount(isDataLoaded: false);
  PainkillerInCirclesModel painkillerInCirclesModel = PainkillerInCirclesModel(
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

  int getPillQuantity(UserPainKillerResponseModel pill) {
    final pillId = pill.id;
    if (pillId == null || painKillerData.painkillers == null) return 0;

    final existing = painKillerData.painkillers!.firstWhereOrNull((p) => p.id == pillId);
    return existing?.units ?? 0;
  }

  void incrementPillQuantity(UserPainKillerResponseModel pill) {
    final pillId = pill.id;
    if (pillId == null) return;

    painKillerData.painkillers ??= [];
    final existing = painKillerData.painkillers!.firstWhereOrNull((p) => p.id == pillId);

    if (existing == null) {
      painKillerData.painkillers!.add(
        Painkillers(id: pillId, units: 1),
      );
    } else {
      existing.units = (existing.units ?? 0) + 1;
    }
    notifyListeners();
  }

  void decrementPillQuantity(UserPainKillerResponseModel pill) {
    if (painKillerData.painkillers == null) return;

    final pillId = pill.id;
    if (pillId == null) return;

    final existing = painKillerData.painkillers!.firstWhereOrNull((p) => p.id == pillId);

    if (existing != null && (existing.units ?? 0) > 0) {
      existing.units = existing.units! - 1;
      notifyListeners();
    }
  }

  void handlePainKillerNotes(String notes) {
    painKillerData.painKillerNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void resetPainKillerSelection() {
    painKillerData = DataInitializations.categoriesData().painKillers;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = painKillerData.painKillersTime[index];
    for (var option in painKillerData.painKillersTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handlePainKillerLevelSelection(int level) {
    painKillerData.effectiveScale = level;
    notifyListeners();
  }

  bool validatePainKillersData(BuildContext context, bool isShow) {
    try {
      painKillerData.validate();
      return true;
    } catch (e) {
      isShow ? HelperFunctions.showNotification(context, e.toString()) : null;
      return false;
    }
  }

  Future<void> savePainKillerData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validatePainKillersData(context, true)) return;

    CustomLoading.showLoadingIndicator();
    try {
      final painKillerUsageRecord = await painKillerData.convertTo(provider.selectedDateOfUserForTracking.date);
      final result = await PainkillerService.savePainKillerTrackingData(painKillerUsageRecord);

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

  Future<void> fetchPainKillerData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await PainkillerService.getPainkillerTrackingData(date, timeOfDay);
      result.fold(
        (l) {
          CustomLoading.hideLoadingIndicator();
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
        },
        (r) {
          CustomLoading.hideLoadingIndicator();
          painKillerData.updateFrom(r);
          notifyListeners();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<InsightsGraphModel> fetchInsightsPainkillersAverageEffectivessChartData(String tenure, List<DateTime> selectedMonths, int selectedYear, String ingredient,
      {bool loading = true, bool notify = true}) async {
    insightsPainkillersAverageEffectivessChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await PainkillerService.fetchPainkillersAverageEffectivessGraphFromApi(tenure, selectedMonths, selectedYear, getActiveIngredientString(ingredient));
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsPainkillersAverageEffectivessChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsPainkillersPillsChartData(String tenure, List<DateTime> selectedMonths, int selectedYear, String ingredient,
      {bool loading = true, bool notify = true}) async {
    insightsPainkillersPillsChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await PainkillerService.fetchPainkillersPillsGraphFromApi(tenure, selectedMonths, selectedYear, getActiveIngredientString(ingredient));
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsPainkillersPillsChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<void> fetchInsightsPainkillersTagsCount(
    String tenure,
    List<DateTime> selectedMonths,
    int selectedYear,
    String ingredient,
  ) async {
    painKillersTagsCounts.isDataLoaded = false;
    notifyListeners();

    var result = await PainkillerService.fetchInsightsPainkillersTagsCountFromApi(tenure, selectedMonths, selectedYear, getActiveIngredientString(ingredient));
    result.fold(
      (l) {},
      (r) {
        painKillersTagsCounts = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPainkillersInCirclesData(String tenure, List<DateTime> selectedMonths, int selectedYear, String ingredient) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await PainkillerService.getPainkillersInCirclesData(tenure, selectedMonths, selectedYear, getActiveIngredientString(ingredient));
      result.fold(
        (l) {
          CustomLoading.hideLoadingIndicator();
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
        },
        (r) {
          CustomLoading.hideLoadingIndicator();
          painkillerInCirclesModel = r;
          notifyListeners();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  String getActiveIngredientString(String ingredient) {
    switch (ingredient) {
      case "All active ingredients":
        return "all";
      default:
        return ingredient;
    }
  }
}
