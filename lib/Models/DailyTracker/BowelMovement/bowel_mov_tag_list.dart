class BowelMovTagList {
  String? userId;
  String? symptomType;
  GraphData? graphData;
  bool isDataLoaded = false;

  BowelMovTagList({this.userId, this.symptomType, this.graphData});

  BowelMovTagList.fromJson(Map<String, dynamic> json) {
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
  List<AnswersJSON>? bristolScale;
  List<AnswersJSON>? stoolColour;
  List<AnswersJSON>? stoolSize;
  List<AnswersJSON>? stoolEffort;
  List<AnswersJSON>? stoolComponents;
  List<DurationJSON>? stoolDuration;

  GraphData({
    this.bristolScale,
    this.stoolColour,
    this.stoolSize,
    this.stoolEffort,
    this.stoolComponents,
    this.stoolDuration,
  });

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['BristolScale'] != null) {
      bristolScale = <AnswersJSON>[];
      json['BristolScale'].forEach((v) {
        bristolScale!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['StoolColour'] != null) {
      stoolColour = <AnswersJSON>[];
      json['StoolColour'].forEach((v) {
        stoolColour!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['StoolSize'] != null) {
      stoolSize = <AnswersJSON>[];
      json['StoolSize'].forEach((v) {
        stoolSize!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['StoolEffort'] != null) {
      stoolEffort = <AnswersJSON>[];
      json['StoolEffort'].forEach((v) {
        stoolEffort!.add(AnswersJSON.fromJson(v));
      });
    }
    if (json['StoolComponents'] != null) {
      stoolComponents = <AnswersJSON>[];
      json['StoolComponents'].forEach((v) {
        stoolComponents!.add(AnswersJSON.fromJson(v));
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
    if (bristolScale != null) {
      data['BristolScale'] = bristolScale!.map((v) => v.toJson()).toList();
    }
    if (stoolColour != null) {
      data['StoolColour'] = stoolColour!.map((v) => v.toJson()).toList();
    }
    if (stoolSize != null) {
      data['StoolSize'] = stoolSize!.map((v) => v.toJson()).toList();
    }
    if (stoolEffort != null) {
      data['StoolEffort'] = stoolEffort!.map((v) => v.toJson()).toList();
    }
    if (stoolComponents != null) {
      data['StoolComponents'] = stoolComponents!.map((v) => v.toJson()).toList();
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
