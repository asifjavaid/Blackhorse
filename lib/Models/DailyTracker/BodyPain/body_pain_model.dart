class BodyPainTags {
  String? userId;
  String? symptomType;
  List<TimeFrame>? timeFrame;
  GraphData? graphData;
  bool isDataLoaded = false;

  BodyPainTags({this.userId, this.symptomType, this.timeFrame, this.graphData});

  BodyPainTags.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    symptomType = json['symptomType'];
    if (json['timeFrame'] != null) {
      timeFrame = <TimeFrame>[];
      json['timeFrame'].forEach((v) {
        timeFrame!.add(TimeFrame.fromJson(v));
      });
    }
    graphData = json['graphData'] != null ? GraphData.fromJson(json['graphData']) : null;
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    months = json['months'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['year'] = year;
    data['months'] = months;
    return data;
  }
}

class GraphData {
  List<Activities>? activities;
  List<PainFeltLike>? painFeltLike;
  List<PartOfLifeEffect>? partOfLifeEffect;

  GraphData({this.activities, this.painFeltLike, this.partOfLifeEffect});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(Activities.fromJson(v));
      });
    }
    if (json['painFeltLike'] != null) {
      painFeltLike = <PainFeltLike>[];
      json['painFeltLike'].forEach((v) {
        painFeltLike!.add(PainFeltLike.fromJson(v));
      });
    }
    if (json['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffect>[];
      json['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffect.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    if (painFeltLike != null) {
      data['painFeltLike'] = painFeltLike!.map((v) => v.toJson()).toList();
    }
    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] = partOfLifeEffect!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  String? tag;
  int? count;

  Activities({this.tag, this.count});

  Activities.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tag'] = tag;
    data['count'] = count;
    return data;
  }
}

class PainFeltLike {
  String? tag;
  int? count;

  PainFeltLike({this.tag, this.count});

  PainFeltLike.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tag'] = tag;
    data['count'] = count;
    return data;
  }
}

class PartOfLifeEffect {
  String? type;
  int? none;
  int? mild;
  int? mod;
  int? severe;

  PartOfLifeEffect({this.type, this.none, this.mild, this.mod, this.severe});

  PartOfLifeEffect.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    none = json['None'];
    mild = json['Mild'];
    mod = json['Mod'];
    severe = json['Severe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['None'] = none;
    data['Mild'] = mild;
    data['Mod'] = mod;
    data['Severe'] = severe;
    return data;
  }
}
