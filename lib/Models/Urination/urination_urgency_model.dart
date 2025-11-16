// ignore_for_file: unnecessary_new

import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

import '../DailyTracker/symptom_categories_model.dart';

class CategoryUrinationUrgency {
  List<OptionModel> urinationUrgencyTime;
  int urinationUrgencyLevel;
  int frequencyLevel;
  CategoryBodyPartPain bodyPain;
  List<OptionModel> sensationOptions;
  List<OptionModel> complications;
  List<OptionModel> diagnoses;
  List<OptionModel> colorOptions;
  List<OptionModel> smellOptions;
  List<OptionModel> volumeOptions;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];
  String urineUrgencyNotes;
  String notesPlaceholder;

  CategoryUrinationUrgency(
      {required this.urinationUrgencyTime,
      required this.urinationUrgencyLevel,
      required this.frequencyLevel,
        required this.bodyPain,
      required this.sensationOptions,
      required this.complications,
      required this.diagnoses,
      required this.notesPlaceholder,
      required this.colorOptions,
      required this.smellOptions,
      required this.volumeOptions,
      required this.urineUrgencyNotes});

  void updateFrom(UrinationUrgencyResponseModel data) {
    for (var option in urinationUrgencyTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }

    for (var option in colorOptions) {
      bool isSelected = data.stoolColour!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in smellOptions) {
      bool isSelected = data.stoolSize!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in volumeOptions) {
      bool isSelected = data.stoolEffort!.contains(option.text);
      option.isSelected = isSelected;
    }

    for (var option in sensationOptions) {
      bool isSelected = data.bristolScale!.toLowerCase() == option.text.toLowerCase();
      option.isSelected = isSelected;
    }

    for (var option in complications) {
      bool isSelected = data.bristolScale!.toLowerCase() == option.text.toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in diagnoses) {
      bool isSelected = data.bristolScale!.toLowerCase() == option.text.toLowerCase();
      option.isSelected = isSelected;
    }
/*

    impactGrid = data.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
        qualityOfLifeValue:
        columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
        sleepValue: columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
        socialLifeValue:
        columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
        workValue: columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
*/


    frequencyLevel = data.stoolFrequency ?? 1;
    urinationUrgencyLevel = data.stoolConsistency ?? 0;
    urineUrgencyNotes = data.stoolNotes ?? "";
  }

  void validate() {
    OptionModel? time = urinationUrgencyTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (urinationUrgencyLevel == 0) {
      throw "Please choose bowelMovement level on scale";
    }
  }

  Future<UrinationUrgencyResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = urinationUrgencyTime.firstWhereOrNull((option) => option.isSelected);
    OptionModel? bristolStool = sensationOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? colors = colorOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? size = smellOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? effort = volumeOptions.firstWhereOrNull((option) => option.isSelected);

    return UrinationUrgencyResponseModel(
      userId: userId!,
      date: date,
      timeOfDay: time!.text.replaceAll(" ", ""),
      bristolScale: bristolStool != null ? sensationOptions.firstWhere((option) => option.isSelected).text : '',
      stoolConsistency: urinationUrgencyLevel,
      stoolFrequency: frequencyLevel,
      stoolColour: colors != null ? colorOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
      stoolSize: size != null ? smellOptions.firstWhere((option) => option.isSelected).text : '',
      stoolEffort: effort != null ? volumeOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
      stoolNotes: urineUrgencyNotes,
    );
  }
}

class PartOfLifeEffectUrinationUrgency {
  String? type;
  String? impactLevel;

  PartOfLifeEffectUrinationUrgency({this.type, this.impactLevel});

  PartOfLifeEffectUrinationUrgency.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    impactLevel = json['impactLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['impactLevel'] = impactLevel;
    return data;
  }
}

class UrinationUrgencyResponseModel {
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
  List<PartOfLifeEffectUrinationUrgency>? partOfLifeEffect;

  UrinationUrgencyResponseModel(
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
        this.partOfLifeEffect,
      this.stoolNotes});

  UrinationUrgencyResponseModel.fromJson(Map<String, dynamic> json) {
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
