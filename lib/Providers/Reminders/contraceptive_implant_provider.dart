import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class ContraceptiveImplantProvider extends RemindersProvider {
  final List<String> contraceptiveImplantPeriodOfUseOptions = ["Period of use", "1", "2", "3", "4", "5", "6", "7", "8"];
  var selectedPeriodOfUse = "Period of use";
  DateTime contraceptiveImplantReminderDate = DateTime.now();
  DateTime contraceptiveImplantReminderTime = DateTime.now();
  String contraceptiveImplantNotes = "Hey gorgeous! It’s time for a new implant 💜";
  bool isContraceptiveImplantSwitchOn = false;
  bool _enableButton = true;

  void setContraceptiveImplantSwitch(bool value) {
    isContraceptiveImplantSwitchOn = value;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setContraceptionImplantReminderDate(DateTime date) {
    contraceptiveImplantReminderDate = date;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setContraceptiveImplantReminderTime(DateTime time) {
    contraceptiveImplantReminderTime = time;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setNotes(String newNote) {
    contraceptiveImplantNotes = newNote;
    setEnableButton(true, notify: false);
    AppNavigation.goBack();

    notifyListeners();
  }

  void setPeriodOfUse(String? length) {
    selectedPeriodOfUse = length!;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setEnableButton(bool value, {bool notify = true}) {
    _enableButton = value;
    if (notify) notifyListeners();
  }

  bool get enableButton => _enableButton;

  bool reminderDataValid(ContraceptionReminderModel data) {
    return data.userId != null && data.time!.isNotEmpty && data.date!.isNotEmpty && data.periodOfUse != "Period of use";
  }

  void handleCreateOrUpdateContraceptivesImplant() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? reminderId = await RemindersHelper.getReminderId(RemindersHelper.contraceptiveImplantString);
    ContraceptionReminderModel data = ContraceptionReminderModel(
        userId: userId,
        contraceptionType: RemindersHelper.contraceptiveImplantString,
        time: HelperFunctions.formatTime(contraceptiveImplantReminderTime),
        text: contraceptiveImplantNotes,
        date: HelperFunctions.formatDate(contraceptiveImplantReminderDate),
        periodOfUse: selectedPeriodOfUse,
        active: isContraceptiveImplantSwitchOn);
    if (reminderDataValid(data)) {
      reminderId != null ? handleCreateOrUpdateContraceptionReminder(data: data, create: false, id: reminderId) : handleCreateOrUpdateContraceptionReminder(data: data);
    } else {
      HelperFunctions.showNotification(AppNavigation.currentContext!, "Please complete all required fields");
    }
  }

  void handleGetContraceptivesImplantReminder() async {
    String? id = await RemindersHelper.getReminderId(RemindersHelper.contraceptiveImplantString);
    if (id != null) {
      handleGetContraceptionReminder(id).then((data) {
        if (data.id != null) {
          DateTime combinedDateAndTime = HelperFunctions.combineDateTime(data.date!, data.time!);

          contraceptiveImplantReminderTime = combinedDateAndTime;
          contraceptiveImplantReminderDate = combinedDateAndTime;
          contraceptiveImplantNotes = data.text!;
          selectedPeriodOfUse = data.periodOfUse!;
          isContraceptiveImplantSwitchOn = data.active!;
          setEnableButton(false);

          notifyListeners();
        }
      });
    }
  }
}
