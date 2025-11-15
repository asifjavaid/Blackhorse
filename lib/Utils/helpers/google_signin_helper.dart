import 'dart:developer';

import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSignInHelper {
  static final googleSignIn = GoogleSignIn();

  static Future<void> continueWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      Provider.of<RegisterProvider>(AppNavigation.currentContext!, listen: false).communicateSocialLoginToServer("Google", ApiLinks.googleAuthentication, googleAuth.accessToken!);
    } catch (e) {
      log(e.toString());
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  static Future<void> logOutOfGoogleAccount() async {
    try {
      googleSignIn.signOut();
    } catch (e) {
      // Handle potential errors, perhaps log the error
    }
  }
}
