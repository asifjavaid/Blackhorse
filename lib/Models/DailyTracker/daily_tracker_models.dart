// ignore_for_file: prefer_collection_literals

import 'package:ekvi/Utils/helpers/time_helper.dart';

class DailyTrackerAnswers {
  String? date;
  String? userId;
  String? timeOfDay;
  String? id;
  List<String>? answer;
  String? type;
  int? pads;
  List<String>? color;
  List<String>? consistency;

  DailyTrackerAnswers({this.date, this.userId, this.id, this.answer, this.type, this.timeOfDay});

  DailyTrackerAnswers.from(Map<String, dynamic> data) {
    date = data['date'];
    userId = data['userId'];
    id = data['id'];
    answer = data['answer']?.cast<String>() ?? [];
    type = data['type'];
    timeOfDay = data['timeOfDay'];
    pads = data['pads'];
    color = (data['color']?.cast<String>()) ?? [];
    consistency = (data['consistency']?.cast<String>()) ?? [];
  }

  Future<Map<String, dynamic>> to() async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['answer'] = answer;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['timezone'] = await TimeHelper.getCurrentTimezone();
    if (pads != null) {
      data['pads'] = pads;
    }
    if (userId != null) {
      data['userId'] = userId;
    }
    data["color"] = color ?? [];
    data["consistency"] = consistency ?? [];

    return data;
  }
}

class DailyTrackerEvent {
  List<String>? name;
  String? userId;
  String? date;
  String? timeOfDay;
  String? activity;
  String? travelMode;
  List<ExerciseType>? exerciseType;
  List<String>? feeling;
  List<String>? experience;
  List<String>? intimacyActivity;
  int? intensityScale;
  List<PartOfLifeEffect>? partOfLifeEffect;
  String? timezone;
  List<String>? intimacyType;
  List<String>? intimacyTool;
  List<String>? intimacyOrgasm;
  DailyTrackerEvent({
    this.name,
    this.userId,
    this.date,
    this.timeOfDay,
    this.activity,
    this.travelMode,
    this.exerciseType,
    this.feeling,
    this.experience,
    this.intimacyActivity,
    this.intensityScale,
    this.partOfLifeEffect,
    this.timezone,
    this.intimacyType,
    this.intimacyTool,
    this.intimacyOrgasm,
  });

  DailyTrackerEvent.fromJson(Map<String, dynamic> json) {
    name = json['name'].cast<String>();
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    activity = json['activity'];
    travelMode = json['travelMode'];
    if (json['exerciseType'] != null) {
      exerciseType = <ExerciseType>[];
      json['exerciseType'].forEach((v) {
        exerciseType!.add(ExerciseType.fromJson(v));
      });
    }
    feeling = json['feeling'].cast<String>();
    experience = json['experience'].cast<String>();
    intimacyActivity = json['intimacyActivity']?.cast<String>();
    intensityScale = json['intensityScale'];
    if (json['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffect>[];
      json['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffect.fromJson(v));
      });
    }
    timezone = json['timezone'];
    intimacyType = json['intimacyType'].cast<String>();
    intimacyTool = json['intimacyTool'].cast<String>();
    intimacyOrgasm = json['intimacyOrgasm'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['activity'] = activity;
    data['feeling'] = feeling;
    data['intensityScale'] = intensityScale;
    if (travelMode != null) {
      data['travelMode'] = travelMode;
    }

    if (exerciseType != null) {
      data['exerciseType'] = exerciseType!.map((v) => v.toJson()).toList();
    }

    if (experience != null) {
      data['experience'] = experience;
    }
    if (intimacyActivity != null) {
      data['intimacyActivity'] = intimacyActivity;
    }
    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] = partOfLifeEffect!.map((v) => v.toJson()).toList();
    }
    data['timezone'] = timezone;

    if (intimacyType != null) {
      data['intimacyType'] = intimacyType;
    }
    if (intimacyTool != null) {
      data['intimacyTool'] = intimacyTool;
    }
    if (intimacyOrgasm != null) {
      data['intimacyOrgasm'] = intimacyOrgasm;
    }

    return data;
  }
}

class ExerciseType {
  String? name;
  List<String>? types;

  ExerciseType({this.name, this.types});

  ExerciseType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['types'] = types;
    return data;
  }
}

class PartOfLifeEffect {
  String? type;
  String? impactLevel;

  PartOfLifeEffect({this.type, this.impactLevel});

  PartOfLifeEffect.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    impactLevel = json['impactLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['impactLevel'] = impactLevel;
    return data;
  }
}

class SelectedDateOfUserForTracking {
  String date;
  SelectedDateOfUserForTracking({required this.date});
}

class SymptomFeedback {
  bool? isFeedbackSaved;
  String? question;
  String? symptom;
  String? header;
  String? userId;
  int? impressionCount;
  String? text;
  String? id;
  bool? answer;

  SymptomFeedback({this.isFeedbackSaved, this.question, this.symptom, this.header, this.userId, this.impressionCount, this.text, this.id, this.answer});

  SymptomFeedback.fromJson(Map<String, dynamic> json) {
    isFeedbackSaved = json['isFeedbackSaved'];
    question = json['question'];
    symptom = json['symptom'];
    header = json['header'];
    userId = json['userId'];
    impressionCount = json['impressionCount'];
    text = json['text'];
    id = json['id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isFeedbackSaved'] = isFeedbackSaved;
    data['question'] = question;
    data['symptom'] = symptom;
    data['header'] = header;
    data['userId'] = userId;
    data['impressionCount'] = impressionCount;
    data['text'] = text;
    data['id'] = id;
    data['answer'] = answer;
    return data;
  }
}
