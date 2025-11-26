import 'package:ekvi/Models/DailyTracker/BowelMovement/bathroom_habbits.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_model.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/insight_bowel_movement_circle_chart_model.dart';
import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Models/Insights/insights_time_of_day_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/BowelMovements/bowel_movements_service.dart';
import 'package:ekvi/Services/DailyTracker/Urination/urination_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/DailyTracker/Urination/urination_tag_list.dart';
import '../../../Models/Urination/urination_urgency_model.dart';
import '../../../Utils/constants/app_enums.dart';

class UrinationProvider extends ChangeNotifier {
  CategoryUrinationUrgency _urinationUrgencyData = DataInitializations.categoriesData().urinationUrgency;
  SymptomFeedback _symptomFeedback = SymptomFeedback();
  InsightsGraphModel _insightsAverageBMChartData = InsightsGraphModel();
  InsightsGraphModel _insightsTimeOfDayChartData = InsightsGraphModel();
  InsightsBowelMovementCircleModel _insightsCircleChartData = InsightsBowelMovementCircleModel();
  UrinaitonTagList _urinationTagList = UrinaitonTagList();
  final List<Color> activeTrackColors = [
    AppColors.successColor500,
    AppColors.successColor500,
    AppColors.successColor500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.errorColor500,
    AppColors.errorColor500,
    AppColors.errorColor500,
  ];

  /// Getters
  CategoryUrinationUrgency get urinationUrgencyData => _urinationUrgencyData;
  SymptomFeedback get symptomFeedback => _symptomFeedback;
  InsightsGraphModel get insightsAverageBMChartData => _insightsAverageBMChartData;
  InsightsGraphModel get insightsTimeDayBMChartData => _insightsTimeOfDayChartData;
  InsightsBowelMovementCircleModel get insightsBMCircleChartData => _insightsCircleChartData;
  UrinaitonTagList get urinationTaglist => _urinationTagList;

  void resetUrinationSeletion() {
    _urinationUrgencyData = DataInitializations.categoriesData().urinationUrgency;
    notifyListeners();
  }

  void handleBowelMovNotes(String notes) {
    _urinationUrgencyData.urineUrgencyNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = _urinationUrgencyData.urinationUrgencyTime[index];
    for (var option in _urinationUrgencyData.urinationUrgencyTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleUrinationUrgencyLevelSelection(int level) {
    _urinationUrgencyData.urinationUrgencyLevel = level;
    notifyListeners();
  }

  void handleFrequencyLevelSelection(int level) {
    _urinationUrgencyData.frequencyLevel = level;
    notifyListeners();
  }

  void handleUrinationUrgencyOptionsSelection(int index) {
    OptionModel selectedOption = _urinationUrgencyData.sensationOptions[index];
    for (var option in _urinationUrgencyData.sensationOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleEventOptionSelection(PainEventsCategory category, OptionModel option, int index, [int? impactLevel]) {
    switch (index) {
      case 6: // Impact on life
        switch (option.text) {
          case "Work":
            _urinationUrgencyData.bodyPain.headache.impactGrid.workValue = impactLevel!;
            break;
          case "Social life":
            _urinationUrgencyData.bodyPain.headache.impactGrid.socialLifeValue = impactLevel!;
            break;
          case "Sleep":
            _urinationUrgencyData.bodyPain.headache.impactGrid.sleepValue = impactLevel!;
            break;
          case "Quality of life":
            _urinationUrgencyData.bodyPain.headache.impactGrid.qualityOfLifeValue = impactLevel!;
            break;
        }
        break;
    }
    notifyListeners();
  }

  void handleSmellOptionsSelection(int index) {
    OptionModel selectedOption = _urinationUrgencyData.smellOptions[index];
    for (var option in _urinationUrgencyData.smellOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleVolumeOptionsSelection(int index) {
    OptionModel selectedOption = _urinationUrgencyData.volumeOptions[index];
    for (var option in _urinationUrgencyData.volumeOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleUrinationColorSelection(int index) {
    OptionModel selectedOption = _urinationUrgencyData.colorOptions[index];
    for (var option in _urinationUrgencyData.colorOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleUrinationComplicationSelection(int index) {
    OptionModel selectedOption = _urinationUrgencyData.complications[index];
    for (var option in _urinationUrgencyData.complications) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleDiagnosesSelection(int index) {
    OptionModel selectedOption = _urinationUrgencyData.diagnoses[index];
    for (var option in _urinationUrgencyData.diagnoses) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleSensationOptionsSelection(int index) {
    OptionModel selectedOption = _urinationUrgencyData.sensationOptions[index];
    for (var option in _urinationUrgencyData.sensationOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  bool validateBMData(BuildContext context) {
    try {
      _urinationUrgencyData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  Future<void> fetchUrinationData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await UrinationUrgencyService.getUrinationRequest(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        _urinationUrgencyData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  void patchUrinationUrgencyRequest(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateBMData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await UrinationUrgencyService.patchUrinationUrgencyRequest(
          await _urinationUrgencyData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  void fetchUrinationFeedbackStatus() async {
    var result = await UrinationUrgencyService.getUrinationFeedbackStatus();
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
    var result = await UrinationUrgencyService.patchFeedbackRequest(_symptomFeedback.id!, answer);
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

  Future<InsightsGraphModel> fetchInsightsAverageUrinationChart(String tenure, List<DateTime> selectedMonths, int selectedYear,
      {bool loading = true, bool notify = true}) async {
    _insightsAverageBMChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await UrinationUrgencyService.fetchInsightsUrinationAverageGraphFromApi(tenure, selectedMonths, selectedYear);
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

  Future<InsightsGraphModel> fetchInsightsTimeOfDayUrinationChart(String tenure, List<DateTime> selectedMonths, int selectedYear,
      {bool notify = true}) async {
    _insightsTimeOfDayChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await UrinationUrgencyService.fetchInsightsUrinationTimeOfDayGraphFromApi(tenure, selectedMonths, selectedYear);
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

  Future<InsightsBowelMovementCircleModel> fetchInsightsCircleMovementChart(String tenure, List<DateTime> selectedMonths, int selectedYear,
      {bool notify = true}) async {
    _insightsCircleChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    var result = await UrinationUrgencyService.fetchInsightsUrinationCircleGraphFromApi(tenure, selectedMonths, selectedYear);
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

  Future<void> fetchUrinationTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    _urinationTagList.isDataLoaded = false;
    notifyListeners();

    var result = await UrinationUrgencyService.getUrinationTags(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {
        notifyListeners();
      },
      (r) {
        _urinationTagList = r;
        notifyListeners();
      },
    );
  }

  List<UrinationUrgencyResponseModel> sortAnswersByTimeOfDay(List<UrinationUrgencyResponseModel> data) {
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
