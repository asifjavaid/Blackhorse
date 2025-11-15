class PainkillersTagsCount {
  String? userId;
  List<TimeFrame>? timeFrame;
  String? activeIngredient;
  List<PainkillersData>? painkillersData;
  bool isDataLoaded = false;

  PainkillersTagsCount({this.userId, this.timeFrame, this.activeIngredient, this.painkillersData, required this.isDataLoaded});

  PainkillersTagsCount.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['timeFrame'] != null) {
      timeFrame = <TimeFrame>[];
      json['timeFrame'].forEach((v) {
        timeFrame!.add(TimeFrame.fromJson(v));
      });
    }
    activeIngredient = json['activeIngredient'];
    if (json['painkillersData'] != null) {
      painkillersData = <PainkillersData>[];
      json['painkillersData'].forEach((v) {
        painkillersData!.add(PainkillersData.fromJson(v));
      });
    }
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (timeFrame != null) {
      data['timeFrame'] = timeFrame!.map((v) => v.toJson()).toList();
    }
    data['activeIngredient'] = activeIngredient;
    if (painkillersData != null) {
      data['painkillersData'] = painkillersData!.map((v) => v.toJson()).toList();
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

class PainkillersData {
  String? painkillerName;
  int? usageCount;

  PainkillersData({this.painkillerName, this.usageCount});

  PainkillersData.fromJson(Map<String, dynamic> json) {
    painkillerName = json['painkillerName'];
    usageCount = json['usageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['painkillerName'] = painkillerName;
    data['usageCount'] = usageCount;
    return data;
  }
}
