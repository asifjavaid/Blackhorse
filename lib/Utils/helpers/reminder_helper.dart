import 'dart:convert';

import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class RemindersHelper {
  static const String _key = "reminderIDs";
  static const String oralContraceptionsString = "Oral (the pill)";
  static const String vaginalRingString = "Vaginal Ring";
  static const String contraceptivePatchString = "Contraceptive Patch";
  static const String contraceptiveInjectionString = "Contraceptive Injection";
  static const String iudString = "IUD";
  static const String contraceptiveImplantString = "Contraceptive implant";
  static const String periodReminderString = "Periods Reminder";
  static const String medicationReminderString = "Medication Reminder";

  static Future<Map<String, String>> getRemindersIDs() async {
    final String? remindersJson = await SharedPreferencesHelper.getStringPrefValue(key: _key);

    if (remindersJson != null) {
      final Map<String, dynamic> remindersMap = Map.from(json.decode(remindersJson));
      return Map<String, String>.from(remindersMap);
    } else {
      return {};
    }
  }

  static Future<void> updateReminderID(String reminderName, String reminderId) async {
    final Map<String, String> reminders = await getRemindersIDs();
    reminders[reminderName] = reminderId;
    await SharedPreferencesHelper.setMapPrefValue(key: _key, value: reminders);
  }

  static Future<void> deleteReminderID(String reminderId) async {
    final Map<String, String> reminders = await getRemindersIDs();
    if (reminders.containsValue(reminderId)) {
      reminders.removeWhere((key, value) => value == reminderId);
      await SharedPreferencesHelper.setMapPrefValue(key: _key, value: reminders);
    }
  }

  static Future<void> deleteAllReminderIDs() async {
    await SharedPreferencesHelper.setMapPrefValue(key: _key, value: {});
  }

  static Future<String?> getReminderId(String reminderName) async {
    final Map<String, String> reminders = await getRemindersIDs();
    return reminders[reminderName];
  }
}
