class MedicineReminderRequest {
  String? userId;
  String? medicineName;
  String? medicineDose;
  String? numOfPill;
  bool? isDailyReminderOn;
  String? medicineDailyReminderTime;
  String? medicineDailyReminderDate;
  String? id;
  bool? active;

  MedicineReminderRequest({
    this.userId,
    this.medicineName,
    this.medicineDose,
    this.numOfPill,
    this.isDailyReminderOn,
    this.medicineDailyReminderTime,
    this.medicineDailyReminderDate,
    this.id,
    this.active,
  });

  MedicineReminderRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    medicineName = json['medicineName'];
    medicineDose = json['medicineDose'];
    numOfPill = json['numOfPill'];
    isDailyReminderOn = json['isDailyReminderOn'];
    medicineDailyReminderTime = json['medicineDailyReminderTime'];
    medicineDailyReminderDate = json['medicineDailyReminderDate'];
    id = json['id'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['medicineName'] = medicineName;
    data['medicineDose'] = medicineDose;
    data['numOfPill'] = numOfPill;
    data['isDailyReminderOn'] = isDailyReminderOn;
    data['medicineDailyReminderTime'] = medicineDailyReminderTime;
    data['medicineDailyReminderDate'] = medicineDailyReminderDate;
    data['active'] = active ?? true;
    return data;
  }
}
