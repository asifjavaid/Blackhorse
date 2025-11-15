class InsightsMovementCircleModel {
  final Map<String, List<MovementCircle>>? trackingData;
  bool? isDataLoaded;

  InsightsMovementCircleModel({this.trackingData, this.isDataLoaded});

  factory InsightsMovementCircleModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<MovementCircle>> trackingData = {};
    json['trackingData'].forEach((key, value) {
      trackingData[key] = (value as List).map((item) => MovementCircle.fromJson(item)).toList();
    });
    return InsightsMovementCircleModel(trackingData: trackingData, isDataLoaded: true);
  }
}

class MovementCircle {
  final String date;
  final bool hasMovement;

  MovementCircle({required this.date, required this.hasMovement});

  factory MovementCircle.fromJson(Map<String, dynamic> json) {
    return MovementCircle(
      date: json['date'],
      hasMovement: json['hasMovement'],
    );
  }
}
