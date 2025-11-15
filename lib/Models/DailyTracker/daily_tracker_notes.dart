class DailyTrackerNotes {
  String? date;
  String? userId;
  String? text;
  String? id;

  DailyTrackerNotes({this.date, this.userId, this.text, this.id});

  DailyTrackerNotes.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    userId = json['userId'];
    text = json['text'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['userId'] = userId;
    data['text'] = text;
    return data;
  }
}
