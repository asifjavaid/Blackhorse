class InsightsBowelMovementCircleModel {
  final Map<String, List<BowelMovementCircle>>? trackingData;
  bool? isDataLoaded;

  InsightsBowelMovementCircleModel({this.trackingData, this.isDataLoaded});

  factory InsightsBowelMovementCircleModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<BowelMovementCircle>> trackingData = {};
    json['trackingData'].forEach((key, value) {
      trackingData[key] = (value as List).map((item) => BowelMovementCircle.fromJson(item)).toList();
    });
    return InsightsBowelMovementCircleModel(trackingData: trackingData, isDataLoaded: true);
  }
}

class BowelMovementCircle {
  final String date;
  final bool hasBleeding;

  BowelMovementCircle({required this.date, required this.hasBleeding});

  factory BowelMovementCircle.fromJson(Map<String, dynamic> json) {
    return BowelMovementCircle(
      date: json['date'],
      hasBleeding: json['hasBowelMovement'],
    );
  }
}
