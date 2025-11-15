class CurrentCourseLesson {
  String? lessonId;
  String? title;
  String? lessonType;
  int? lessonOrder;
  int? moduleOrder;
  String? moduleID;
  int? totalModules;
  int? totalLessons;
  String? featuredImageUrl;
  String? mediaUrl;
  dynamic lessonContent;
  dynamic lessonReferences;
  bool? isCompleted;
  bool? isSaved;
  int? playbackSec;

  CurrentCourseLesson(
      {this.lessonId,
      this.title,
      this.lessonType,
      this.lessonOrder,
      this.moduleOrder,
      this.moduleID,
      this.totalModules,
      this.totalLessons,
      this.featuredImageUrl,
      this.mediaUrl,
      this.lessonContent,
      this.lessonReferences,
      this.isCompleted,
      this.isSaved,
      this.playbackSec});

  CurrentCourseLesson.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    title = json['title'];
    lessonType = json['lessonType'];
    lessonOrder = json['lessonOrder'];
    moduleOrder = json['moduleOrder'];
    moduleID = json['moduleID'];
    totalModules = json['totalModules'];
    totalLessons = json['totalLessons'];
    featuredImageUrl = json['featuredImageUrl'];
    mediaUrl = json['mediaUrl'];
    lessonContent = json['lessonContent'];
    lessonReferences = json['lessonReferences'];
    isCompleted = json['isCompleted'];
    isSaved = json['isSaved'];
    playbackSec = json['playbackSec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lessonId'] = lessonId;
    data['title'] = title;
    data['lessonType'] = lessonType;
    data['lessonOrder'] = lessonOrder;
    data['moduleOrder'] = moduleOrder;
    data['moduleID'] = moduleID;
    data['totalModules'] = totalModules;
    data['totalLessons'] = totalLessons;
    data['featuredImageUrl'] = featuredImageUrl;
    data['mediaUrl'] = mediaUrl;
    data['lessonContent'] = lessonContent;
    data['lessonReferences'] = lessonReferences;
    data['isCompleted'] = isCompleted;
    data['isSaved'] = isSaved;
    data['playbackSec'] = playbackSec;
    return data;
  }
}
