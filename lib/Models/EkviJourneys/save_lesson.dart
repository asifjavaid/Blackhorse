class SaveLesson {
  String? message;
  bool? isSaved;

  SaveLesson({this.message, this.isSaved});

  SaveLesson.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['isSaved'] = isSaved;
    return data;
  }
}
