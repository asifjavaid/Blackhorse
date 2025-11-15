import 'package:ekvi/Models/DailyTracker/PregnancyTest/pregnancy_test_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/PregnancyTest/pregnancy_test_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PregnancyTestProvider extends ChangeNotifier {
  CategoryPregnancyTest pregnancyTestData = DataInitializations.categoriesData().pregnancyTest;

  void resetPregnancyTestSelection() {
    pregnancyTestData = DataInitializations.categoriesData().pregnancyTest;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = pregnancyTestData.pregnancyTestTime[index];
    for (var option in pregnancyTestData.pregnancyTestTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleResultSelection(int index) {
    OptionModel selectedOption = pregnancyTestData.pregnancyTestResult[index];
    for (var option in pregnancyTestData.pregnancyTestResult) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool validatePregnancyTestData(BuildContext context) {
    try {
      pregnancyTestData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void savePregnancyTestData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validatePregnancyTestData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await PregnancyTestService.savePregnancyTestAnswers(await pregnancyTestData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchPregnancyTestData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await PregnancyTestService.getPregnancyTestlDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        pregnancyTestData.updateFrom(r);
        notifyListeners();
      },
    );
  }
}
