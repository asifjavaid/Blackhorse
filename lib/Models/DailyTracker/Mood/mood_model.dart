import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryMood {
  List<OptionModel> moodTime;
  int moodLevel;
  List<OptionModel> moodOptions;
  String moodNotes;
  String notesPlaceholder;

  CategoryMood({required this.moodTime, required this.moodLevel, required this.moodOptions, required this.moodNotes, required this.notesPlaceholder});

  void updateFrom(MoodResponseModel data) {
    for (var option in moodTime) {
      bool isSelected = data.timeOfDay != null ? data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase() : false;
      option.isSelected = isSelected;
    }
    for (var option in moodOptions) {
      bool isSelected = data.answer != null ? data.answer!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    moodNotes = data.note ?? "";
    moodLevel = data.intensityScale ?? 0;
  }

  void validate(bool validateTags) {
    OptionModel? time = moodTime.firstWhereOrNull((option) => option.isSelected);
    bool isMoodTagSelected = moodOptions.any((moodOption) => moodOption.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (moodLevel == 0) {
      throw "Please choose mood level on scale";
    } else if (!isMoodTagSelected && validateTags) {
      throw "Please describe your mood";
    }
  }

  Future<MoodResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = moodTime.firstWhereOrNull((option) => option.isSelected);

    return MoodResponseModel(
        userId: userId!,
        date: date,
        timeOfDay: time!.text.replaceAll(" ", ""),
        intensityScale: moodLevel,
        note: moodNotes,
        answer: moodOptions.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class MoodResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? answer;
  String? note;

  MoodResponseModel({this.userId, this.date, this.timeOfDay, this.intensityScale, this.answer, this.note});

  MoodResponseModel.fromJson(Map<String, dynamic> json) {
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
