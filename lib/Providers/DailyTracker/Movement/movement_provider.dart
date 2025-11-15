import 'package:ekvi/Models/DailyTracker/Movement/movement_in_circle_model.dart';
import 'package:ekvi/Models/DailyTracker/Movement/movement_model.dart';
import 'package:ekvi/Models/DailyTracker/Movement/movement_tags.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Movement/movement_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovementProvider extends ChangeNotifier {
  CategoryMovement categoryMovements = DataInitializations.categoriesData().movements;
  List<String> intenseLevels = ["Very light", "Light", "Moderate", "Hard", "Vary hard"];
  List<String> enjoymentLevels = ["Terrible", "Meh", "Decent", "Good", "Amazing"];

  InsightsGraphModel insightsAverageIntensityChartData = InsightsGraphModel();
  InsightsGraphModel insightsAverageEnjoymentChartData = InsightsGraphModel();
  InsightsGraphModel insightMovementDurationChartData = InsightsGraphModel();
  MovementTagsCount movementTagsCounts = MovementTagsCount(isDataLoaded: false);
  InsightsMovementCircleModel movementInCirclesModel = InsightsMovementCircleModel(
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

  void setDateTime(DateTime value) {
    categoryMovements.durationTime = value;
    notifyListeners();
  }

  void handleMovementNotes(String notes) {
    categoryMovements.movementsNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void resetMovementSelection() {
    categoryMovements = DataInitializations.categoriesData().movements;
    notifyListeners();
  }

  void handleTimeSelection(int index) {
    OptionModel selectedOption = categoryMovements.movementsOptionalModel[index];
    for (var option in categoryMovements.movementsOptionalModel) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleIntensitySelection(int level) {
    categoryMovements.intensityScale = level;
    notifyListeners();
  }

  void handleEnjoymentSelection(int level) {
    categoryMovements.enjoymentScale = level;
    notifyListeners();
  }

  void handleMovementPractice(String practice) {
    if (categoryMovements.practices.contains(practice)) {
      categoryMovements.practices.remove(practice);
    } else {
      categoryMovements.practices.add(practice);
    }

    notifyListeners();
  }

  bool validateMovementsData(BuildContext context, bool isShow) {
    try {
      categoryMovements.validate();
      return true;
    } catch (e) {
      isShow ? HelperFunctions.showNotification(context, e.toString()) : null;
      return false;
    }
  }

  Future<void> saveMovementsLog(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateMovementsData(context, true)) return;

    CustomLoading.showLoadingIndicator();
    try {
      final movementsData = await categoryMovements.convertTo(provider.selectedDateOfUserForTracking.date);
      final result = await MovementService.saveMovementsLog(movementsData);

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

  Future<void> fetchCategoryMovement(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await MovementService.getMovementTrackingData(date, timeOfDay);
      result.fold(
        (l) {
          CustomLoading.hideLoadingIndicator();
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
        },
        (r) {
          CustomLoading.hideLoadingIndicator();

          categoryMovements.updateFrom(r);
          notifyListeners();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<InsightsGraphModel> fetchInsightsAverageIntensityChartData(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageIntensityChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await MovementService.fetchAverageIntensityGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageIntensityChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageEnjoymentChartData(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageEnjoymentChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await MovementService.fetchAverageEnjoymentGraphFromApi(tenure, selectedMonths, selectedYear);
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

  Future<InsightsGraphModel> fetchInsightsMovementDurationChartData(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightMovementDurationChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await MovementService.fetchMovementDurationGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightMovementDurationChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<void> fetchInsightsMovementTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    movementTagsCounts.isDataLoaded = false;
    notifyListeners();

    var result = await MovementService.fetchInsightsMovementTagsCountFromApi(tenure, selectedMonths, selectedYear);

    result.fold(
      (l) {
        movementTagsCounts = MovementTagsCount(isDataLoaded: false);
        notifyListeners();
      },
      (r) {
        movementTagsCounts = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchMovementInCirclesData(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await MovementService.getMovementInCirclesData(tenure, selectedMonths, selectedYear);
      result.fold(
        (l) {
          CustomLoading.hideLoadingIndicator();
          movementInCirclesModel = InsightsMovementCircleModel(isDataLoaded: false);
          notifyListeners();
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
        },
        (r) {
          CustomLoading.hideLoadingIndicator();
          movementInCirclesModel = r;
          notifyListeners();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }
}
