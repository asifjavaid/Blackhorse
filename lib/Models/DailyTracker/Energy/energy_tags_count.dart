class EnergyTagCount {
  String? tag;
  int? count;

  EnergyTagCount({this.tag, this.count});

  EnergyTagCount.fromJson(Map<String, dynamic> json) {
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

class EnergyTagList {
  List<EnergyTagCount>? energyTags;
  bool isDataLoaded = false;

  EnergyTagList({this.energyTags});

  EnergyTagList.fromJson(Map<String, dynamic> json) {
    if (json['graphData'] != null) {
      energyTags = <EnergyTagCount>[];
      json['graphData'].forEach((v) {
        energyTags!.add(EnergyTagCount.fromJson(v));
      });
    }
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (energyTags != null) {
      data['graphData'] = energyTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
