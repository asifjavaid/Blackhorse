import 'package:ekvi/Models/DailyTracker/Nausea/nausea_model.dart';
import 'package:ekvi/Models/DailyTracker/Nausea/nausea_tag_count.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
// import 'package:ekvi/Services/DailyTracker/Mood/mood_service.dart';
import 'package:ekvi/Services/DailyTracker/Nausea/nausea_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NauseaProvider extends ChangeNotifier {
  CategoryNausea nauseaData = DataInitializations.categoriesData().nausea;
  List<String> nauseaLevels = ["Very mild", "Mild", "Moderate", "Severe", "Very severe"];
  SymptomFeedback nauseaSymptomFeedback = SymptomFeedback();
  InsightsGraphModel insightsAverageNauseaChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumNauseaChartData = InsightsGraphModel();
  NauseaTagList nauseaTagCounts = NauseaTagList();

  void handleNauseaNotes(String notes) {
    nauseaData.nauseaNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void resetNauseaSelection() {
    nauseaData = DataInitializations.categoriesData().nausea;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = nauseaData.nauseaTime[index];
    for (var option in nauseaData.nauseaTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleNauseaLevelSelection(int level) {
    nauseaData.nauseaLevel = level;
    notifyListeners();
  }

  void handleNauseaOptionsSelection(int index) {
    OptionModel selectedOption = nauseaData.nauseaOptions[index];
    for (var option in nauseaData.nauseaOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleNauseaDurationSelection(int index) {
    OptionModel selectedOption = nauseaData.durationOptions[index];
    for (var option in nauseaData.durationOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool validateNauseaData(BuildContext context) {
    try {
      nauseaData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveNauseaData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateNauseaData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await NauseaService.saveNauseaAnswers(await nauseaData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchNauseaData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await NauseaService.getNauseaDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        nauseaData.updateFrom(r);
        notifyListeners();
      },
    );
  }

  void fetchNauseaFeedbackStatus() async {
    var result = await NauseaService.getNauseaFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        nauseaSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateNauseaFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Nausea", feedback: answer).log();
    var result = await NauseaService.updateNauseaFeedbackStatus(nauseaSymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        nauseaSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageNauseaChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageNauseaChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await NauseaService.fetchInsightsAverageNauseaGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageNauseaChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumNauseaChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    insightsMaximumNauseaChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await NauseaService.fetchInsightsMaximumNauseaGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumNauseaChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsNauseaTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    nauseaTagCounts.isDataLoaded = false;
    notifyListeners();

    var result = await NauseaService.fetchInsightsNauseaTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        nauseaTagCounts = r;
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
