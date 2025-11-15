import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryFatigue {
  List<OptionModel> fatigueTime;
  int fatigueLevel;
  List<OptionModel> fatigueOptions;
  List<OptionModel> durationOptions;
  String fatigueNotes;
  String notesPlaceholder;

  CategoryFatigue({required this.fatigueTime, required this.fatigueLevel, required this.fatigueOptions, required this.notesPlaceholder, required this.durationOptions, required this.fatigueNotes});

  void updateFrom(FatigueResponseModel data) {
    for (var option in fatigueTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in fatigueOptions) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in durationOptions) {
      bool isSelected = data.duration!.contains(option.text);
      option.isSelected = isSelected;
    }
    fatigueLevel = data.intensityScale ?? 1;
    fatigueNotes = data.note ?? "";
  }

  void validate() {
    OptionModel? time = fatigueTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (fatigueLevel == 0) {
      throw "Please choose fatigue level on scale";
    }
  }

  Future<FatigueResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = fatigueTime.firstWhereOrNull((option) => option.isSelected);

    return FatigueResponseModel(
      userId: userId!,
      date: date,
      note: fatigueNotes,
      timeOfDay: time!.text.replaceAll(" ", ""),
      intensityScale: fatigueLevel,
      answer: fatigueOptions.where((option) => option.isSelected).map((option) => option.text).toList(),
      duration: durationOptions.where((option) => option.isSelected).map((option) => option.text).toList(),
    );
  }
}

class FatigueResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? answer;
  List<String>? duration;
  List<String>? condition;
  List<String>? conditionDuration;
  String? note;

  FatigueResponseModel({this.userId, this.date, this.timeOfDay, this.intensityScale, this.answer, this.duration, this.condition, this.conditionDuration, this.note});

  FatigueResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    intensityScale = json['intensityScale'];
    answer = json['answer']?.cast<String>();
    duration = json['duration']?.cast<String>();
    condition = json['condition']?.cast<String>();
    conditionDuration = json['conditionDuration']?.cast<String>();
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['intensityScale'] = intensityScale;
    data['answer'] = answer ?? [];
    data['duration'] = duration ?? [];
    data['condition'] = condition ?? [];
    data['conditionDuration'] = conditionDuration ?? [];
    data['note'] = note;

    return data;
  }
}
