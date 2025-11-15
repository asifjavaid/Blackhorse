import 'package:flutter/material.dart';

enum WellbeingTab { movement, selfcare, painRelief }

class YourWellBeingProvider extends ChangeNotifier {
  WellbeingTab _selectedTab = WellbeingTab.movement;
  WellbeingTab get selectedTab => _selectedTab;

  void selectTab(WellbeingTab tab) {
    if (_selectedTab != tab) {
      _selectedTab = tab;
      notifyListeners();
    }
  }
}
