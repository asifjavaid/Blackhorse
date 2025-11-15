class StoreFCMTokenModel {
  String? userId;
  String? deviceType;
  String? notificationToken;

  StoreFCMTokenModel({this.userId, this.deviceType, this.notificationToken});

  StoreFCMTokenModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    deviceType = json['deviceType'];
    notificationToken = json['notificationToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['deviceType'] = deviceType;
    data['notificationToken'] = notificationToken;
    return data;
  }
}
