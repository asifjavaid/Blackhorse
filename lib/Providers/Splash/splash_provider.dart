import 'dart:async';

import 'package:ekvi/Models/Registration/welcome_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class SplashProvider extends ChangeNotifier {
  bool enableBiometricAuthentication = false;
  List<WelcomeModel> welcomeData = [
    WelcomeModel(
        AppLocalizations.of(AppNavigation.currentContext!)!
            .not_regular_period_tracker_title,
        AppLocalizations.of(AppNavigation.currentContext!)!
            .not_regular_period_tracker_description),
    WelcomeModel(
        AppLocalizations.of(AppNavigation.currentContext!)!
            .health_companion_title,
        AppLocalizations.of(AppNavigation.currentContext!)!
            .health_companion_description),
    WelcomeModel(
        AppLocalizations.of(AppNavigation.currentContext!)!
            .revolutionizing_support_title,
        AppLocalizations.of(AppNavigation.currentContext!)!
            .revolutionizing_support_description),
  ];

  updateWelcomeData(BuildContext context) {
    welcomeData = [
      WelcomeModel(
          AppLocalizations.of(context)!.not_regular_period_tracker_title,
          AppLocalizations.of(context)!.not_regular_period_tracker_description),
      WelcomeModel(AppLocalizations.of(context)!.health_companion_title,
          AppLocalizations.of(context)!.health_companion_description),
      WelcomeModel(AppLocalizations.of(context)!.revolutionizing_support_title,
          AppLocalizations.of(context)!.revolutionizing_support_description),
    ];
  }

  int currentWelcomeDataIndex = 0;

  void updateCurrentWelcomeData(int index) {
    currentWelcomeDataIndex = index;
    notifyListeners();
  }

  bool showText = false;

  void setShowText(bool show) {
    showText = show;
    notifyListeners();
  }

  void showTextTyper() {
    var duration = const Duration(seconds: 2);
    Timer(duration, () => setShowText(true));
  }

  void decideNavigation() async {
    String? userId =
        await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? token =
        await SharedPreferencesHelper.getStringPrefValue(key: "token");

    if (userId != null && token != null) {
      enableBiometricAuthentication = true;
      notifyListeners();
    } else {
      AppNavigation.pushReplacementTo(AppRoutes.welcomeRoute);
    }
  }
}
