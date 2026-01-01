import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Models/EditProfle/user_profile_model.dart';
import 'package:ekvi/Models/Notifications/ekvipedia_notification_model.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/Notifications/notifications_service.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ConsentProvider extends ChangeNotifier {
  final List<String> consentMessages = [
    "I consent to Ekvi processing the health data I choose to share with the app, so that the app can provide me with personalized information and guidance.",
    "I consent to my anonymized health data being used for women's health research to help improve understanding and care for all women.",
    "I would like to receive information, tips and updates from Ekvi via email."
  ];

  bool _wantsConsent1 = false;
  bool get wantsConsent1 => _wantsConsent1;

  bool _wantsConsent2 = false;
  bool get wantsConsent2 => _wantsConsent2;

  bool _wantsConsent3 = false;
  bool get wantsConsent3 => _wantsConsent3;

  final PanelController panelController = PanelController();
  final UserManager _userManager = UserManager();
  UserProfileModel? _profileModel;
  String? errorMessage;


  void toggleBottomSheet() {
    panelController.isPanelOpen ? panelController.close() : panelController.open();
    notifyListeners();
  }

  void setWantsConsent1(bool? value, {bool notify = true}) {
    _wantsConsent1 = value ?? false;
    if (notify) notifyListeners();
  }

  void setWantsConsent2(bool? value, {bool notify = true}) {
    _wantsConsent2 = value ?? false;
    if (notify) notifyListeners();
  }

  void setWantsConsent3(bool? value, {bool notify = true}) {
    _wantsConsent3 = value ?? false;
    if (notify) notifyListeners();
  }
}
