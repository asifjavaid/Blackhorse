// pain_relief_response_model.dart
class PainReliefResponseModel {
  String? userId;
  String? timeOfDay;
  String? date;
  int? enjoymentScale;
  List<PainPractice>? practices;
  String? note;
  String? createdAt;
  String? updatedAt;

  PainReliefResponseModel({this.userId, this.timeOfDay, this.date, this.enjoymentScale, this.practices, this.note, this.createdAt, this.updatedAt});

  factory PainReliefResponseModel.fromJson(Map<String, dynamic> json) {
    return PainReliefResponseModel(
      userId: json['userId'],
      timeOfDay: json['timeOfDay'],
      enjoymentScale: json['enjoymentScale'],
      practices: (json['practices'] as List?)?.map((v) => PainPractice.fromJson(v)).toList(),
      date: json['date'],
      note: json['note'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'timeOfDay': timeOfDay,
      'date': date,
      'enjoymentScale': enjoymentScale,
      'practices': practices?.map((v) => v.id).toList(),
      'note': note,
    };
  }
}

class PainPractice {
  String? id;
  String? name;
  String? type;

  PainPractice({this.id, this.name, this.type});

  factory PainPractice.fromJson(Map<String, dynamic> json) {
    return PainPractice(
      id: json['id'],
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        if (name != null) 'name': name,
        if (type != null) 'type': type,
      };
}
