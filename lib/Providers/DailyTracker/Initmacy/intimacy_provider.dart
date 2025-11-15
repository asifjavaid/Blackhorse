import 'package:ekvi/Models/DailyTracker/Intimacy/intimacy_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Initmacy/intimacy_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntimacyProvider extends ChangeNotifier {
  CategoryIntimacy intimacyData = DataInitializations.categoriesData().intimacy;

  void resetIntimacySelection() {
    intimacyData = DataInitializations.categoriesData().intimacy;
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = intimacyData.intimacyTime[index];
    for (var option in intimacyData.intimacyTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleTypeOfIntimacySelection(int index) {
    OptionModel selectedOption = intimacyData.typeOfIntimacy[index];
    for (var option in intimacyData.typeOfIntimacy) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleIntimacyActivitySelection(int index) {
    OptionModel selectedOption = intimacyData.activityOfInitmacy[index];
    for (var option in intimacyData.activityOfInitmacy) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  bool validateIntimacyData(BuildContext context) {
    try {
      intimacyData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveIntimacyData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateIntimacyData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await IntimacyService.saveIntimacyAnswers(await intimacyData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchIntimacyData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await IntimacyService.getIntimacyDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        intimacyData.updateFrom(r);
        notifyListeners();
      },
    );
  }
}
