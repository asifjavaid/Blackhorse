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
  ImpactGrid impactGrid;

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
      required this.impactGrid,
      required this.urineUrgencyNotes});

  void updateFrom(UrinationUrgencyResponseModel data) {
    for (var option in urinationUrgencyTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }

    for (var option in colorOptions) {
      bool isSelected = data.color!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in smellOptions) {
      bool isSelected = data.smell!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in volumeOptions) {
      bool isSelected = data.volume!.contains(option.text);
      option.isSelected = isSelected;
    }

    for (var option in sensationOptions) {
      bool isSelected = data.sensation!.contains(option.text);
      option.isSelected = isSelected;
    }

    for (var option in complications) {
      bool isSelected = data.complication!.contains(option.text);
      option.isSelected = isSelected;
    }
    for (var option in diagnoses) {
      bool isSelected = data.diagnosis!.contains(option.text);
      option.isSelected = isSelected;
    }
    impactGrid = data.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue:
                columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue:
                columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns.indexOf(data.partOfLifeEffect![data.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));

    frequencyLevel = data.frequencyScale ?? 1;
    urinationUrgencyLevel = data.urgencyScale ?? 0;
    urineUrgencyNotes = data.note ?? "";
  }

  void validate() {
    OptionModel? time = urinationUrgencyTime.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (urinationUrgencyLevel == 0) {
      throw "Please choose urination urgency level on scale";
    }
  }

  Future<UrinationUrgencyResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = urinationUrgencyTime.firstWhereOrNull((option) => option.isSelected);
    OptionModel? sensation = sensationOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? colors = colorOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? smell = smellOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? complication = complications.firstWhereOrNull((option) => option.isSelected);
    OptionModel? diagnosis = diagnoses.firstWhereOrNull((option) => option.isSelected);
    OptionModel? volumeOption = volumeOptions.firstWhereOrNull((option) => option.isSelected);

    return UrinationUrgencyResponseModel(
        userId: userId!,
        date: date,
        timeOfDay: time!.text.replaceAll(" ", ""),
        sensation: sensation != null ? sensationOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
        urgencyScale: urinationUrgencyLevel,
        frequencyScale: frequencyLevel,
        color: colors != null ? colorOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
        smell: smell != null ? smellOptions.where((option) => option.isSelected).map((option) => option.text).toList() : [],
        complication: complication != null ? complications.where((option) => option.isSelected).map((option) => option.text).toList() : [],
        diagnosis: diagnosis != null ? diagnoses.where((option) => option.isSelected).map((option) => option.text).toList() : [],
        volume: volumeOption != null ? volumeOptions.firstWhere((option) => option.isSelected).text : '',
        note: urineUrgencyNotes,
        partOfLifeEffect: [
          PartOfLifeEffectUrinationUrgency(type: "Work", impactLevel: columns[impactGrid.workValue]),
          PartOfLifeEffectUrinationUrgency(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
          PartOfLifeEffectUrinationUrgency(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
          PartOfLifeEffectUrinationUrgency(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
        ]);
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
  String? date;
  String? timeOfDay;
  int? urgencyScale;
  int? frequencyScale;
  List<String>? sensation;
  List<String>? complication;
  List<String>? diagnosis;
  List<String>? color;
  List<String>? smell;
  String? volume;
  List<PartOfLifeEffectUrinationUrgency>? partOfLifeEffect;
  String? note;

  UrinationUrgencyResponseModel({
    this.userId,
    this.date,
    this.timeOfDay,
    this.urgencyScale,
    this.frequencyScale,
    this.sensation,
    this.complication,
    this.diagnosis,
    this.color,
    this.smell,
    this.volume,
    this.partOfLifeEffect,
    this.note,
  });

  UrinationUrgencyResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    urgencyScale = json['urgencyScale'];
    frequencyScale = json['frequencyScale'];

    // Safely converting JSON arrays to List<String>
    sensation = json['sensation'] != null ? List<String>.from(json['sensation']) : null;
    complication = json['complication'] != null ? List<String>.from(json['complication']) : null;
    diagnosis = json['diagnosis'] != null ? List<String>.from(json['diagnosis']) : null;
    color = json['color'] != null ? List<String>.from(json['color']) : null;
    smell = json['smell'] != null ? List<String>.from(json['smell']) : null;

    volume = json['volume'];

    if (json['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffectUrinationUrgency>[];
      json['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffectUrinationUrgency.fromJson(v));
      });
    }

    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['timeOfDay'] = timeOfDay;
    data['urgencyScale'] = urgencyScale;
    data['frequencyScale'] = frequencyScale;
    data['sensation'] = sensation;
    data['complication'] = complication;
    data['diagnosis'] = diagnosis;
    data['color'] = color;
    data['smell'] = smell;
    data['volume'] = volume;

    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] = partOfLifeEffect!.map((v) => v.toJson()).toList();
    }

    data['note'] = note;
    return data;
  }
}
