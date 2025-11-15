class FeatureAlertModel {
  bool? isFeatureAlertAvailable;

  FeatureAlertModel({this.isFeatureAlertAvailable});

  FeatureAlertModel.fromJson(Map<String, dynamic> json) {
    isFeatureAlertAvailable = json['isFeatureAlertAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFeatureAlertAvailable'] = isFeatureAlertAvailable;
    return data;
  }
}
