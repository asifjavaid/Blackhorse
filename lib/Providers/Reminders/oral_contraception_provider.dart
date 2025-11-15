import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class OralContraceptionProvider extends RemindersProvider {
  final List<String> lengthOptionsContraception = ["Select", "30", "60", "90", "120"];
  var selectedLengthContraception = "Select";
  DateTime contraceptionReminderDate = DateTime.now();
  DateTime contraceptionReminderTime = DateTime.now();
  String notesContraception = "Hey gorgeous! It’s time for your pill 💜";
  bool isContraceptionReminderSwitchedOn = false;
  bool _enableButton = true;

  void setContraceptionReminderSwitch(bool value) {
    isContraceptionReminderSwitchedOn = value;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setNotes(String newNote) {
    notesContraception = newNote;
    setEnableButton(true, notify: false);
    AppNavigation.goBack();

    notifyListeners();
  }

  void setLength(String? length) {
    selectedLengthContraception = length!;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setContraceptionReminderDate(dateTime) {
    contraceptionReminderDate = dateTime;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setContraceptionReminderTime(dateTime) {
    contraceptionReminderTime = dateTime;
    setEnableButton(true, notify: false);
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

  void handleCreateOrUpdateOralContraception() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? reminderId = await RemindersHelper.getReminderId(RemindersHelper.oralContraceptionsString);

    ContraceptionReminderModel data = ContraceptionReminderModel(
        userId: userId,
        contraceptionType: RemindersHelper.oralContraceptionsString,
        time: HelperFunctions.formatTime(contraceptionReminderTime),
        text: notesContraception,
        date: HelperFunctions.formatDate(contraceptionReminderDate),
        numOfPill: selectedLengthContraception == "Select" ? "" : selectedLengthContraception,
        active: isContraceptionReminderSwitchedOn);
    if (reminderDataValid(data)) {
      reminderId != null ? handleCreateOrUpdateContraceptionReminder(data: data, create: false, id: reminderId) : handleCreateOrUpdateContraceptionReminder(data: data);
    } else {
      HelperFunctions.showNotification(AppNavigation.currentContext!, "Please complete all required fields");
    }
  }

  void handleGetOralContraceptionReminder() async {
    String? id = await RemindersHelper.getReminderId(RemindersHelper.oralContraceptionsString);

    if (id != null) {
      handleGetContraceptionReminder(id).then((data) {
        if (data.id != null) {
          DateTime combinedDateAndTime = HelperFunctions.combineDateTime(data.date!, data.time!);
          contraceptionReminderTime = combinedDateAndTime;
          contraceptionReminderDate = combinedDateAndTime;
          notesContraception = data.text!;
          selectedLengthContraception = data.numOfPill!.isEmpty ? "Select" : data.numOfPill!;
          isContraceptionReminderSwitchedOn = data.active!;
          setEnableButton(false);
          notifyListeners();
        }
      });
    }
  }
}
