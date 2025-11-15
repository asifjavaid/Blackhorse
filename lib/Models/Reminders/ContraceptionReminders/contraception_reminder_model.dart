class ContraceptionReminderModel {
  String? userId;
  String? contraceptionType;
  String? time;
  String? text;
  String? numOfPill;
  String? date;
  String? injectionFrequency;
  String? periodOfUse;
  String? stringCheckFrequency;
  String? iudType;
  bool? active;
  String? id;

  ContraceptionReminderModel({
    this.userId,
    this.contraceptionType,
    this.time,
    this.text,
    this.numOfPill,
    this.date,
    this.injectionFrequency,
    this.periodOfUse,
    this.stringCheckFrequency,
    this.iudType,
    this.active,
    this.id,
  });

  ContraceptionReminderModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    contraceptionType = json['contraceptionType'];
    time = json['time'];
    text = json['text'];
    numOfPill = json['numOfPill'];
    date = json['date'];
    injectionFrequency = json['injectionFrequency'];
    periodOfUse = json['periodOfUse'];
    stringCheckFrequency = json['stringCheckFrequency'];
    iudType = json['iudType'];
    active = json['active'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['contraceptionType'] = contraceptionType;
    data['time'] = time;
    data['text'] = text ?? "";
    data['numOfPill'] = numOfPill ?? "";
    data['date'] = date;
    data['injectionFrequency'] = injectionFrequency ?? "";
    data['periodOfUse'] = periodOfUse ?? "";
    data['stringCheckFrequency'] = stringCheckFrequency ?? "";
    data['iudType'] = iudType ?? "";
    data['active'] = active ?? true;

    return data;
  }
}
