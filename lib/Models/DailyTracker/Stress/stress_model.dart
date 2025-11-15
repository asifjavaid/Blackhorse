import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryStress {
  List<OptionModel> stressTime;
  int stressLevel;
  List<OptionModel> stressOptions;
  String stressNotes;
  String notesPlaceholder;

  CategoryStress({required this.stressTime, required this.stressLevel, required this.stressOptions, required this.stressNotes, required this.notesPlaceholder});

  void updateFrom(StressResponseModel data) {
    for (var option in stressTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in stressOptions) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    stressNotes = data.note ?? "";
    stressLevel = data.intensityScale ?? 1;
  }

  Future<StressResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = stressTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) throw "Please select time";
    if (stressLevel == 0) throw "Please choose stress level on scale";

    return StressResponseModel(
        userId: userId!,
        date: date,
        timeOfDay: time.text.replaceAll(" ", ""),
        intensityScale: stressLevel,
        note: stressNotes,
        answer: stressOptions.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class StressResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? answer;
  String? note;

  StressResponseModel({this.userId, this.date, this.timeOfDay, this.intensityScale, this.answer, this.note});

  StressResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    intensityScale = json['intensityScale'];
    answer = json['answer'].cast<String>();
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['intensityScale'] = intensityScale;
    data['answer'] = answer;
    data['note'] = note;
    return data;
  }
}
