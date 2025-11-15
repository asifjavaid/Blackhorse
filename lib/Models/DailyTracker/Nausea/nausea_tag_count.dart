class NauseaTagList {
  String? userId;
  String? symptomType;
  GraphData? graphData;
  bool isDataLoaded = false;

  NauseaTagList({this.userId, this.symptomType, this.graphData});

  NauseaTagList.fromJson(Map<String, dynamic> json) {
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
  List<AnswersJSON>? answers;
  List<DurationJSON>? duration;

  GraphData({this.answers, this.duration});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <AnswersJSON>[];
      json['answers'].forEach((v) {
        answers!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['duration'] != null) {
      duration = <DurationJSON>[];
      json['duration'].forEach((v) {
        duration!.add(DurationJSON.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    if (duration != null) {
      data['duration'] = duration!.map((v) => v.toJson()).toList();
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
