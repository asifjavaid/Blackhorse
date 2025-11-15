class InsightsPainReliefInCircleModel {
  final Map<String, List<PainReliefInCircleModel>>? trackingData;
  bool? isDataLoaded;

  InsightsPainReliefInCircleModel({this.trackingData, this.isDataLoaded});

  factory InsightsPainReliefInCircleModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<PainReliefInCircleModel>> trackingData = {};
    json['trackingData'].forEach((key, value) {
      trackingData[key] = (value as List).map((item) => PainReliefInCircleModel.fromJson(item)).toList();
    });
    return InsightsPainReliefInCircleModel(trackingData: trackingData, isDataLoaded: true);
  }
}

class PainReliefInCircleModel {
  final String date;
  final bool hasMovement;

  PainReliefInCircleModel({required this.date, required this.hasMovement});

  factory PainReliefInCircleModel.fromJson(Map<String, dynamic> json) {
    return PainReliefInCircleModel(
      date: json['date'],
      hasMovement: json['hasMovement'] ?? json['hasSelfCare'] ?? false,
    );
  }
}
