class BleedingTagCount {
  String? userId;
  String? symptomType;
  GraphData? graphData;
  bool isDataLoaded = false;

  BleedingTagCount({this.userId, this.symptomType, this.graphData});

  BleedingTagCount.fromJson(Map<String, dynamic> json) {
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
  List<ColorsJSON>? color;
  List<ConsistencyJSON>? consistency;

  GraphData({this.color, this.consistency});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['color'] != null) {
      color = <ColorsJSON>[];
      json['color'].forEach((v) {
        color!.add(ColorsJSON.fromJson(v));
      });
    }
    if (json['consistency'] != null) {
      consistency = <ConsistencyJSON>[];
      json['consistency'].forEach((v) {
        consistency!.add(ConsistencyJSON.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (color != null) {
      data['color'] = color!.map((v) => v.toJson()).toList();
    }
    if (consistency != null) {
      data['consistency'] = consistency!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorsJSON {
  String? tag;
  int? count;

  ColorsJSON({this.tag, this.count});

  ColorsJSON.fromJson(Map<String, dynamic> json) {
    tag = (json['tag'] as String).replaceAll("_", " ");
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['count'] = count;
    return data;
  }
}

class ConsistencyJSON {
  String? tag;
  int? count;

  ConsistencyJSON({this.tag, this.count});

  ConsistencyJSON.fromJson(Map<String, dynamic> json) {
    tag = (json['tag'] as String).replaceAll("_", " ");
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['count'] = count;
    return data;
  }
}
