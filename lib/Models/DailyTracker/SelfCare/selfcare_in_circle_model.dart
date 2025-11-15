class InsightsSelfCareInCircleModel {
  final Map<String, List<SelfcareInCircleModel>>? trackingData;
  bool? isDataLoaded;

  InsightsSelfCareInCircleModel({this.trackingData, this.isDataLoaded});

  factory InsightsSelfCareInCircleModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<SelfcareInCircleModel>> trackingData = {};
    json['trackingData'].forEach((key, value) {
      trackingData[key] = (value as List).map((item) => SelfcareInCircleModel.fromJson(item)).toList();
    });
    return InsightsSelfCareInCircleModel(trackingData: trackingData, isDataLoaded: true);
  }
}

class SelfcareInCircleModel {
  final String date;
  final bool hasMovement;

  SelfcareInCircleModel({required this.date, required this.hasMovement});

  factory SelfcareInCircleModel.fromJson(Map<String, dynamic> json) {
    return SelfcareInCircleModel(
      date: json['date'],
      hasMovement: json['hasMovement'] ?? json['hasSelfCare'] ?? false,
    );
  }
}
