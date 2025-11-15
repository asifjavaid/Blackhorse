import 'package:ekvi/Components/Onboarding/number_picker.dart';
import 'package:ekvi/Components/Onboarding/tutorial_dialog.dart';
import 'package:ekvi/Models/Onboarding/cycle_tracking_model.dart';
import 'package:ekvi/Models/Onboarding/onboarding_answer_model.dart';
import 'package:ekvi/Models/Onboarding/onboarding_model.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OnboardingHelper {
  static String singularSelection = "Single";
  static const String selectDateString = "Select date";
  static const String selectCycleLengthString = "Set Cycle Length";
  static const String selectPeriodLengthString = "Set Period Length";
  static const List<String> syncingQuestionIds = ["4", "5", "19"];
  static const String diagnosisQuestionID = "19";
  static const String firstQuestionId = "1";
  static List<String> diagnosisYearsList = List.generate(10, (index) => "${index + 1} year${index == 0 ? '' : 's'}");

  static OnboardingAnswer handleCreateOnboardingAnswer(OnboardingModel data) {
    return OnboardingAnswer(
      questionId: data.questionId,
      answerIds: data.answersList?.where((answer) => (answer.answerText?.isEmpty ?? false) || answer.selected).map((answer) => answer.id).where((id) => id != null).map((id) => id!).toList(),
    );
  }

  static Future<CycleTrackingModel> handleCreateCycleTrackingPayload(OboardingUserCycleData data) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");

    return CycleTrackingModel(
        userId: userId!,
        periodStartDate: data.periodStartDate != null ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(data.periodStartDate!) : null,
        cycleLength: data.cycleLength,
        periodLength: data.periodLength,
        diagnosisTimeframe: data.diagnosisTimeframe);
  }

  static Map<String, dynamic> getOptionButtonData({
    required OnboardingAnswerModel option,
    required OnboardingProvider provider,
    required BuildContext context,
    required VoidCallback goBackCallback,
  }) {
    String optionText = option.answerText!;
    VoidCallback onPressed;
    bool isSelected = option.selected;

    if (option.answerText == selectDateString) {
      optionText = provider.cycleTracking.periodStartDate!;
      onPressed = () {
        HelperFunctions.showSheet(context, child: HelperFunctions.buildDatePicker(provider.cycleTrackingDateTime.periodStartDate, provider.setPeriodStartDate), onClicked: goBackCallback);
        provider.handleOptionSelection(option.id!);
      };
    } else if (option.answerText == selectCycleLengthString) {
      optionText = provider.cycleTracking.cycleLength!;
      onPressed = () {
        HelperFunctions.showSheet(
          context,
          child: Selector<OnboardingProvider, String>(
            selector: (_, provider) => provider.cycleTracking.cycleLength!,
            builder: (context, cycleLength, child) {
              return NumberPickerOnboarding(
                selectedNumber: cycleLength,
                onSelectedItemChanged: (int index) => provider.setCycleLength(index),
              );
            },
          ),
          onClicked: goBackCallback,
        );

        provider.handleOptionSelection(option.id!);
      };
    } else if (option.answerText == selectPeriodLengthString) {
      optionText = provider.cycleTracking.periodLength!;
      onPressed = () {
        HelperFunctions.showSheet(
          context,
          child: Selector<OnboardingProvider, String>(
            selector: (_, provider) => provider.cycleTracking.periodLength!,
            builder: (context, periodLength, child) {
              return NumberPickerOnboarding(
                selectedNumber: periodLength,
                onSelectedItemChanged: (int index) => provider.setPeriodLength(index),
              );
            },
          ),
          onClicked: goBackCallback,
        );

        provider.handleOptionSelection(option.id!);
      };
    } else {
      onPressed = () => provider.handleOptionSelection(option.id!);
    }

    return {
      'optionText': optionText,
      'onPressed': onPressed,
      'isSelected': isSelected,
    };
  }

  static showWelcomeBackDialog() {
    showDialog(
        context: AppNavigation.currentContext!,
        builder: (BuildContext context) {
          return const TutorialDialog();
        });
  }
}
