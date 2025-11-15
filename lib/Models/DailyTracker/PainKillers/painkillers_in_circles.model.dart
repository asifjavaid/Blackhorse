class PainkillerInCirclesModel {
  final Map<String, List<PainkillerEntry>>? trackingData;

  PainkillerInCirclesModel({this.trackingData});

  factory PainkillerInCirclesModel.fromJson(Map<String, dynamic> json) {
    return PainkillerInCirclesModel(
      trackingData: (json['trackingData'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((e) => PainkillerEntry.fromJson(e)).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackingData': trackingData?.map(
        (key, value) => MapEntry(
          key,
          value.map((e) => e.toJson()).toList(),
        ),
      ),
    };
  }
}

class PainkillerEntry {
  final String date;
  final bool hasPainkiller;
  final int units;
  final List<String> ingredient;

  PainkillerEntry({
    required this.date,
    required this.hasPainkiller,
    required this.units,
    required this.ingredient,
  });

  factory PainkillerEntry.fromJson(Map<String, dynamic> json) {
    return PainkillerEntry(
      date: json['date'],
      hasPainkiller: json['hasPainkiller'],
      units: json['units'],
      ingredient: List<String>.from(json['ingredient']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'hasPainkiller': hasPainkiller,
      'units': units,
      'ingredient': ingredient,
    };
  }
}
