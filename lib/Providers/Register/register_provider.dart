import 'dart:async';
import 'package:ekvi/Models/Authentication/authentication_amplitude_event.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Services/Registration/registration_service.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterProvider extends ChangeNotifier {
  final Uri _url = Uri.parse(ApiLinks.termsAndConditions);
  bool _hasAgreedToTOS = false;
  bool _wantsNewsletter = false;
  Color mandatoryCheckboxColor = Colors.black;
  int step = 1;
  // Google sign in
  final googleSignIn = GoogleSignIn();
  bool get hasAgreedToTOS => _hasAgreedToTOS;
  bool get wantsNewsletter => _wantsNewsletter;
  Uri get url => _url;

  Future<void> launchTOSUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void setHasAgreedToTOS(bool? value, {bool notify = true}) {
    _hasAgreedToTOS = value ?? false;
    if (notify) notifyListeners();
  }

  void setWantsNewsLetter(bool? value, {bool notify = true}) {
    _wantsNewsletter = value ?? false;
    if (notify) notifyListeners();
  }

  void resetform() {
    setHasAgreedToTOS(false, notify: false);
    setWantsNewsLetter(false, notify: false);
  }

  Future<bool> communicateSocialLoginToServer(String loginMethod, String endPoint, String token) async {
    CustomLoading.showLoadingIndicator(usePostFrameCallback: false);

    final completer = Completer<bool>();

    final result = await RegistrationService.communicateSocialLoginToServerFromApi(endPoint, token);

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
        CustomLoading.hideLoadingIndicator();
        completer.complete(false);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        await SharedPreferencesHelper.setStringPrefValue(
          key: "userId",
          value: r.user!.id!,
        );
        await SharedPreferencesHelper.setStringPrefValue(
          key: "userEmail",
          value: r.user!.email!,
        );
        await SharedPreferencesHelper.setStringPrefValue(
          key: "token",
          value: r.token!,
        );

        UserLoginAmplitudeEvent(loginMethod: loginMethod, userSegment: "N/A", userId: r.user!.id!).log();
        await HelperFunctions.initializeUserData();

        if (r.isOnboarded != null && r.isOnboarded!) {
          AppNavigation.pushAndKillAll(AppRoutes.sideNavManager);
        } else {
          AppNavigation.pushAndKillAll(AppRoutes.onboarding);
        }

        completer.complete(true);
      },
    );

    return completer.future;
  }
}
