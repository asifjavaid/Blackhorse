class LessonStructure {
  String? lessonId;
  String? title;
  String? moduleTitle;
  String? lessonType;
  int? lessonOrder;
  String? mediaUrl;
  String? featuredImageUrl;
  String? moduleFeaturedImageUrl;
  dynamic lessonContent;
  dynamic lessonReferences;
  bool? isCompleted;
  bool? isSaved;
  int? playbackSec;
  int? totalLessons;
  int? moduleOrder;
  String? moduleID;
  int? totalModules;

  LessonStructure(
      {this.lessonId,
      this.title,
      this.moduleTitle,
      this.lessonType,
      this.lessonOrder,
      this.mediaUrl,
      this.featuredImageUrl,
      this.moduleFeaturedImageUrl,
      this.lessonContent,
      this.lessonReferences,
      this.isCompleted,
      this.isSaved,
      this.playbackSec,
      this.totalLessons,
      this.moduleOrder,
      this.moduleID,
      this.totalModules});

  LessonStructure.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    title = json['title'];
    moduleTitle = json['moduleTitle'];
    lessonType = json['lessonType'];
    lessonOrder = json['lessonOrder'];
    mediaUrl = json['mediaUrl'];
    featuredImageUrl = json['featuredImageUrl'];
    moduleFeaturedImageUrl = json['moduleFeaturedImageUrl'];
    lessonContent = json['lessonContent'];
    lessonReferences = json['lessonReferences'];
    isCompleted = json['isCompleted'];
    isSaved = json['isSaved'];
    playbackSec = json['playbackSec'];
    totalLessons = json['totalLessons'];
    moduleOrder = json['moduleOrder'];
    moduleID = json['moduleID'];
    totalModules = json['totalModules'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lessonId'] = lessonId;
    data['title'] = title;
    data['moduleTitle'] = moduleTitle;
    data['lessonType'] = lessonType;
    data['lessonOrder'] = lessonOrder;
    data['mediaUrl'] = mediaUrl;
    data['featuredImageUrl'] = featuredImageUrl;
    data['moduleFeaturedImageUrl'] = moduleFeaturedImageUrl;
    data['lessonContent'] = lessonContent;
    data['lessonReferences'] = lessonReferences;
    data['isCompleted'] = isCompleted;
    data['isSaved'] = isSaved;
    data['playbackSec'] = playbackSec;
    data['totalLessons'] = totalLessons;
    data['moduleOrder'] = moduleOrder;
    data['moduleID'] = moduleID;
    data['totalModules'] = totalModules;
    return data;
  }
}
