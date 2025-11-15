// ignore_for_file: unnecessary_new

import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryBowelMovement {
  List<OptionModel> bowelMovementTime;
  int bowelMovementLevel;
  int frequencyLevel;
  List<OptionModel> bristolStoolScaleOptions;
  List<OptionModel> colorOptions;
  List<OptionModel> sizeOptions;
  List<OptionModel> effortOptions;
  List<OptionModel> unusualComponentsOptions;
  List<OptionModel> durationOptions;
  String bowelMovementNotes;
  String notesPlaceholder;

  CategoryBowelMovement(
      {required this.bowelMovementTime,
      required this.bowelMovementLevel,
      required this.frequencyLevel,
      required this.bristolStoolScaleOptions,
      required this.notesPlaceholder,
      required this.colorOptions,
      required this.sizeOptions,
      required this.effortOptions,
      required this.unusualComponentsOptions,
      required this.durationOptions,
      required this.bowelMovementNotes});

  void updateFrom(BowelMovResponseModel data) {
    for (var option in bowelMovementTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }

    for (var option in colorOptions) {
      bool isSelected = data.stoolColour!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in sizeOptions) {
      bool isSelected = data.stoolSize!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in effortOptions) {
      bool isSelected = data.stoolEffort!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in unusualComponentsOptions) {
      bool isSelected = data.stoolComponents!.contains(option.text);
      option.isSelected = isSelected;
    }

    for (var option in durationOptions) {
      bool isSelected = data.stoolDuration!.contains(option.text);
      option.isSelected = isSelected;
    }

    for (var option in bristolStoolScaleOptions) {
      bool isSelected = data.bristolScale!.toLowerCase() == option.text.toLowerCase();
      option.isSelected = isSelected;
    }

    frequencyLevel = data.stoolFrequency ?? 1;
    bowelMovementLevel = data.stoolConsistency ?? 0;
    bowelMovementNotes = data.stoolNotes ?? "";
  }

  void validate() {
    OptionModel? time = bowelMovementTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (bowelMovementLevel == 0) {
      throw "Please choose bowelMovement level on scale";
    }
  }

  Future<BowelMovResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = bowelMovementTime.firstWhereOrNull((option) => option.isSelected);
    OptionModel? bristolStool = bristolStoolScaleOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? colors = colorOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? size = sizeOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? effort = effortOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? component = unusualComponentsOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? duration = durationOptions.firstWhereOrNull((option) => option.isSelected);

    return BowelMovResponseModel(
      userId: userId!,
      date: date,
      timeOfDay: time!.text.replaceAll(" ", ""),
      bristolScale: bristolStool != null ? bristolStoolScaleOptions.firstWhere((option) => option.isSelected).text : '',
      stoolConsistency: bowelMovementLevel,
      stoolFrequency: frequencyLevel,
      stoolColour: colors != null ? colorOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
      stoolSize: size != null ? sizeOptions.firstWhere((option) => option.isSelected).text : '',
      stoolEffort: effort != null ? effortOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
      stoolComponents: component != null ? unusualComponentsOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
      stoolDuration: duration != null ? durationOptions.firstWhere((option) => option.isSelected).text : '',
      stoolNotes: bowelMovementNotes,
    );
  }
}

class BowelMovResponseModel {
  String? userId;
  String? id;
  String? date;
  String? timeOfDay;
  int? stoolConsistency;
  int? stoolFrequency;
  String? bristolScale;
  List<String>? stoolColour;
  String? stoolSize;
  List<String>? stoolEffort;
  List<String>? stoolComponents;
  String? stoolDuration;
  String? stoolNotes;

  BowelMovResponseModel(
      {this.userId,
      this.date,
      this.timeOfDay,
      this.stoolConsistency,
      this.stoolFrequency,
      this.bristolScale,
      this.stoolColour,
      this.stoolSize,
      this.stoolEffort,
      this.stoolComponents,
      this.stoolDuration,
      this.stoolNotes});

  BowelMovResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    stoolConsistency = json['stoolConsistency'];
    stoolFrequency = json['stoolFrequency'];
    bristolScale = json['bristolScale'];
    stoolColour = json['stoolColour'].cast<String>();
    stoolSize = json['stoolSize'];
    stoolEffort = json['stoolEffort'].cast<String>();
    stoolComponents = json['stoolComponents'].cast<String>();
    stoolDuration = json['stoolDuration'];
    stoolNotes = json['stoolNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['stoolConsistency'] = stoolConsistency;
    data['stoolFrequency'] = stoolFrequency;
    data['bristolScale'] = bristolScale;
    data['stoolColour'] = stoolColour;
    data['stoolSize'] = stoolSize;
    data['stoolEffort'] = stoolEffort;
    data['stoolComponents'] = stoolComponents;
    data['stoolDuration'] = stoolDuration;
    data['stoolNotes'] = stoolNotes;
    return data;
  }
}
