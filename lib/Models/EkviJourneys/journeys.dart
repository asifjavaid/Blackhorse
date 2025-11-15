class Journeys {
  String? courseId;
  String? title;
  String? imageUrl;
  int? totalModules;
  int? totalDuration;
  int? completionPct;
  String? accessType;

  Journeys({this.courseId, this.title, this.imageUrl, this.totalModules, this.totalDuration, this.completionPct, this.accessType});

  Journeys.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    totalModules = json['totalModules'];
    totalDuration = json['totalDuration'];
    completionPct = json['completionPct'];
    accessType = json['accessType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['totalModules'] = totalModules;
    data['totalDuration'] = totalDuration;
    data['completionPct'] = completionPct;
    data['accessType'] = accessType;
    return data;
  }
}
