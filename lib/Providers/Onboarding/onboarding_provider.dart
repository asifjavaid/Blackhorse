// import 'package:ekvi/Components/Onboarding/tutorial_dialog.dart';
import 'package:ekvi/Models/Onboarding/cycle_tracking_model.dart';
import 'package:ekvi/Models/Onboarding/onboarding_model.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_helper.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Services/Onboarding/onboarding_service.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
// import 'package:ekvi/Widgets/Dialogs/custom_dialog.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  OnboardingModel onboardingQuestion = OnboardingModel();
  CycleTrackingModel cycleTracking = CycleTrackingModel(periodStartDate: "Select date", cycleLength: "Set Cycle Length", periodLength: "Set Period Length", diagnosisTimeframe: "1 year");
  OboardingUserCycleData cycleTrackingDateTime = OboardingUserCycleData();
  bool saveCycleInformationFlag = false;
  bool welcomeNote = false;
  bool isResumed = false;

  bool get anyAnswerSelected => onboardingQuestion.answersList?.any((ans) => ans.selected) ?? false;
  bool get wasLastQuestion => onboardingQuestion.lastQuestion ?? false;
  double get userProgressValue {
    if (onboardingQuestion.completedQuestion != null && onboardingQuestion.maxProgress != null && onboardingQuestion.maxProgress!.isNotEmpty) {
      try {
        int maxProgressInt = int.parse(onboardingQuestion.maxProgress!);
        if (maxProgressInt > 0) {
          return onboardingQuestion.completedQuestion! / maxProgressInt;
        }
      } catch (e) {
        // print('Error calculating user progress: $e');
      }
    }
    return 0.0;
  }

  void setPeriodStartDate(DateTime date) {
    cycleTracking.periodStartDate = HelperFunctions.getFormattedDateFromDateTime(date);
    cycleTrackingDateTime.periodStartDate = date;
    notifyListeners();
  }

  void setCycleLength(int length) {
    cycleTracking.cycleLength = length.toString();
    cycleTrackingDateTime.cycleLength = length.toString();
    notifyListeners();
  }

  void setPeriodLength(int length) {
    cycleTracking.periodLength = length.toString();
    cycleTrackingDateTime.periodLength = length.toString();
    notifyListeners();
  }

  void setDiagnosisTime(int index) {
    cycleTracking.diagnosisTimeframe = OnboardingHelper.diagnosisYearsList[index];
    cycleTrackingDateTime.diagnosisTimeframe = OnboardingHelper.diagnosisYearsList[index];
    bool exists = onboardingQuestion.answersList != null && onboardingQuestion.answersList!.isNotEmpty;
    if (exists) {
      handleOptionSelection(onboardingQuestion.answersList![0].id!);
    }
    notifyListeners();
  }

  void hideWelcomeNote() {
    welcomeNote = false;
    notifyListeners();
  }

  void showWelcomeNote() {
    welcomeNote = true;
    notifyListeners();
  }

  void setIsResumed(bool resumed) {
    isResumed = resumed;
    if (isResumed) OnboardingHelper.showWelcomeBackDialog();
    notifyListeners();
  }

  void handleOptionSelection(String answerId) {
    if (onboardingQuestion.selection == OnboardingHelper.singularSelection) {
      onboardingQuestion.answersList?.forEach((answer) {
        answer.selected = (answer.id == answerId);
      });
    } else {
      // For non-singular selections, toggle the selected status of the specific answer
      var answer = onboardingQuestion.answersList?.firstWhere(
        (ans) => ans.id == answerId,
        orElse: () => OnboardingAnswerModel(),
      );

      if (answer != null && (answer.id?.isNotEmpty ?? false)) {
        answer.selected = !answer.selected;
      }
    }

    notifyListeners();
  }

  Future<void> fetchUserProgress({bool showLoader = true}) async {
    if (showLoader) CustomLoading.showLoadingIndicator();

    final result = await OnboardingService.fetchUserProgressFromAPI();
    result.fold(
      (l) {
        if (showLoader) CustomLoading.hideLoadingIndicator();
      },
      (r) {
        onboardingQuestion = r;
        if (showLoader) CustomLoading.hideLoadingIndicator();
        (onboardingQuestion.firstQuestion ?? false) ? showWelcomeNote() : setIsResumed(true);

        notifyListeners();
      },
    );
  }

  Future<void> saveUserAnswer({bool showLoader = true}) async {
    if (wasLastQuestion) {
      AppNavigation.pushAndKillAll(AppRoutes.sideNavManager);
      return;
    }

    if (showLoader) CustomLoading.showLoadingIndicator();
    final result = await OnboardingService.saveUserAnswerFromAPI(OnboardingHelper.handleCreateOnboardingAnswer(onboardingQuestion), wasLastQuestion);
    result.fold(
      (l) {
        if (showLoader) CustomLoading.hideLoadingIndicator();
      },
      (r) async {
        onboardingQuestion = r;
        if (showLoader) CustomLoading.hideLoadingIndicator();
        notifyListeners();
      },
    );
  }

  Future<void> goBackToPreviousAnswer() async {
    CustomLoading.showLoadingIndicator();

    final result = await OnboardingService.getBackToPreviousAnswerFromAPI(onboardingQuestion.completedQuestion!);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
      },
      (r) async {
        onboardingQuestion = r;
        if (onboardingQuestion.questionId != null) handleGetSavedAnswer(onboardingQuestion.questionId!);
        CustomLoading.hideLoadingIndicator();
        notifyListeners();
      },
    );
  }

  Future<void> syncUserCycleInformation() async {
    final result = await OnboardingService.syncUserCycleInformationFromAPI(await OnboardingHelper.handleCreateCycleTrackingPayload(cycleTrackingDateTime));
    result.fold(
      (l) {},
      (r) async {},
    );
  }

  Future<void> syncUserResponse() async {
    if (OnboardingHelper.syncingQuestionIds.contains(onboardingQuestion.questionId)) {
      final syncUserCycleInformationFuture = syncUserCycleInformation();
      final saveUserAnswerFuture = saveUserAnswer();
      final updateFutures = <Future<void>>[syncUserCycleInformationFuture, saveUserAnswerFuture];
      CustomLoading.showLoadingIndicator();
      await Future.wait(updateFutures);
      CustomLoading.hideLoadingIndicator();
    } else {
      saveUserAnswer();
    }
  }

  void handleGetSavedAnswer(String questionId) {
    void parseAndSetAnswer(String questionId, String answer) {
      switch (questionId) {
        case "4":
          setPeriodStartDate(DateTime.parse(answer));
          break;
        case "5":
          setCycleLength(int.parse(answer));
          break;
        case "19":
          setDiagnosisTime(OnboardingHelper.diagnosisYearsList.indexOf(answer));
          break;
        default:
          break;
      }
    }

    if (onboardingQuestion.selectedAnswer != null && onboardingQuestion.selectedAnswer!.isNotEmpty) {
      parseAndSetAnswer(questionId, onboardingQuestion.selectedAnswer!);
    }
    for (var id in onboardingQuestion.selectedAnswerIds!) {
      handleOptionSelection(id);
    }
  }
}
