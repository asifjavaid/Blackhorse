class InisghtsBleedingInCircleModel {
  final Map<String, List<BleedingCircle>>? trackingData;
  bool? isDataLoaded;

  InisghtsBleedingInCircleModel({this.trackingData, this.isDataLoaded});

  factory InisghtsBleedingInCircleModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<BleedingCircle>> trackingData = {};
    json['trackingData'].forEach((key, value) {
      trackingData[key] = (value as List).map((item) => BleedingCircle.fromJson(item)).toList();
    });
    return InisghtsBleedingInCircleModel(trackingData: trackingData, isDataLoaded: true);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    trackingData?.forEach((key, value) {
      data[key] = value.map((v) => v.toJson()).toList();
    });
    return {'trackingData': data};
  }
}

class BleedingCircle {
  final String date;
  final bool hasBleeding;

  BleedingCircle({required this.date, required this.hasBleeding});

  factory BleedingCircle.fromJson(Map<String, dynamic> json) {
    return BleedingCircle(
      date: json['date'],
      hasBleeding: json['hasBleeding'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'hasBleeding': hasBleeding,
    };
  }
}
