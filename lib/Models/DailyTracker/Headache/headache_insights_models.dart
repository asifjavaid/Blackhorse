import 'package:ekvi/Models/DailyTracker/BodyPain/body_pain_model.dart';

class HeadacheTagList {
  String? userId;
  String? symptomType;
  List<TimeFrame>? timeFrame;
  HeadacheGraphData? graphData;
  bool isDataLoaded = false;

  HeadacheTagList(
      {this.userId, this.symptomType, this.timeFrame, this.graphData});

  HeadacheTagList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    symptomType = json['symptomType'];
    if (json['timeFrame'] != null) {
      timeFrame = <TimeFrame>[];
      json['timeFrame'].forEach((v) {
        timeFrame!.add(TimeFrame.fromJson(v));
      });
    }
    graphData = json['graphData'] != null
        ? HeadacheGraphData.fromJson(json['graphData'])
        : null;
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['symptomType'] = symptomType;
    if (timeFrame != null) {
      data['timeFrame'] = timeFrame!.map((v) => v.toJson()).toList();
    }
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
    months = json['months']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['months'] = months;
    return data;
  }
}

class HeadacheGraphData {
  List<HeadacheTag>? feltLike;
  List<HeadacheTag>? location;
  List<HeadacheTag>? type;
  List<HeadacheTag>? onset;
  List<PartOfLifeEffect>? partOfLifeEffect;

  HeadacheGraphData({
    this.feltLike,
    this.location,
    this.type,
    this.onset,
    this.partOfLifeEffect
  });

  HeadacheGraphData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> graphDataJson = json;
    if (json['graphData'] != null) {
      graphDataJson = json['graphData'];
    }

    if (graphDataJson['feltLike'] != null) {
      feltLike = <HeadacheTag>[];
      graphDataJson['feltLike'].forEach((v) {
        feltLike!.add(HeadacheTag.fromJson(v));
      });
    }
    if (graphDataJson['location'] != null) {
      location = <HeadacheTag>[];
      graphDataJson['location'].forEach((v) {
        location!.add(HeadacheTag.fromJson(v));
      });
    }
    if (graphDataJson['type'] != null) {
      type = <HeadacheTag>[];
      graphDataJson['type'].forEach((v) {
        type!.add(HeadacheTag.fromJson(v));
      });
    }
    if (graphDataJson['onset'] != null) {
      onset = <HeadacheTag>[];
      graphDataJson['onset'].forEach((v) {
        onset!.add(HeadacheTag.fromJson(v));
      });
    }
    if (graphDataJson['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffect>[];
      graphDataJson['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffect.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feltLike != null) {
      data['feltLike'] = feltLike!.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      data['location'] = location!.map((v) => v.toJson()).toList();
    }
    if (type != null) {
      data['type'] = type!.map((v) => v.toJson()).toList();
    }
    if (onset != null) {
      data['onset'] = onset!.map((v) => v.toJson()).toList();
    }
    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] =
          partOfLifeEffect!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HeadacheTag {
  String? tag;
  int? count;

  HeadacheTag({this.tag, this.count});

  HeadacheTag.fromJson(Map<String, dynamic> json) {
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

class HeadacheImpactSummary {
  String? userId;
  String? symptomType;
  List<TimeFrame>? timeFrame;
  ImpactSummary? summary;
  bool isDataLoaded = false;

  HeadacheImpactSummary(
      {this.userId, this.symptomType, this.timeFrame, this.summary});

  HeadacheImpactSummary.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    symptomType = json['symptomType'];
    if (json['timeFrame'] != null) {
      timeFrame = <TimeFrame>[];
      json['timeFrame'].forEach((v) {
        timeFrame!.add(TimeFrame.fromJson(v));
      });
    }
    summary = json['summary'] != null
        ? ImpactSummary.fromJson(json['summary'])
        : null;
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['symptomType'] = symptomType;
    if (timeFrame != null) {
      data['timeFrame'] = timeFrame!.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    return data;
  }
}

class ImpactSummary {
  ImpactCategory? work;
  ImpactCategory? socialLife;
  ImpactCategory? sleep;
  ImpactCategory? qualityOfLife;

  ImpactSummary({this.work, this.socialLife, this.sleep, this.qualityOfLife});

  ImpactSummary.fromJson(Map<String, dynamic> json) {
    work = json['Work'] != null ? ImpactCategory.fromJson(json['Work']) : null;
    socialLife = json['Social life'] != null
        ? ImpactCategory.fromJson(json['Social life'])
        : null;
    sleep =
        json['Sleep'] != null ? ImpactCategory.fromJson(json['Sleep']) : null;
    qualityOfLife = json['Quality of life'] != null
        ? ImpactCategory.fromJson(json['Quality of life'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (work != null) {
      data['Work'] = work!.toJson();
    }
    if (socialLife != null) {
      data['Social life'] = socialLife!.toJson();
    }
    if (sleep != null) {
      data['Sleep'] = sleep!.toJson();
    }
    if (qualityOfLife != null) {
      data['Quality of life'] = qualityOfLife!.toJson();
    }
    return data;
  }
}

class ImpactCategory {
  int? none;
  int? mild;
  int? moderate;
  int? severe;

  ImpactCategory({this.none, this.mild, this.moderate, this.severe});

  ImpactCategory.fromJson(Map<String, dynamic> json) {
    none = json['None'];
    mild = json['Mild'];
    moderate = json['Moderate'];
    severe = json['Severe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['None'] = none;
    data['Mild'] = mild;
    data['Moderate'] = moderate;
    data['Severe'] = severe;
    return data;
  }
}
