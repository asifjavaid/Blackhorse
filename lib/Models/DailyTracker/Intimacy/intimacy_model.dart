import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryIntimacy {
  List<OptionModel> intimacyTime;
  List<OptionModel> typeOfIntimacy;
  List<OptionModel> activityOfInitmacy;

  CategoryIntimacy({required this.intimacyTime, required this.typeOfIntimacy, required this.activityOfInitmacy});

  void updateFrom(IntimacyResponseModel data) {
    for (var option in intimacyTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in typeOfIntimacy) {
      bool isSelected = data.answer!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in activityOfInitmacy) {
      bool isSelected = data.activity!.contains(option.text);
      option.isSelected = isSelected;
    }
  }

  void validate() {
    OptionModel? time = intimacyTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    }
  }

  Future<IntimacyResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = intimacyTime.firstWhereOrNull((option) => option.isSelected);

    return IntimacyResponseModel(
        userId: userId!,
        date: date,
        timeOfDay: time!.text.replaceAll(" ", ""),
        activity: activityOfInitmacy.where((option) => option.isSelected).map((option) => option.text).toList(),
        answer: typeOfIntimacy.where((option) => option.isSelected).map((option) => option.text).toList());
  }
}

class IntimacyResponseModel {
  String? userId;
  String? date;
  String? timeOfDay;
  List<String>? answer;
  List<String>? activity;

  IntimacyResponseModel({this.userId, this.date, this.timeOfDay, this.answer, this.activity});

  IntimacyResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    answer = json['answer'].cast<String>();
    activity = json['activity'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['answer'] = answer;
    data['activity'] = activity;
    return data;
  }
}
