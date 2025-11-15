class PeriodReminderModel {
  bool? active;
  String? userId;
  String? message;
  String? time;
  String? id;
  String? periodStartDate;

  PeriodReminderModel({this.active, this.userId, this.message, this.time, this.id, this.periodStartDate});

  PeriodReminderModel.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    userId = json['userId'];
    message = json['message'];
    time = json['time'];
    id = json['id'];
    periodStartDate = json['periodStartDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active ?? true;
    data['userId'] = userId;
    data['message'] = message;
    data['time'] = time;
    return data;
  }
}
