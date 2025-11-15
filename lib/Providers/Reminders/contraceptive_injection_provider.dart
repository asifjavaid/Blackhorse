import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class ContraceptiveInjectionProvider extends RemindersProvider {
  final List<String> contraceptionInjectionFrequecyOptions = ["Injection frequency", "4", "8", "12", "16", "20"];
  var selectedFrequency = "Injection frequency";
  DateTime contraceptionInjectionReminderDate = DateTime.now();
  DateTime contraceptionInjectionReminderTime = DateTime.now();
  String contraceptionInjectionNotes = "Hey gorgeous! It’s time for a new injection 💜";
  bool isContraceptionInjectionSwitchTurnedOn = false;
  bool _enableButton = true;

  void setContraceptionInjectionSwitch(bool value) {
    isContraceptionInjectionSwitchTurnedOn = value;
    setEnableButton(true, notify: false);
    notifyListeners();
  }

  void setContraceptionInjectionDate(DateTime date) {
    contraceptionInjectionReminderDate = date;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setContraceptionInjectionTime(DateTime time) {
    contraceptionInjectionReminderTime = time;
    setEnableButton(true, notify: false);

    notifyListeners();
  }

  void setContraceptionInjectionNotes(String newNote) {
    contraceptionInjectionNotes = newNote;
    setEnableButton(true, notify: false);
    AppNavigation.goBack();

    notifyListeners();
  }

  void setFrequency(String? length) {
    selectedFrequency = length!;
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

  void handleCreateOrUpdateContraceptiveInjection() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? reminderId = await RemindersHelper.getReminderId(RemindersHelper.contraceptiveInjectionString);

    ContraceptionReminderModel data = ContraceptionReminderModel(
        userId: userId,
        contraceptionType: RemindersHelper.contraceptiveInjectionString,
        time: HelperFunctions.formatTime(contraceptionInjectionReminderTime),
        text: contraceptionInjectionNotes,
        date: HelperFunctions.formatDate(contraceptionInjectionReminderDate),
        injectionFrequency: selectedFrequency == "Injection frequency" ? "" : selectedFrequency,
        active: isContraceptionInjectionSwitchTurnedOn);
    if (reminderDataValid(data)) {
      reminderId != null ? handleCreateOrUpdateContraceptionReminder(data: data, create: false, id: reminderId) : handleCreateOrUpdateContraceptionReminder(data: data);
    } else {
      HelperFunctions.showNotification(AppNavigation.currentContext!, "Please complete all required fields");
    }
  }

  void handleGetContraceptiveInjectionReminder() async {
    String? id = await RemindersHelper.getReminderId(RemindersHelper.contraceptiveInjectionString);
    if (id != null) {
      handleGetContraceptionReminder(id).then((data) {
        if (data.id != null) {
          DateTime combinedDateAndTime = HelperFunctions.combineDateTime(data.date!, data.time!);

          contraceptionInjectionReminderTime = combinedDateAndTime;
          contraceptionInjectionReminderDate = combinedDateAndTime;
          contraceptionInjectionNotes = data.text!;
          selectedFrequency = data.injectionFrequency!.isEmpty ? "Injection frequency" : data.injectionFrequency!;
          isContraceptionInjectionSwitchTurnedOn = data.active!;
          setEnableButton(false);

          notifyListeners();
        }
      });
    }
  }
}
