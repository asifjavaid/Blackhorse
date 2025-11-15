import 'package:ekvi/Models/DailyTracker/Energy/energy_model.dart';
import 'package:ekvi/Models/DailyTracker/Energy/energy_tags_count.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Energy/energy_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnergyProvider extends ChangeNotifier {
  CategoryEnergy energyData = DataInitializations.categoriesData().energy;
  SymptomFeedback energySymptomFeedback = SymptomFeedback(isFeedbackSaved: true);
  InsightsGraphModel insightsAverageEnergyChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumEnergyChartData = InsightsGraphModel();
  EnergyTagList energyTagCounts = EnergyTagList(energyTags: []);

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

  void resetEnergySelection() {
    energyData = DataInitializations.categoriesData().energy;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = energyData.energyTime[index];
    for (var option in energyData.energyTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleEnergyLevelSelection(int level) {
    energyData.energyLevel = level;
    notifyListeners();
  }

  void handleEnergyOptionsSelection(int index) {
    OptionModel selectedOption = energyData.energyOptions[index];

    for (var option in energyData.energyOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleEnergyNotes(String notes) {
    energyData.energyNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void saveEnergyData(BuildContext context) async {
    EnergyResponseModel payload = EnergyResponseModel();
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    try {
      payload = await energyData.convertTo(provider.selectedDateOfUserForTracking.date);
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
      return;
    }
    CustomLoading.showLoadingIndicator();
    var result = await EnergyService.saveEnergyAnswers(payload);
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

  void fetchEnergyFeedbackStatus() async {
    var result = await EnergyService.getEnergyFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        energySymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateEnergyFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Energy", feedback: answer).log();

    var result = await EnergyService.updateEnergyFeedbackStatus(energySymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        energySymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<void> fetchEnergyData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await EnergyService.getEnergyDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();

        energyData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageEnergyChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageEnergyChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await EnergyService.fetchInsightsAverageEnergyGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageEnergyChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumEnergyChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    insightsMaximumEnergyChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await EnergyService.fetchInsightsMaximumEnergyGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumEnergyChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsEnergyTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    energyTagCounts.isDataLoaded = false;
    notifyListeners();

    var result = await EnergyService.fetchInsightsEnergyTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        energyTagCounts = r;
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
