import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryBrainFog {
  List<OptionModel> brainFogTime;
  int brainFogLevel;
  List<OptionModel> brainFogOptions;
  List<OptionModel> durationOptions;
  String brainFogNotes;
  String notesPlaceholder;

  CategoryBrainFog(
      {required this.brainFogTime, required this.brainFogLevel, required this.brainFogOptions, required this.notesPlaceholder, required this.durationOptions, required this.brainFogNotes});

  void updateFrom(BrainFogResponseModel data) {
    for (var option in brainFogTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in brainFogOptions) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in durationOptions) {
      bool isSelected = data.duration!.contains(option.text);
      option.isSelected = isSelected;
    }
    brainFogLevel = data.intensityScale ?? 1;
    brainFogNotes = data.note ?? "";
  }

  void validate() {
    OptionModel? time = brainFogTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (brainFogLevel == 0) {
      throw "Please choose brain fog level on scale";
    }
  }

  Future<BrainFogResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = brainFogTime.firstWhereOrNull((option) => option.isSelected);

    return BrainFogResponseModel(
      userId: userId!,
      date: date,
      note: brainFogNotes,
      timeOfDay: time!.text.replaceAll(" ", ""),
      intensityScale: brainFogLevel,
      answer: brainFogOptions.where((option) => option.isSelected).map((option) => option.text).toList(),
      duration: durationOptions.where((option) => option.isSelected).map((option) => option.text).toList(),
    );
  }
}

class BrainFogResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? answer;
  List<String>? duration;
  List<String>? condition;
  List<String>? conditionDuration;
  String? note;

  BrainFogResponseModel({this.userId, this.date, this.timeOfDay, this.intensityScale, this.answer, this.duration, this.condition, this.conditionDuration, this.note});

  BrainFogResponseModel.fromJson(Map<String, dynamic> json) {
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
