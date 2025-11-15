import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';

class HeadacheResponseModel {
  String? id;
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? feltLike;
  List<String>? location;
  List<String>? type;
  String? onset;
  int? durationInMinutes;
  List<PartOfLifeEffect>? partOfLifeEffect;
  String? note;
  String? createdAt;
  String? updatedAt;

  HeadacheResponseModel({
    this.id,
    this.userId,
    this.date,
    this.timeOfDay,
    this.intensityScale,
    this.feltLike,
    this.location,
    this.type,
    this.onset,
    this.durationInMinutes,
    this.partOfLifeEffect,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  HeadacheResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    intensityScale = json['intensityScale'];
    feltLike = json['feltLike']?.cast<String>();
    location = json['location']?.cast<String>();
    type = json['type']?.cast<String>();
    onset = json['onset'];
    durationInMinutes = json['durationInMinutes'];
    if (json['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffect>[];
      json['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffect.fromJson(v));
      });
    }
    note = json['note'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['intensityScale'] = intensityScale;
    data['feltLike'] = feltLike;
    data['location'] = location;
    data['type'] = type;
    data['onset'] = onset;
    data['durationInMinutes'] = durationInMinutes;
    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] =
          partOfLifeEffect!.map((v) => v.toJson()).toList();
    }
    data['note'] = note;
    return data;
  }
}

class HeadacheRequestModel {
  String? id;
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? feltLike;
  List<String>? location;
  List<String>? type;
  String? onset;
  int? durationInMinutes;
  List<PartOfLifeEffect>? partOfLifeEffect;
  String? note;

  HeadacheRequestModel({
    this.id,
    this.userId,
    this.date,
    this.timeOfDay,
    this.intensityScale,
    this.feltLike,
    this.location,
    this.type,
    this.onset,
    this.durationInMinutes,
    this.partOfLifeEffect,
    this.note,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    if (intensityScale != null) data['intensityScale'] = intensityScale;
    if (feltLike != null) data['feltLike'] = feltLike;
    if (location != null) data['location'] = location;
    if (type != null) data['type'] = type;
    data['onset'] = onset;
    if (durationInMinutes != null) {
      data['durationInMinutes'] = durationInMinutes;
    }
    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] =
          partOfLifeEffect!.map((v) => v.toJson()).toList();
    }
    if (note != null) data['note'] = note;
    return data;
  }
}

class HeadacheUpsertResponse {
  String? status;
  String? message;
  HeadacheUpsertData? data;

  HeadacheUpsertResponse({this.status, this.message, this.data});

  HeadacheUpsertResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? HeadacheUpsertData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HeadacheUpsertData {
  String? id;
  String? createdAt;
  String? updatedAt;

  HeadacheUpsertData({this.id, this.createdAt, this.updatedAt});

  HeadacheUpsertData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
