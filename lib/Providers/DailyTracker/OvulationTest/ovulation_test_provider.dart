import 'package:ekvi/Models/DailyTracker/OvulationTest/ovulation_test_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/OvulationTest/ovulation_test_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OvulationTestProvider extends ChangeNotifier {
  CategoryOvulationTest ovulationTestData = DataInitializations.categoriesData().ovulationTest;

  void resetOvulationTestSelection() {
    ovulationTestData = DataInitializations.categoriesData().ovulationTest;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = ovulationTestData.ovulationTestTime[index];
    for (var option in ovulationTestData.ovulationTestTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleResultSelection(int index) {
    OptionModel selectedOption = ovulationTestData.ovulationTestResult[index];
    for (var option in ovulationTestData.ovulationTestResult) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool validateOvulationTestData(BuildContext context) {
    try {
      ovulationTestData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveOvulationTestData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateOvulationTestData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await OvulationTestService.saveOvulationTestAnswers(await ovulationTestData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchOvulationTestData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await OvulationTestService.getOvulationTestlDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        ovulationTestData.updateFrom(r);
        notifyListeners();
      },
    );
  }
}
