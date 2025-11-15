import 'dart:async';

import 'package:ekvi/Models/Authentication/authentication_amplitude_event.dart';
import 'package:ekvi/Models/Authentication/create_signicat_session_model.dart';
import 'package:ekvi/Models/Authentication/create_signicat_token_model.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Services/Login/login_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/auth_helper.dart';
import 'package:ekvi/Utils/helpers/google_signin_helper.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/intercom_helper.dart';
import 'package:ekvi/Utils/helpers/local_notification_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:ekvi/core/di/one_signal_singleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  CreateSignicatEkviTokenResponse createSignicatEkviTokenResponse = CreateSignicatEkviTokenResponse();
  CreateSignicatEkviSessionResponse createSignicatEkviSessionResponse = CreateSignicatEkviSessionResponse();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool showUnauthorizedNotification = false;
  var obsecureText = true;

  void changeVisibility() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  Future<void> handleLogout({bool navigateToLogin = true}) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    UserLogoutAmplitudeEvent(userId: userId!).log();
    // Sign out from Firebase (this handles the Apple sign-in session too)
    await FirebaseAuth.instance.signOut();
    GoogleSignInHelper.logOutOfGoogleAccount();

    // Clear shared preferences (excluding some keys)
    await SharedPreferencesHelper.removeAllKeysExcept(keysToKeep: ["languageCode"]);

    // Cancel all local notifications
    await LocalNotificationsHelper().cancelAllNotifications();

    // Log out from Intercom (if applicable)
    IntercomHelper.logOutIntercom();

    // Log out from OneSignal (if applicable)
    OneSignalService().logout();
    // Navigate to login screen if specified
    if (navigateToLogin) {
      Provider.of<DashboardProvider>(AppNavigation.currentContext!, listen: false).setBottomNavIndex(0);
      ScaffoldMessenger.of(AppNavigation.currentContext!).removeCurrentSnackBar();
      await AppNavigation.pushAndKillAll(AppRoutes.loginRoute);
    }
  }

  Future<bool> handleLogin() async {
    CustomLoading.showLoadingIndicator();

    final completer = Completer<bool>();

    final result = await LoginService.createSignicatEkviTokenApi(email: emailController.text);

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        CustomLoading.hideLoadingIndicator();
        completer.complete(false);
      },
      (r) {
        createSignicatEkviTokenResponse = r;
        notifyListeners();
        if (r.accessToken != null) {
          createSignicateEkviSession(r.accessToken!).then((sessionCreated) {
            CustomLoading.hideLoadingIndicator();
            AppNavigation.navigateTo(AppRoutes.signicatWebView, arguments: ScreenArguments(webviewData: createSignicatEkviSessionResponse, signicatAccessToken: r.accessToken));
          });
        }

        completer.complete(true);
      },
    );

    return completer.future;
  }

  Future<bool> createSignicateEkviSession(String token) async {
    final completer = Completer<bool>();

    final result = await LoginService.createSignicatEkviSessionApi(email: emailController.text, token: token);

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        completer.complete(false);
      },
      (r) {
        createSignicatEkviSessionResponse = r;
        notifyListeners();
        completer.complete(true);
      },
    );

    return completer.future;
  }

  Future<bool> handleLoginEkviUser({required String sessionID, required String token}) async {
    final completer = Completer<bool>();

    final result = await LoginService.loginEkviUser(sessionID: sessionID, token: token);

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        completer.complete(false);
      },
      (r) async {
        if (r.token != null) {
          await SharedPreferencesHelper.setStringPrefValue(
            key: "token",
            value: r.token!,
          );

          await SharedPreferencesHelper.setStringPrefValue(
            key: "userId",
            value: r.user!.id!,
          );
          await SharedPreferencesHelper.setStringPrefValue(
            key: "userEmail",
            value: r.user!.email!,
          );

          UserLoginAmplitudeEvent(loginMethod: "BankID", userSegment: "N/A", userId: r.user!.id!).log();
          await HelperFunctions.initializeUserData();

          AppNavigation.pushAndKillAll(AppRoutes.sideNavManager);
        }

        completer.complete(true);
      },
    );

    return completer.future;
  }

  Future<void> biometricAuthentication() async {
    try {
      final result = await LocalAuthApi.authenticate();
      result.fold((l) => HelperFunctions.showNotification(AppNavigation.currentContext!, l), (r) {
        if (r) {
          AppNavigation.pushAndKillAll(AppRoutes.sideNavManager);
        }
      });
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }
}
