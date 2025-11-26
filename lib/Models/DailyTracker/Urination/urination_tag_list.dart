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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['symptomType'] = symptomType;

    if (graphData != null) {
      data['graphData'] = graphData!.toJson();
    }
    return data;
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
  List<DurationJSON>? stoolDuration;

  GraphData({
    this.sensation,
    this.diagnosis,
    this.complication,
    this.smell,
    this.color,
    this.volume,
    this.stoolDuration,
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
    if (json['StoolDuration'] != null) {
      stoolDuration = <DurationJSON>[];
      json['StoolDuration'].forEach((v) {
        stoolDuration!.add(DurationJSON.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sensation != null) {
      data['BristolScale'] = sensation!.map((v) => v.toJson()).toList();
    }
    if (diagnosis != null) {
      data['StoolColour'] = diagnosis!.map((v) => v.toJson()).toList();
    }
    if (complication != null) {
      data['StoolSize'] = complication!.map((v) => v.toJson()).toList();
    }
    if (smell != null) {
      data['StoolEffort'] = smell!.map((v) => v.toJson()).toList();
    }
    if (volume != null) {
      data['StoolComponents'] = volume!.map((v) => v.toJson()).toList();
    }
    if (stoolDuration != null) {
      data['StoolDuration'] = stoolDuration!.map((v) => v.toJson()).toList();
    }
    return data;
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
