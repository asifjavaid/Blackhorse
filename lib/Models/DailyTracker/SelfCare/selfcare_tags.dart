class SelfCareTagsCount {
  String? userId;
  String? symptomType;
  List<TimeFrame>? timeFrame;
  List<GraphData>? graphData;
  bool isDataLoaded = false;

  SelfCareTagsCount({
    this.userId,
    this.symptomType,
    this.timeFrame,
    this.graphData,
    required this.isDataLoaded,
  });

  SelfCareTagsCount.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    symptomType = json['symptomType'];

    if (json['timeFrame'] != null) {
      timeFrame = (json['timeFrame'] as List).map((v) => TimeFrame.fromJson(v)).toList();
    }

    if (json['graphData'] != null) {
      graphData = (json['graphData'] as List).map((v) => GraphData.fromJson(v)).toList();
    }

    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'symptomType': symptomType,
      if (timeFrame != null) 'timeFrame': timeFrame!.map((v) => v.toJson()).toList(),
      if (graphData != null) 'graphData': graphData!.map((v) => v.toJson()).toList(),
    };
  }
}

class TimeFrame {
  String? year;
  List<String>? months;

  TimeFrame({this.year, this.months});

  TimeFrame.fromJson(Map<String, dynamic> json)
      : year = json['year'],
        months = List<String>.from(json['months'] ?? []);

  Map<String, dynamic> toJson() => {
        'year': year,
        'months': months,
      };
}

class GraphData {
  List<PracticesData>? practicesData;
  List<TypeData>? typeData;

  GraphData({this.practicesData, this.typeData});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['practicesData'] != null) {
      practicesData = (json['practicesData'] as List).map((v) => PracticesData.fromJson(v)).toList();
    }
    if (json['typeData'] != null) {
      typeData = (json['typeData'] as List).map((v) => TypeData.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() => {
        if (practicesData != null) 'practicesData': practicesData!.map((v) => v.toJson()).toList(),
        if (typeData != null) 'typeData': typeData!.map((v) => v.toJson()).toList(),
      };
}

class PracticesData {
  String? practiceName;
  String? emoji;
  int? count;
  double? averageEnjoyment;

  PracticesData({
    this.practiceName,
    this.emoji,
    this.count,
    this.averageEnjoyment,
  });

  PracticesData.fromJson(Map<String, dynamic> json)
      : practiceName = json['practiceName'],
        emoji = json['emoji'],
        count = json['count'],
        averageEnjoyment = (json['averageEnjoyment'] as num?)?.toDouble();

  Map<String, dynamic> toJson() => {
        'practiceName': practiceName,
        'emoji': emoji,
        'count': count,
        'averageEnjoyment': averageEnjoyment,
      };
}

class TypeData {
  String? typeName;
  int? count;

  TypeData({this.typeName, this.count});

  TypeData.fromJson(Map<String, dynamic> json)
      : typeName = json['typeName'],
        count = json['count'];

  Map<String, dynamic> toJson() => {
        'typeName': typeName,
        'count': count,
      };
}
