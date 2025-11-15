class StressTagCount {
  String? tag;
  int? count;

  StressTagCount({this.tag, this.count});

  StressTagCount.fromJson(Map<String, dynamic> json) {
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

class StressTagList {
  List<StressTagCount>? stressTags;
  bool isDataLoaded = false;

  StressTagList({this.stressTags});

  StressTagList.fromJson(Map<String, dynamic> json) {
    if (json['graphData'] != null) {
      stressTags = <StressTagCount>[];
      json['graphData'].forEach((v) {
        stressTags!.add(StressTagCount.fromJson(v));
      });
    }
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stressTags != null) {
      data['graphData'] = stressTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
