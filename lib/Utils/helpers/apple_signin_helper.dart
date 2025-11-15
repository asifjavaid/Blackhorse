import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AppleSignInHelper {
  static Future<void> continueWithApple() async {
    try {
      AppleAuthProvider appleProvider = AppleAuthProvider()
        ..addScope("email")
        ..addScope("name");
      final credential = await FirebaseAuth.instance.signInWithProvider(appleProvider);
      Provider.of<RegisterProvider>(AppNavigation.currentContext!, listen: false).communicateSocialLoginToServer("Apple", ApiLinks.appleAuthentication, credential.credential!.accessToken!);
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }
}
