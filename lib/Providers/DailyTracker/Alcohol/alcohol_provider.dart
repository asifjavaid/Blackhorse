import 'package:ekvi/Models/DailyTracker/Alcohol/alcohol_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/Alcohol/alcohol_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlcoholProvider extends ChangeNotifier {
  CategoryAlcohol alcoholData = DataInitializations.categoriesData().alcohol;
  final List<String> lengthOptions = [
    "Select units",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30"
  ];

  void resetAlcoholSelection() {
    alcoholData = DataInitializations.categoriesData().alcohol;
    notifyListeners();
  }

  void handleAlcoholNotes(String notes) {
    alcoholData.notes = notes;
    AppNavigation.goBack();
    notifyListeners();
  }

  void handleTimeSelection(
    int index,
  ) {
    OptionModel selectedOption = alcoholData.alcoholTime[index];
    for (var option in alcoholData.alcoholTime) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  void handleAlcoholUnitSelection(String? units) {
    alcoholData.units = units ?? "";

    notifyListeners();
  }

  void handleTypeOfAlcoholSelection(int index) {
    OptionModel selectedOption = alcoholData.typeOfAlcohol[index];
    for (var option in alcoholData.typeOfAlcohol) {
      if (option.text == selectedOption.text) {
        option.isSelected = true;
      } else {
        option.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool validateAlcoholData(BuildContext context) {
    try {
      alcoholData.validate();
      return true;
    } catch (e) {
      HelperFunctions.showNotification(context, e.toString());
      return false;
    }
  }

  void saveAlcoholData(BuildContext context) async {
    var provider = Provider.of<DailyTrackerProvider>(context, listen: false);

    if (!validateAlcoholData(context)) return;
    CustomLoading.showLoadingIndicator();
    try {
      var result = await AlcoholService.saveAlcoholAnswers(await alcoholData.convertTo(provider.selectedDateOfUserForTracking.date));
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

  Future<void> fetchAlcoholData(String date, String timeOfDay) async {
    CustomLoading.showLoadingIndicator();

    var result = await AlcoholService.getAlcoholDataFromApi(date, timeOfDay);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        alcoholData.updateFrom(r);
        notifyListeners();
      },
    );
  }
}
