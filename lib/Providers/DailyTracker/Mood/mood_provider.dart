import 'package:ekvi/Components/DailyTracker/Mood/suicide_help_dialog.dart';
import 'package:ekvi/Models/DailyTracker/Mood/mood_model.dart';
import 'package:ekvi/Models/DailyTracker/Mood/mood_tag_count.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Mood/mood_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoodProvider extends ChangeNotifier {
  CategoryMood moodData = DataInitializations.categoriesData().mood;
  InsightsGraphModel insightsAverageMoodChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumMoodChartData = InsightsGraphModel();
  MoodTagList moodTagCounts = MoodTagList(moodTags: []);

  String suicideString = "Suicidal";
  List<String> moodLevels = ["Awful", "Poor", "Okay", "Good", "Great"];
  SymptomFeedback moodSymptomFeedback = SymptomFeedback();
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

  void resetMoodSelection() {
    moodData = DataInitializations.categoriesData().mood;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = moodData.moodTime[index];
    for (var option in moodData.moodTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleMoodLevelSelection(int level) {
    moodData.moodLevel = level;
    notifyListeners();
  }

  void handleMoodOptionsSelection(int index, {bool showDialog = true}) {
    OptionModel selectedOption = moodData.moodOptions[index];
    if (selectedOption.text == suicideString && !selectedOption.isSelected && showDialog) showSuicideHelpDialog();
    for (var option in moodData.moodOptions) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  void handleMoodNotes(String notes) {
    moodData.moodNotes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  static showSuicideHelpDialog() {
    showDialog(
        context: AppNavigation.currentContext!,
        builder: (BuildContext context) {
          return const SuicideHelpDialog();
        });
  }

  bool validateMoodData(BuildContext context, bool validateTags) {
    try {
      moodData.validate(validateTags);
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  Future<MoodResponseModel?> saveMoodData(BuildContext context, {String? date, bool navigate = true, bool validateTags = false}) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateMoodData(context, validateTags)) return null;
    CustomLoading.showLoadingIndicator();
    try {
      MoodResponseModel payload = await moodData.convertTo(date ?? provider.selectedDateOfUserForTracking.date);
      var result = await MoodService.saveMoodAnswers(payload);
      return result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          CustomLoading.hideLoadingIndicator();
          return MoodResponseModel();
        },
        (r) async {
          CustomLoading.hideLoadingIndicator();
          if (navigate) {
            AppNavigation.goBack();
            provider.consultBackendForCompletedCategories();
            notifyListeners();
          }
          return payload;
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
      return null;
    }
  }

  Future<CategoryMood> fetchMoodData(String date, String timeOfDay, {bool showLoader = true}) async {
    if (showLoader) CustomLoading.showLoadingIndicator();

    var result = await MoodService.getMoodDataFromApi(date, timeOfDay);
    return result.fold(
      (l) {
        if (showLoader) CustomLoading.hideLoadingIndicator();
        return DataInitializations.categoriesData().mood;
      },
      (r) async {
        if (showLoader) CustomLoading.hideLoadingIndicator();
        moodData.updateFrom(r);
        notifyListeners();
        return moodData;
      },
    );
  }

  void fetchMoodFeedbackStatus() async {
    var result = await MoodService.getMoodFeedbackStatus();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (r) async {
        moodSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  void updateMoodFeedbackStatus(bool answer) async {
    AmpltudeSymptomFeedback(symptomCategory: "Mood", feedback: answer).log();
    var result = await MoodService.updateMoodFeedbackStatus(moodSymptomFeedback.id!, answer);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        await Future.delayed(const Duration(seconds: 5));
        moodSymptomFeedback = r;
        notifyListeners();
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsAverageMoodChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool loading = true, bool notify = true}) async {
    insightsAverageMoodChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await MoodService.fetchInsightsAverageMoodGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAverageMoodChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumMoodChart(String tenure, List<DateTime> selectedMonths, int selectedYear, {bool notify = true}) async {
    insightsMaximumMoodChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await MoodService.fetchInsightsMaximumMoodGraphFromApi(tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumMoodChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsMoodTagsCount(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    moodTagCounts.isDataLoaded = false;
    notifyListeners();

    var result = await MoodService.fetchInsightsMoodTagsCountFromApi(tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {},
      (r) {
        moodTagCounts = r;
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
