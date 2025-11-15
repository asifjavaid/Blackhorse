import 'dart:async';

import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FreeUserProvider extends ChangeNotifier {
  bool unlockStory = false;
  bool invitationToPower = false;
  bool premium = false;
  bool _info = false;
  PanelController? _panelController;

  bool get info => _info;

  FreeUserProvider() {
    _checkIfInstructionsViewed();
  }

  void resetValues() {
    unlockStory = true;
    invitationToPower = false;
    premium = false;
    _info = false;
  }

  void resetValuesWithNotify() {
    unlockStory = true;
    invitationToPower = false;
    premium = false;
    _info = false;
    notifyListeners();
  }

  Future<void> _checkIfInstructionsViewed() async {
    premium = UserManager().isPremium;
    unlockStory = !UserManager().isPremium;
    notifyListeners();
  }

  void updateInfoValue(bool value) async {
    _info = value;
    notifyListeners();
  }

  void invitationToPowerShow(bool show) {
    invitationToPower = show;
    notifyListeners();
  }

  // Set the PanelController
  void setPanelController(PanelController controller) {
    _panelController = controller;
  }

  // Toggle the value of info and animate the panel accordingly
  void toggleInfo() {
    _info = !_info;
    notifyListeners();
    _animatePanel();
  }

  // Animate the panel based on the value of info
  void _animatePanel() {
    if (_panelController != null) {
      if (_info) {
        _panelController!.animatePanelToPosition(
          1.0, // Full height
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _panelController!.animatePanelToPosition(
          0.3, // Adjust the position to a smaller height
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}
