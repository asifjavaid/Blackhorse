class CycleHistoryModel {
  String? userId;
  String? ovulationStartDay;
  String? timestamp;
  String? periodLength;
  String? cycleId;
  String? id;
  String? cycleLength;
  String? periodRegularity;
  String? periodStartDate;

  CycleHistoryModel({this.userId, this.ovulationStartDay, this.timestamp, this.periodLength, this.cycleId, this.id, this.cycleLength, this.periodRegularity, this.periodStartDate});

  CycleHistoryModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    ovulationStartDay = json['ovulationStartDay'];
    timestamp = json['timestamp'];
    periodLength = json['periodLength'];
    cycleId = json['cycleId'];
    id = json['id'];
    cycleLength = json['cycleLength'];
    periodRegularity = json['periodRegularity'];
    periodStartDate = json['periodStartDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['periodLength'] = periodLength;
    data['cycleId'] = cycleId;
    data['cycleLength'] = cycleLength;
    data['periodRegularity'] = periodRegularity;
    data['periodStartDate'] = periodStartDate;
    return data;
  }
}
