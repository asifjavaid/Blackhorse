import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryAlcohol {
  List<OptionModel> alcoholTime;
  List<OptionModel> typeOfAlcohol;
  String units;
  String notes;
  String notesPlaceholder;

  CategoryAlcohol({required this.alcoholTime, required this.typeOfAlcohol, required this.notes, required this.notesPlaceholder, required this.units});

  void updateFrom(AlcoholResponseModel data) {
    for (var option in alcoholTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in typeOfAlcohol) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    notes = data.note ?? "";
    units = data.unit != null ? data.unit.toString() : "Select units";
  }

  void validate() {
    OptionModel? time = alcoholTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (units == "Select units") {
      throw "Please select the number of units";
    }
  }

  Future<AlcoholResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = alcoholTime.firstWhereOrNull((option) => option.isSelected);

    return AlcoholResponseModel(
        userId: userId!,
        date: date,
        timeOfDay: time!.text.replaceAll(" ", ""),
        unit: int.parse(units),
        note: notes,
        answer: typeOfAlcohol.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class AlcoholResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  int? unit;
  List<String>? answer;
  String? note;

  AlcoholResponseModel({this.userId, this.date, this.timeOfDay, this.unit, this.answer, this.note});

  AlcoholResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    unit = json['unit'];
    answer = json['answer'].cast<String>();
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['unit'] = unit;
    data['answer'] = answer;
    data['note'] = note;
    return data;
  }
}
