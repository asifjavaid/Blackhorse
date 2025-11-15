import 'package:flutter_timezone/flutter_timezone.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

class TimeHelper {
  static void initializeTimezones() async {
    tz.initializeTimeZones();
  }

  static Future<String> getCurrentTimezone() async {
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    return timezoneInfo.identifier;
  }
}
