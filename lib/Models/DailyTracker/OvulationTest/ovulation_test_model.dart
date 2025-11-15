import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryOvulationTest {
  List<OptionModel> ovulationTestTime;
  List<OptionModel> ovulationTestResult;

  CategoryOvulationTest({
    required this.ovulationTestTime,
    required this.ovulationTestResult,
  });

  void updateFrom(OvulationTestResponseModel data) {
    for (var option in ovulationTestTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in ovulationTestResult) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
  }

  void validate() {
    OptionModel? time = ovulationTestTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    }
  }

  Future<OvulationTestResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = ovulationTestTime.firstWhereOrNull((option) => option.isSelected);

    return OvulationTestResponseModel(
        userId: userId!, date: date, timeOfDay: time!.text.replaceAll(" ", ""), answer: ovulationTestResult.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class OvulationTestResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  List<String>? answer;

  OvulationTestResponseModel({
    this.userId,
    this.date,
    this.timeOfDay,
    this.answer,
  });

  OvulationTestResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    answer = json['answer'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['answer'] = answer;
    return data;
  }
}
