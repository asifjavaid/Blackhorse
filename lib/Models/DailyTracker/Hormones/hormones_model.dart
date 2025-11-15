import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryHormones {
  List<OptionModel> hormonesTime;
  List<OptionModel> hormonesCombinedPills;
  String notes;
  String notesPlaceholder;

  CategoryHormones({required this.hormonesTime, required this.hormonesCombinedPills, required this.notes, required this.notesPlaceholder});

  void updateFrom(HormonesResponseModel data) {
    for (var option in hormonesTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in hormonesCombinedPills) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    notes = data.note ?? "";
  }

  void validate() {
    OptionModel? time = hormonesTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    }
  }

  Future<HormonesResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = hormonesTime.firstWhereOrNull((option) => option.isSelected);

    return HormonesResponseModel(
        userId: userId!, date: date, timeOfDay: time!.text.replaceAll(" ", ""), note: notes, answer: hormonesCombinedPills.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class HormonesResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  List<String>? answer;
  String? note;

  HormonesResponseModel({this.userId, this.date, this.timeOfDay, this.answer, this.note});

  HormonesResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    answer = json['answer'].cast<String>();
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['answer'] = answer;
    data['note'] = note;
    return data;
  }
}
