import 'package:ekvi/Models/Insights/insights_amplitude_events.dart';
import 'package:ekvi/Providers/Insights/insights_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/PainKillers/pain_killer_service.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';

enum TimeFrameSelection { oneMonth, threeMonths, oneYear }

class InsightsSymptomTimeSelectionProvider with ChangeNotifier {
  String _selectedSymptom = 'Pain';
  String _selectedActiveIngredient = 'All active ingredients';

  String selectedMonthString = "1 month";
  final int _currentYear = DateTime.now().year;
  final int _currentMonth = DateTime.now().month;
  final int _minYear = 2022;
  TimeFrameSelection _selectionType = TimeFrameSelection.oneMonth;
  int _selectedYear = DateTime.now().year;
  final List<DateTime> _selectedMonths = [
    HelperFunctions.getFirstDateOfCurrentMonth()
  ];

  List<InisghtsSymptom> symptoms = [
    InisghtsSymptom(name: 'Pain', icon: Assets.customiconsBolt),
    InisghtsSymptom(name: 'Bleeding', icon: Assets.customiconsDrip),
    InisghtsSymptom(name: 'Headache', icon: Assets.customiconsHeadache),
    InisghtsSymptom(name: 'Mood', icon: Assets.customiconsEmotions),
    InisghtsSymptom(name: 'Stress', icon: Assets.customiconsStress),
    InisghtsSymptom(name: 'Energy', icon: Assets.customiconsEnergy),
    InisghtsSymptom(name: 'Nausea', icon: Assets.customiconsNausea),
    InisghtsSymptom(name: 'Fatigue', icon: Assets.customiconsFatigue),
    InisghtsSymptom(name: 'Bloating', icon: Assets.customiconsBloating),
    InisghtsSymptom(name: 'Brain fog', icon: Assets.customiconsBrainfog),
    InisghtsSymptom(name: 'Bowel movement', icon: Assets.customiconsBowelMovent),
    InisghtsSymptom(name: 'Urination', icon: Assets.customiconsUrination),
    InisghtsSymptom(name: 'Painkillers', icon: Assets.customiconsPill1),
    InisghtsSymptom(name: 'Movement', icon: Assets.customiconsTraining),
    InisghtsSymptom(name: 'Self-care', icon: Assets.customiconsFollicular),
    InisghtsSymptom(name: 'Pain relief', icon: Assets.customiconsPainRelief),
  ];

  final List<String> listPainKillerIngredients = <String>[
    'All active ingredients'
  ];

  int get selectedYear => _selectedYear;
  List<DateTime> get selectedMonths => _selectedMonths;

  int get currentYear => _currentYear;
  int get minYear => _minYear;
  TimeFrameSelection get selectionType => _selectionType;

  bool get greaterThanMinYear => selectedYear > minYear;
  bool get lessThanCurrentYear => selectedYear < currentYear;

  String get selectedSymptom => _selectedSymptom;
  String get selectedActiveIngredient => _selectedActiveIngredient;

  void setSelectedSymptom(String symptom) {
    _selectedSymptom = symptom;
    InsightsToggleViewEvent(
            symptom: symptom, timeFrame: getMonthString(selectionType))
        .log();
    Provider.of<InsightsProvider>(AppNavigation.currentContext!, listen: false)
        .callAllInsightsAPIs();
    notifyListeners();
  }

  void setSelectedActiveIngredient(String ingredient) {
    _selectedActiveIngredient = ingredient;
    Provider.of<InsightsProvider>(AppNavigation.currentContext!, listen: false)
        .callAllInsightsAPIs();
    notifyListeners();
  }

  void setSelectedMonthString() {
    selectedMonthString = getMonthString(selectionType);
    InsightsToggleViewEvent(
            symptom: selectedSymptom, timeFrame: selectedMonthString)
        .log();
    notifyListeners();
  }

  void setSelectionType(TimeFrameSelection type) {
    _selectionType = type;
    _selectedMonths.clear();
    notifyListeners();
  }

  void selectYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void selectMonth(int monthIndex) {
    _selectedMonths.clear();

    if (_selectionType == TimeFrameSelection.threeMonths) {
      for (int i = 0; i < 3; i++) {
        int yearOffset = (monthIndex + i - 1) ~/ 12;
        int selectMonth =
            (monthIndex + i) % 12 == 0 ? 12 : (monthIndex + i) % 12;
        int year = _selectedYear + yearOffset;

        DateTime selectDate = DateTime(year, selectMonth);
        if (year < _currentYear ||
            (year == _currentYear && selectMonth <= _currentMonth)) {
          _selectedMonths.add(selectDate);
        }
      }
    } else if (_selectionType == TimeFrameSelection.oneMonth) {
      DateTime selectDate = DateTime(_selectedYear, monthIndex);
      if (_selectedYear < _currentYear ||
          (_selectedYear == _currentYear && monthIndex <= _currentMonth)) {
        _selectedMonths.add(selectDate);
      }
    }

    notifyListeners();
  }

  bool isMonthSelectable(int month) {
    return _selectedYear < _currentYear || month <= _currentMonth;
  }

  String getMonthString(TimeFrameSelection type) {
    return type == TimeFrameSelection.oneMonth
        ? '1 month'
        : type == TimeFrameSelection.threeMonths
            ? '3 months'
            : '1 year';
  }

  String getSelectedItemForMultiSymptomChart() {
    return selectedSymptom == 'Painkillers'
        ? selectedActiveIngredient
        : selectedSymptom;
  }

  Future<void> loadUserIngredients() async {
    final result = await PainkillerService.fetchUserActiveIngredients();
    result.fold(
      (err) {
        debugPrint('Failed to fetch ingredients: $err');
      },
      (List<String> ingredients) {
        listPainKillerIngredients
          ..clear()
          ..add('All active ingredients')
          ..addAll(ingredients);
        notifyListeners();
      },
    );
  }
}

class InisghtsSymptom {
  final String name;
  final String? icon;
  Color? color;

  InisghtsSymptom({required this.name, this.icon, this.color});
}
