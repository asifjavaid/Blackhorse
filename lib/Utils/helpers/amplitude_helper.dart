import 'package:amplitude_flutter/amplitude.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';

class AmplitudeHelper {
  static late Amplitude _amplitude;

  static void init() {
    _amplitude = Amplitude.getInstance(instanceName: AppConstant.appName);
    _amplitude.init(
      AppConstant.amplitudeAPIKey,
    );
    _amplitude.enableCoppaControl();
    _amplitude.trackingSessionEvents(true);
    _amplitude.setEventUploadThreshold(1);
    _amplitude.setEventUploadPeriodMillis(3000);
  }

  static void logEvent(String eventName, {Map<String, dynamic>? properties}) {
    _amplitude.logEvent(eventName, eventProperties: properties);
  }

  static void setUserId(String? userId) {
    _amplitude.setUserId(userId);
  }

  static void setUserProperties(Map<String, dynamic> properties) {
    _amplitude.setUserProperties(properties);
  }

  static void uploadEvents() {
    _amplitude.uploadEvents();
  }
}
