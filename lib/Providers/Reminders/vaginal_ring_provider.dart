import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class VaginalRingProvider extends RemindersProvider {
  String notes = "Hey gorgeous! It’s time to get a new ring 💜";
  bool isVaginalRingReminderSwitchedOn = false;
  DateTime vaginalRingReminderDate = DateTime.now();
  DateTime vaginalRingReminderTime = DateTime.now();
  bool _enableButton = true;

  void setVaginalRingReminderDate(DateTime date) {
    vaginalRingReminderDate = date;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setVaginalRingReminderTime(DateTime time) {
    vaginalRingReminderTime = time;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setVaginalRingReminderSwitch(bool value) {
    isVaginalRingReminderSwitchedOn = value;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setNotes(String newNote) {
    notes = newNote;
    setEnableButton(true, notify: false);
    AppNavigation.goBack();

    notifyListeners();
  }

  void setEnableButton(bool value, {bool notify = true}) {
    _enableButton = value;
    if (notify) notifyListeners();
  }

  bool get enableButton => _enableButton;
  bool reminderDataValid(ContraceptionReminderModel data) {
    return data.userId != null && data.time!.isNotEmpty && data.date!.isNotEmpty;
  }

  void handleCreateOrUpdateVaginalRing() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? reminderId = await RemindersHelper.getReminderId(RemindersHelper.vaginalRingString);

    ContraceptionReminderModel data = ContraceptionReminderModel(
        userId: userId,
        contraceptionType: RemindersHelper.vaginalRingString,
        time: HelperFunctions.formatTime(vaginalRingReminderTime),
        text: notes,
        date: HelperFunctions.formatDate(vaginalRingReminderDate),
        active: isVaginalRingReminderSwitchedOn);
    if (reminderDataValid(data)) {
      reminderId != null ? handleCreateOrUpdateContraceptionReminder(data: data, create: false, id: reminderId) : handleCreateOrUpdateContraceptionReminder(data: data);
    } else {
      HelperFunctions.showNotification(AppNavigation.currentContext!, "Please complete all required fields");
    }
  }

  void handleGetVaginalRingReminder() async {
    String? id = await RemindersHelper.getReminderId(RemindersHelper.vaginalRingString);
    if (id != null) {
      handleGetContraceptionReminder(id).then((data) {
        if (data.id != null) {
          DateTime combinedDateAndTime = HelperFunctions.combineDateTime(data.date!, data.time!);
          vaginalRingReminderTime = combinedDateAndTime;
          vaginalRingReminderDate = combinedDateAndTime;
          notes = data.text!;
          isVaginalRingReminderSwitchedOn = data.active!;
          setEnableButton(false);
          notifyListeners();
        }
      });
    }
  }
}
