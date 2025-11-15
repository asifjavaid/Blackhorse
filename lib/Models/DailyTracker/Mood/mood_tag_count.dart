class MoodTagCount {
  String? tag;
  int? count;

  MoodTagCount({this.tag, this.count});

  MoodTagCount.fromJson(Map<String, dynamic> json) {
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

class MoodTagList {
  List<MoodTagCount>? moodTags;
  bool isDataLoaded = false;

  MoodTagList({this.moodTags});

  MoodTagList.fromJson(Map<String, dynamic> json) {
    if (json['graphData'] != null) {
      moodTags = <MoodTagCount>[];
      json['graphData'].forEach((v) {
        moodTags!.add(MoodTagCount.fromJson(v));
      });
    }
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (moodTags != null) {
      data['graphData'] = moodTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
