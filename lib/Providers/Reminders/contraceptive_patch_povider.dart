import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class ContraceptivePatchProvider extends RemindersProvider {
  final List<String> lengthOptionsContraception = ["Number of Patches", "1", "2", "3", "4", "5", "6", "7", "8"];
  var selectedLengthContraception = "Number of Patches";
  DateTime contraceptivePatchReminderDate = DateTime.now();
  DateTime contraceptivePatchReminderTime = DateTime.now();
  String notesContraceptivePatch = "Hey gorgeous! It’s time for a new patch 💜";
  bool isContraceptivePatchSwitchOn = false;
  bool _enableButton = true;

  void setContraceptivePatchSwitch(bool value) {
    isContraceptivePatchSwitchOn = value;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setNotes(String newNote) {
    notesContraceptivePatch = newNote;
    setEnableButton(true, notify: false);
    AppNavigation.goBack();

    notifyListeners();
  }

  void setContraceptivePatchReminderDate(DateTime date) {
    contraceptivePatchReminderDate = date;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setContraceptivePatchReminderTime(DateTime date) {
    contraceptivePatchReminderTime = date;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setContraceptionLength(String? length) {
    selectedLengthContraception = length!;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setEnableButton(bool value, {bool notify = true}) {
    _enableButton = value;
    if (notify) notifyListeners();
  }

  bool get enableButton => _enableButton;

  bool reminderDataValid(ContraceptionReminderModel data) {
    return data.userId != null && data.time!.isNotEmpty && data.date!.isNotEmpty && data.numOfPill != "Number of Patches";
  }

  void handleCreateOrUpdateContraceptivePatch() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? reminderId = await RemindersHelper.getReminderId(RemindersHelper.contraceptivePatchString);

    ContraceptionReminderModel data = ContraceptionReminderModel(
        userId: userId,
        contraceptionType: RemindersHelper.contraceptivePatchString,
        time: HelperFunctions.formatTime(contraceptivePatchReminderTime),
        text: notesContraceptivePatch,
        date: HelperFunctions.formatDate(contraceptivePatchReminderDate),
        numOfPill: selectedLengthContraception,
        active: isContraceptivePatchSwitchOn);
    if (reminderDataValid(data)) {
      reminderId != null ? handleCreateOrUpdateContraceptionReminder(data: data, create: false, id: reminderId) : handleCreateOrUpdateContraceptionReminder(data: data);
    } else {
      HelperFunctions.showNotification(AppNavigation.currentContext!, "Please complete all required fields");
    }
  }

  void handleGetContraceptivePatchReminder() async {
    String? id = await RemindersHelper.getReminderId(RemindersHelper.contraceptivePatchString);
    if (id != null) {
      handleGetContraceptionReminder(id).then((data) {
        if (data.id != null) {
          DateTime combinedDateAndTime = HelperFunctions.combineDateTime(data.date!, data.time!);

          contraceptivePatchReminderTime = combinedDateAndTime;
          contraceptivePatchReminderDate = combinedDateAndTime;
          notesContraceptivePatch = data.text!;
          selectedLengthContraception = data.numOfPill!;
          isContraceptivePatchSwitchOn = data.active!;
          setEnableButton(false);

          notifyListeners();
        }
      });
    }
  }
}
