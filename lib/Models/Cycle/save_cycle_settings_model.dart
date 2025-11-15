class SaveCycleTrackingSettingsModel {
  String? userId;
  String? periodStartDate;
  String? cycleLength;
  String? periodLength;
  String? periodRegularity;
  String? id;

  SaveCycleTrackingSettingsModel({
    this.userId,
    this.periodStartDate,
    this.cycleLength,
    this.periodLength,
    this.periodRegularity,
    this.id,
  });

  SaveCycleTrackingSettingsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    periodStartDate = json['periodStartDate'];
    cycleLength = json['cycleLength'];
    periodLength = json['periodLength'];
    periodRegularity = json['periodRegularity'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['periodStartDate'] = periodStartDate;
    data['cycleLength'] = cycleLength;
    data['periodLength'] = periodLength;
    data['periodRegularity'] = periodRegularity;
    return data;
  }
}
