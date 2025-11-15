import 'package:ekvi/Models/Reminders/MedicationReminder/Request/medicine_reminder_request.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/Reminders/reminders_service.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';

class MedicationReminderProvider extends RemindersProvider {
  final List<String> medicationOptions = ["Select medicine", "Ibuprofen", "Paracetamol", "Other"];
  var selectedMedication = "Select medicine";
  final List<String> numberOfPillsOptions = ["Number of pills", "1", "2", "3", "4"];
  var selectedNumberOfPills = "Number of pills";
  final List<String> dosageOptions = ["Dosage", "50mg", "100mg", "200mg"];
  var selectedDosage = "Dosage";
  DateTime selectedTime = DateTime.now();
  bool isDailyReminderOn = false;
  String notes = "Hey gorgeous! It’s time to take your medicine 💜";

  void setNotes(String newNote) {
    notes = newNote;
    AppNavigation.goBack();

    notifyListeners();
  }

  void setSelectedTime(DateTime time) {
    selectedTime = time;
    notifyListeners();
  }

  void setSelectedMedicine(String newMedicine) {
    selectedMedication = newMedicine;
    notifyListeners();
  }

  void setNumberOfPills(String num) {
    selectedNumberOfPills = num;
    notifyListeners();
  }

  void setDosage(String dosage) {
    selectedDosage = dosage;
    notifyListeners();
  }

  void setIsDailyReminderOn(bool newStatus) {
    isDailyReminderOn = newStatus;
    notifyListeners();
  }

  bool reminderDataValid(MedicineReminderRequest data) {
    return data.userId != null && data.medicineName != "Select medicine" && data.numOfPill != "Number of pills" && data.medicineDose != "Dosage" && data.medicineDailyReminderTime!.isNotEmpty;
  }

  void handleCreateOrUpdateMedication({bool? update, String? id}) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    MedicineReminderRequest data = MedicineReminderRequest(
        userId: userId,
        medicineName: selectedMedication,
        numOfPill: selectedNumberOfPills,
        medicineDose: selectedDosage,
        medicineDailyReminderTime: HelperFunctions.formatTime(selectedTime),
        medicineDailyReminderDate: HelperFunctions.formatDate(selectedTime),
        isDailyReminderOn: isDailyReminderOn,
        active: true);
    if (reminderDataValid(data)) {
      (update != null && update) ? handleCreateOrUpdateMedicationReminder(data: data, create: false, id: id!) : handleCreateOrUpdateMedicationReminder(data: data);
    } else {
      HelperFunctions.showNotification(AppNavigation.currentContext!, "Please complete all required fields");
    }
  }

  Future<void> getMedicationReminder(String id) async {
    CustomLoading.showLoadingIndicator();

    final result = await RemindersService.getMedicationReminder(id);

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l);
        CustomLoading.hideLoadingIndicator();
      },
      (r) {
        CustomLoading.hideLoadingIndicator();
        if (r.id != null) {
          selectedMedication = r.medicineName!;
          selectedNumberOfPills = r.numOfPill!;
          selectedDosage = r.medicineDose!;
          selectedTime = HelperFunctions.combineDateTime(r.medicineDailyReminderDate!, r.medicineDailyReminderTime!);
          isDailyReminderOn = r.isDailyReminderOn!;
          notifyListeners();
        }
      },
    );
  }
}
