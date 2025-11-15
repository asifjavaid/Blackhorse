class GetAllSavedLessons {
  String? lessonId;
  String? moduleId;
  String? title;
  String? lessonType;
  String? lessonDuration;
  String? featuredImageUrl;
  String? savedAt;

  GetAllSavedLessons({this.lessonId, this.moduleId, this.title, this.lessonType, this.lessonDuration, this.featuredImageUrl, this.savedAt});

  GetAllSavedLessons.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    moduleId = json['moduleId'];
    title = json['title'];
    lessonType = json['lessonType'];
    lessonDuration = json['lessonDuration'];
    featuredImageUrl = json['featuredImageUrl'];
    savedAt = json['savedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lessonId'] = lessonId;
    data['moduleId'] = moduleId;
    data['title'] = title;
    data['lessonType'] = lessonType;
    data['lessonDuration'] = lessonDuration;
    data['featuredImageUrl'] = featuredImageUrl;
    data['savedAt'] = savedAt;
    return data;
  }
}
