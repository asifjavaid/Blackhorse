class LessonProgress {
  Module? module;
  Course? course;

  LessonProgress({this.module, this.course});

  LessonProgress.fromJson(Map<String, dynamic> json) {
    module = json['module'] != null ? Module.fromJson(json['module']) : null;
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (module != null) {
      data['module'] = module!.toJson();
    }
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class Module {
  String? moduleId;
  int? completionPct;

  Module({this.moduleId, this.completionPct});

  Module.fromJson(Map<String, dynamic> json) {
    moduleId = json['moduleId'];
    completionPct = json['completionPct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['moduleId'] = moduleId;
    data['completionPct'] = completionPct;
    return data;
  }
}

class Course {
  String? courseId;
  int? completionPct;

  Course({this.courseId, this.completionPct});

  Course.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    completionPct = json['completionPct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['completionPct'] = completionPct;
    return data;
  }
}
