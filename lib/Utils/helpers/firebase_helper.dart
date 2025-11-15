import 'dart:async';

import 'package:ekvi/Models/Authentication/store_fcm_token.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/Login/login_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/local_notification_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // print("Title: ${message.notification?.title}");
  // print("Body: ${message.notification?.body}");
  // print("data: ${message.data}");
  await Firebase.initializeApp();
  LocalNotificationsHelper().showNotifcation(id: 100, title: message.data["title"], body: message.data["body"]);
}

class FirebaseHelper {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    String? fCMToken;

    try {
      fCMToken = await getDeviceToken();
    } catch (e) {
      // ignore: avoid_print
      print("Error while getting FCM token: $e");
    }

    if (fCMToken != null) {
      // initPushNotifications();
      // storeFCMToken(fCMToken);
    }
  }

  Future<String?> getDeviceToken() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    String? deviceToken = await _firebaseMessaging.getToken();
    return deviceToken;
  }

  Future<void> storeFCMToken(String token) async {
    final userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");

    final result = await LoginService.handleStoreFCMToken(payload: StoreFCMTokenModel(userId: userId, notificationToken: token, deviceType: HelperFunctions.getDeviceType()));

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
      },
      (r) {},
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationsHelper().showNotifcation(title: message.data["title"], body: message.data["body"]);
    });
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }
}
