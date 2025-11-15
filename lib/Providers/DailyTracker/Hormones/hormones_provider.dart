import 'package:ekvi/Models/DailyTracker/Hormones/hormones_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Hormones/hormones_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HormonesProvider extends ChangeNotifier {
  CategoryHormones hormonesData = DataInitializations.categoriesData().hormones;

  void resetHormonesSelection() {
    hormonesData = DataInitializations.categoriesData().hormones;
    notifyListeners();
  }

  void handleHormonesNotes(String notes) {
    hormonesData.notes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = hormonesData.hormonesTime[index];
    for (var option in hormonesData.hormonesTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handlehormonesCombinedPillsSelection(int index) {
    OptionModel selectedOption = hormonesData.hormonesCombinedPills[index];
    for (var option in hormonesData.hormonesCombinedPills) {
      if (option.text == selectedOption.text) {
        option.isSelected = !option.isSelected;
      }
    }
    notifyListeners();
  }

  bool validateHormonesData(BuildContext context) {
    try {
      hormonesData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveHormonesData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateHormonesData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await HormonesService.saveHormonesAnswers(await hormonesData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchHormonesData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await HormonesService.getHormonesDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        hormonesData.updateFrom(r);
        notifyListeners();
      },
    );
  }
}
