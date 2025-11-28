import '../BodyPain/body_pain_model.dart';

class UrinaitonTagList {
  String? userId;
  String? symptomType;
  GraphData? graphData;
  bool isDataLoaded = false;

  UrinaitonTagList({this.userId, this.symptomType, this.graphData});

  UrinaitonTagList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    symptomType = json['symptomType'];
    graphData = json['graphData'] != null ? GraphData.fromJson(json['graphData']) : null;
    isDataLoaded = true;
  }
}

class TimeFrame {
  String? year;
  List<String>? months;

  TimeFrame({this.year, this.months});

  TimeFrame.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    months = json['months'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['months'] = months;
    return data;
  }
}

class GraphData {
  List<AnswersJSON>? sensation;
  List<AnswersJSON>? diagnosis;
  List<AnswersJSON>? complication;
  List<AnswersJSON>? smell;
  List<AnswersJSON>? color;
  List<AnswersJSON>? volume;
  List<PartOfLifeEffect>? partOfLifeEffect;

  GraphData({
    this.sensation,
    this.diagnosis,
    this.complication,
    this.smell,
    this.color,
    this.volume,
    this.partOfLifeEffect
  });

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['sensation'] != null) {
      sensation = <AnswersJSON>[];
      json['sensation'].forEach((v) {
        sensation!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['complication'] != null) {
      complication = <AnswersJSON>[];
      json['complication'].forEach((v) {
        complication!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['diagnosis'] != null) {
      diagnosis = <AnswersJSON>[];
      json['diagnosis'].forEach((v) {
        diagnosis!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['smell'] != null) {
      smell = <AnswersJSON>[];
      json['smell'].forEach((v) {
        smell!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['color'] != null) {
      color = <AnswersJSON>[];
      json['color'].forEach((v) {
        color!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['volume'] != null) {
      volume = <AnswersJSON>[];
      json['volume'].forEach((v) {
        volume!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffect>[];
      json['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffect.fromJson(v));
      });
    }
  }

}

class AnswersJSON {
  String? tag;
  int? count;

  AnswersJSON({this.tag, this.count});

  AnswersJSON.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['count'] = count;
    return data;
  }
}

class DurationJSON {
  String? tag;
  int? count;

  DurationJSON({this.tag, this.count});

  DurationJSON.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['count'] = count;
    return data;
  }
}
