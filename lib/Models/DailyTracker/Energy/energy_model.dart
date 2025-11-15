import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryEnergy {
  List<OptionModel> energyTime;
  int energyLevel;
  List<OptionModel> energyOptions;
  String energyNotes;
  String notesPlaceholder;

  CategoryEnergy({required this.energyTime, required this.energyLevel, required this.energyOptions, required this.energyNotes, required this.notesPlaceholder});

  void updateFrom(EnergyResponseModel data) {
    for (var option in energyTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in energyOptions) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    energyNotes = data.note ?? "";
    energyLevel = data.intensityScale ?? 1;
  }

  Future<EnergyResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = energyTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) throw "Please select time";
    if (energyLevel == 0) throw "Please choose energy level on scale";

    return EnergyResponseModel(
        userId: userId!,
        date: date,
        timeOfDay: time.text.replaceAll(" ", ""),
        intensityScale: energyLevel,
        note: energyNotes,
        answer: energyOptions.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class EnergyResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  int? intensityScale;
  List<String>? answer;
  String? note;

  EnergyResponseModel({this.userId, this.date, this.timeOfDay, this.intensityScale, this.answer, this.note});

  EnergyResponseModel.fromJson(Map<String, dynamic> json) {
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
