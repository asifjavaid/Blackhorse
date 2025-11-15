import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryPregnancyTest {
  List<OptionModel> pregnancyTestTime;
  List<OptionModel> pregnancyTestResult;

  CategoryPregnancyTest({
    required this.pregnancyTestTime,
    required this.pregnancyTestResult,
  });

  void updateFrom(PregnancyTestResponseModel data) {
    for (var option in pregnancyTestTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in pregnancyTestResult) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
  }

  void validate() {
    OptionModel? time = pregnancyTestTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    }
  }

  Future<PregnancyTestResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = pregnancyTestTime.firstWhereOrNull((option) => option.isSelected);

    return PregnancyTestResponseModel(
        userId: userId!, date: date, timeOfDay: time!.text.replaceAll(" ", ""), answer: pregnancyTestResult.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class PregnancyTestResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  List<String>? answer;

  PregnancyTestResponseModel({
    this.userId,
    this.date,
    this.timeOfDay,
    this.answer,
  });

  PregnancyTestResponseModel.fromJson(Map<String, dynamic> json) {
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
