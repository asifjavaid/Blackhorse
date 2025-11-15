import 'package:ekvi/Utils/helpers/amplitude_helper.dart';

abstract class BaseEvent {
  String get eventName;
  String get description;
  Future<Map<String, dynamic>?> get properties;

  void log() async {
    AmplitudeHelper.logEvent(eventName, properties: await properties);
  }
}
