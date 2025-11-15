import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class IUDReminderProvider extends RemindersProvider {
  bool isIUDReminderSwitchTurnedOn = false;
  String iudNotes = "Hey gorgeous! It’s time to check your string 💜";

  final List<String> iudTypes = [
    "Type of IUD",
    "Hormonal IUD",
    "Copper IUD",
  ];
  var selectedIUD = "Type of IUD";
  final List<String> iudPeriodOfUse = [
    "Period of use",
    "1",
    "2",
    "3",
    "4",
  ];
  var iudSelectedPeriodOfUse = "Period of use";
  DateTime iudReminderDate = DateTime.now();
  DateTime iudReminderTime = DateTime.now();
  bool _enableButton = true;

  void setIudReminderDate(DateTime date) {
    iudReminderDate = date;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setIudNotes(String newNote) {
    iudNotes = newNote;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setIUD(String? iud) {
    selectedIUD = iud!;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setIUDReminderSwitch(bool value) {
    isIUDReminderSwitchTurnedOn = value;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setIudReminderTime(DateTime time) {
    iudReminderTime = time;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setIudPeriodOfUse(String? length) {
    iudSelectedPeriodOfUse = length!;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setEnableButton(bool value, {bool notify = true}) {
    _enableButton = value;
    if (notify) notifyListeners();
  }

  bool get enableButton => _enableButton;

  bool reminderDataValid(ContraceptionReminderModel data) {
    return data.userId != null && data.time!.isNotEmpty && data.date!.isNotEmpty && data.iudType != "Type of IUD" && data.periodOfUse != "Period of use";
  }

  void handleCreateOrUpdateIUD() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? reminderId = await RemindersHelper.getReminderId(RemindersHelper.iudString);

    ContraceptionReminderModel data = ContraceptionReminderModel(
        userId: userId,
        contraceptionType: RemindersHelper.iudString,
        time: HelperFunctions.formatTime(iudReminderTime),
        text: iudNotes,
        date: HelperFunctions.formatDate(iudReminderDate),
        iudType: selectedIUD,
        periodOfUse: iudSelectedPeriodOfUse,
        active: isIUDReminderSwitchTurnedOn);
    if (reminderDataValid(data)) {
      reminderId != null ? handleCreateOrUpdateContraceptionReminder(data: data, create: false, id: reminderId) : handleCreateOrUpdateContraceptionReminder(data: data);
    } else {
      HelperFunctions.showNotification(AppNavigation.currentContext!, "Please complete all required fields");
    }
  }

  void handleGetIUDReminder() async {
    String? id = await RemindersHelper.getReminderId(RemindersHelper.iudString);
    if (id != null) {
      handleGetContraceptionReminder(id).then((data) {
        if (data.id != null) {
          DateTime combinedDateAndTime = HelperFunctions.combineDateTime(data.date!, data.time!);
          iudReminderTime = combinedDateAndTime;
          iudReminderDate = combinedDateAndTime;
          iudNotes = data.text!;
          selectedIUD = data.iudType!;
          iudSelectedPeriodOfUse = data.periodOfUse!;
          isIUDReminderSwitchTurnedOn = data.active!;
          setEnableButton(false);

          notifyListeners();
        }
      });
    }
  }
}
