import 'package:ekvi/Models/DailyTracker/BowelMovement/bathroom_habbits.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_model.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/insight_bowel_movement_circle_chart_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Models/Insights/insights_time_of_day_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/BowelMovements/bowel_movements_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BowelMovementProvider extends ChangeNotifier {
  CategoryBowelMovement _bowelMovementData = DataInitializations.categoriesData().bowlMovement;
  SymptomFeedback _symptomFeedback = SymptomFeedback();
  InsightsGraphModel _insightsAverageBMChartData = InsightsGraphModel();
  InsightsTimeOfDayGraphModel _insightsTimeOfDayChartData = InsightsTimeOfDayGraphModel();
  InsightsBowelMovementCircleModel _insightsCircleChartData = InsightsBowelMovementCircleModel();
  BowelMovTagList _bowelMovTagList = BowelMovTagList();
  final List<Color> activeTrackColors = [
    AppColors.errorColor500,
    AppColors.errorColor500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.successColor500,
    AppColors.successColor500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.errorColor500,
    AppColors.errorColor500,
  ];

  /// Getters
  CategoryBowelMovement get bowelMovementData => _bowelMovementData;
  SymptomFeedback get symptomFeedback => _symptomFeedback;
  InsightsGraphModel get insightsAverageBMChartData => _insightsAverageBMChartData;
  InsightsTimeOfDayGraphModel get insightsTimeDayBMChartData => _insightsTimeOfDayChartData;
  InsightsBowelMovementCircleModel get insightsBMCircleChartData => _insightsCircleChartData;
  BowelMovTagList get bowelMovTaglist => _bowelMovTagList;

  void resetBowelMovSeletion() {
    _bowelMovementData = DataInitializations.categoriesData().bowlMovement;
    notifyListeners();
  }

  void handleBowelMovNotes(String notes) {
    _bowelMovementData.bowelMovementNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = _bowelMovementData.bowelMovementTime[index];
    for (var option in _bowelMovementData.bowelMovementTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleBowelMovLevelSelection(int level) {
    _bowelMovementData.bowelMovementLevel = level;
    notifyListeners();
  }

  void handleFrequencyLevelSelection(int level) {
    _bowelMovementData.frequencyLevel = level;
    notifyListeners();
  }

  void handleBowelMovOptionsSelection(int index) {
    OptionModel selectedOption = _bowelMovementData.bristolStoolScaleOptions[index];
    for (var option in _bowelMovementData.bristolStoolScaleOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleBowelMovDurationSelection(int index) {
    OptionModel selectedOption = _bowelMovementData.durationOptions[index];
    for (var option in _bowelMovementData.durationOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleBowelMovColorSelection(int index) {
    OptionModel selectedOption = _bowelMovementData.colorOptions[index];
    for (var option in _bowelMovementData.colorOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleBowelMovSizeSelection(int index) {
    OptionModel selectedOption = _bowelMovementData.sizeOptions[index];
    for (var option in _bowelMovementData.sizeOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleBowelMovEffortsSelection(int index) {
    OptionModel selectedOption = _bowelMovementData.effortOptions[index];
    for (var option in _bowelMovementData.effortOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleBowelMovUnusualComponentSelection(int index) {
    OptionModel selectedOption = _bowelMovementData.unusualComponentsOptions[index];
    for (var option in _bowelMovementData.unusualComponentsOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  bool validateBMData(BuildContext context) {
    try {
      _bowelMovementData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  Future<void> fetchBowelMovData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await BowelMovementService.getBowelMovRequest(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        _bowelMovementData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  void patchBowelMovRequest(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateBMData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await BowelMovementService.patchBowelMovRequest(await _bowelMovementData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  void fetchBowelMovFeedbackStatus() async {
    var result = await BowelMovementService.getBowelMovFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        _symptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateBowelMovFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Bowel Movements", feedback: answer).log();
    var result = await BowelMovementService.patchFeedbackRequest(_symptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
        notifyListeners();
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        _symptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageBowelMovementChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    _insightsAverageBMChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await BowelMovementService.fetchInsightsBowelMovAverageGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        notifyListeners();
        return _insightsAverageBMChartData;
      },
      (r) {
        _insightsAverageBMChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsTimeOfDayGraphModel> fetchInsightsTimeOfDayMovementChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    _insightsTimeOfDayChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await BowelMovementService.fetchInsightsBowelMovTimeOfDayGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (notify) notifyListeners();
        return _insightsTimeOfDayChartData;
      },
      (r) {
        _insightsTimeOfDayChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<InsightsBowelMovementCircleModel> fetchInsightsCircleMovementChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    _insightsCircleChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    var result = await BowelMovementService.fetchInsightsBowelMovCircleGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (notify) notifyListeners();
        return _insightsCircleChartData;
      },
      (r) {
        _insightsCircleChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchBowelMovTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    _bowelMovTagList.isDataLoaded = false;
    notifyListeners();

    var result = await BowelMovementService.getBowelMovTags(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {
        notifyListeners();
      },
      (r) {
        _bowelMovTagList = r;
        notifyListeners();
      },
    );
  }

  List<BathroomHabit> sortAnswersByTimeOfDay(List<BathroomHabit> data) {
    List<String> order = [
      'Morning',
      'Afternoon',
      'Evening',
      'Night',
      'AllDay',
    ];

    data.sort((a, b) {
      return order.indexOf(a.timeOfDay!) - order.indexOf(b.timeOfDay!);
    });

    return data;
  }
}
