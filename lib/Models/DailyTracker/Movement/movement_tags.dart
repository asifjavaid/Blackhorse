class MovementTagsCount {
  String? userId;
  String? symptomType;
  List<TimeFrame>? timeFrame;
  List<GraphData>? graphData;
  bool isDataLoaded = false;

  MovementTagsCount({
    this.userId,
    this.symptomType,
    this.timeFrame,
    this.graphData,
    required this.isDataLoaded,
  });

  MovementTagsCount.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    symptomType = json['symptomType'];

    if (json['timeFrame'] != null) {
      timeFrame = <TimeFrame>[];
      json['timeFrame'].forEach((v) {
        timeFrame!.add(TimeFrame.fromJson(v));
      });
    }

    if (json['graphData'] != null) {
      graphData = <GraphData>[];
      json['graphData'].forEach((v) {
        graphData!.add(GraphData.fromJson(v));
      });
    }

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
      data['graphData'] = graphData!.map((v) => v.toJson()).toList();
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
    months = List<String>.from(json['months']);
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'months': months,
    };
  }
}

class GraphData {
  List<PracticesData>? practicesData;
  List<TypeData>? typeData;

  GraphData({this.practicesData, this.typeData});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['practicesData'] != null) {
      practicesData = <PracticesData>[];
      json['practicesData'].forEach((v) {
        practicesData!.add(PracticesData.fromJson(v));
      });
    }
    if (json['typeData'] != null) {
      typeData = <TypeData>[];
      json['typeData'].forEach((v) {
        typeData!.add(TypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (practicesData != null) {
      data['practicesData'] = practicesData!.map((v) => v.toJson()).toList();
    }
    if (typeData != null) {
      data['typeData'] = typeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PracticesData {
  String? practiceName;
  String? emoji;
  int? count;

  PracticesData({this.practiceName, this.emoji, this.count});

  PracticesData.fromJson(Map<String, dynamic> json) {
    practiceName = json['practiceName'];
    emoji = json['emoji'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {
      'practiceName': practiceName,
      'emoji': emoji,
      'count': count,
    };
  }
}

class TypeData {
  String? typeName;
  int? count;

  TypeData({this.typeName, this.count});

  TypeData.fromJson(Map<String, dynamic> json) {
    typeName = json['typeName'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {
      'typeName': typeName,
      'count': count,
    };
  }
}
