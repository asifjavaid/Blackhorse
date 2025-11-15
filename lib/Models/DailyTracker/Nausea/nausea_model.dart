import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryNausea {
  List<OptionModel> nauseaTime;
  int nauseaLevel;
  List<OptionModel> nauseaOptions;
  List<OptionModel> durationOptions;
  String notesPlaceholder;
  String nauseaNotes;

  CategoryNausea({required this.nauseaTime, required this.nauseaLevel, required this.nauseaOptions, required this.notesPlaceholder, required this.nauseaNotes, required this.durationOptions});

  void updateFrom(NauseaResponseModel data) {
    for (var option in nauseaTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in nauseaOptions) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in durationOptions) {
      bool isSelected = data.duration!.contains(option.text);
      option.isSelected = isSelected;
    }
    nauseaLevel = data.intensityScale ?? 1;
    nauseaNotes = data.note ?? "";
  }

  void validate() {
    OptionModel? time = nauseaTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (nauseaLevel == 0) {
      throw "Please choose nausea level on scale";
    }
  }

  Future<NauseaResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = nauseaTime.firstWhereOrNull((option) => option.isSelected);

    return NauseaResponseModel(
        userId: userId!,
        date: date,
        timeOfDay: time!.text.replaceAll(" ", ""),
        intensityScale: nauseaLevel,
        answer: nauseaOptions.where((option) => option.isSelected).map((option) => option.text).toList(),
        duration: durationOptions.where((option) => option.isSelected).map((option) => option.text).toList(),
        note: nauseaNotes);
  }
}

class NauseaResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? answer;
  List<String>? duration;
  List<String>? condition;
  List<String>? conditionDuration;
  String? note;

  NauseaResponseModel({this.userId, this.date, this.timeOfDay, this.intensityScale, this.answer, this.duration, this.condition, this.conditionDuration, this.note});

  NauseaResponseModel.fromJson(Map<String, dynamic> json) {
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
