// ignore_for_file: avoid_print, file_names

import 'dart:developer';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  static final OneSignalService _instance = OneSignalService._internal();

  factory OneSignalService() => _instance;

  OneSignalService._internal();

  /// Initializes the OneSignal service with optional user consent.
  Future<void> initialize({bool requireConsent = false}) async {
    if (kDebugMode) _configureOneSignalLogging();
    OneSignal.consentRequired(requireConsent);
    OneSignal.initialize(AppConstant.oneSignalKey);
    OneSignal.LiveActivities.setupDefault();
    _loginUserIfAvailable();
    _addObservers();
  }

  /// Logs in the user if a user ID is available.
  void _loginUserIfAvailable() async {
    final userId = UserManager().userId;
    final email = UserManager().email;

    if (userId != null) {
      log("Initializing OneSignal with userID $userId");
      login(userId);
    }
    if (email != null) {
      log("Adding email to OneSignal $email");
      OneSignal.User.addEmail(email);
    }
  }

  /// Configures OneSignal's log and alert levels for debugging.
  void _configureOneSignalLogging() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  }

  /// Adds necessary observers to handle OneSignal events.
  void _addObservers() {
    OneSignal.User.addObserver((state) {
      print('User state changed: ${state.jsonRepresentation()}');
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print('Notification permission changed: $state');
    });

    OneSignal.Notifications.addClickListener((event) {
      print('Notification clicked: ${event.notification.jsonRepresentation()}');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print('Notification received in foreground: ${event.notification.jsonRepresentation()}');
      event.preventDefault();
      event.notification.display();
    });
  }

  /// Requests push notification permission from the user.
  void requestPushPermission() => OneSignal.Notifications.requestPermission(true);

  /// Logs in a user with a specific [externalUserId] for OneSignal tracking.
  void login(String externalUserId) => OneSignal.login(externalUserId);

  /// Logs out the currently logged-in user from OneSignal.
  void logout() => OneSignal.logout();

  /// Retrieves the external user ID for the logged-in user.
  Future<String?> getExternalUserId() => OneSignal.User.getExternalId();

  /// Retrieves the OneSignal ID associated with the current user.
  Future<String?> getOneSignalId() => OneSignal.User.getOnesignalId();

  /// Sets the user's consent status for OneSignal tracking.
  void setConsent(bool consent) => OneSignal.consentGiven(consent);
}
