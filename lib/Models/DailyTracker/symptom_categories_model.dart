import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/Alcohol/alcohol_model.dart';
import 'package:ekvi/Models/DailyTracker/Bloating/bloating_model.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_model.dart';
import 'package:ekvi/Models/DailyTracker/BrainFog/brain_fog_model.dart';
import 'package:ekvi/Models/DailyTracker/Energy/energy_model.dart';
import 'package:ekvi/Models/DailyTracker/Fatigue/fatigue_model.dart';
import 'package:ekvi/Models/DailyTracker/Hormones/hormones_model.dart';
import 'package:ekvi/Models/DailyTracker/Intimacy/intimacy_model.dart';
import 'package:ekvi/Models/DailyTracker/Mood/mood_model.dart';
import 'package:ekvi/Models/DailyTracker/Movement/movement_model.dart';
import 'package:ekvi/Models/DailyTracker/Nausea/nausea_model.dart';
import 'package:ekvi/Models/DailyTracker/OvulationTest/ovulation_test_model.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/pain_killers_model.dart';
import 'package:ekvi/Models/DailyTracker/PregnancyTest/pregnancy_test_model.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_model.dart';
import 'package:ekvi/Models/DailyTracker/Stress/stress_model.dart';
import 'package:ekvi/Models/DailyTracker/categories_by_date.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/DailyTracker/Headache/headache_model.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Utils/helpers/time_helper.dart';
import 'package:flutter/material.dart';

import '../Urination/urination_urgency_model.dart';
import 'PainRelief/pain_relief_model.dart';

class SymptomCategoriesModel {
  CategoryBodyPartPain bodyPain;
  CategoryBleeding bleeding;
  CategoryMood mood;
  CategoryEnergy energy;
  CategoryStress stress;
  CategoryHormones hormones;
  CategoryAlcohol alcohol;
  CategoryOvulationTest ovulationTest;
  CategoryPregnancyTest pregnancyTest;
  CategoryNausea nausea;
  CategoryFatigue fatigue;
  CategoryBloating bloating;
  CategoryBrainFog brainFog;
  CategoryIntimacy intimacy;
  CategoryBowelMovement bowlMovement;
  CategoryUrinationUrgency urinationUrgency;
  CategoryPainKillers painKillers;
  CategoryMovement movements;
  CategorySelfCare selfCare;
  CategoryPainRelief painRelief;

  SymptomCategoriesModel(
      {required this.bodyPain,
      required this.bleeding,
      required this.hormones,
      required this.alcohol,
      required this.intimacy,
      required this.pregnancyTest,
      required this.ovulationTest,
      required this.painKillers,
      required this.mood,
      required this.stress,
      required this.energy,
      required this.nausea,
      required this.fatigue,
      required this.brainFog,
      required this.bloating,
      required this.bowlMovement,
      required this.urinationUrgency,
      required this.movements,
      required this.selfCare,
      required this.painRelief});
}

class CategoryBleeding {
  List<OptionModel> options;
  List<OptionModel> painTimeOptions;
  List<OptionModel> consistency;
  List<OptionModel> colour;
  int pads;

  CategoryBleeding({required this.painTimeOptions, required this.options, required this.colour, required this.consistency, required this.pads});

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    OptionModel? bleeding = options.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (bleeding == null) {
      throw "Please select bleeding intensity.";
    }
  }

  void updateFrom(DailyTrackerAnswers data) {
    for (var option in painTimeOptions) {
      bool isSelected = data.timeOfDay?.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    for (var option in options) {
      bool isSelected = data.answer?.contains(option.text) ?? false;
      option.isSelected = isSelected;
    }

    for (var option in colour) {
      bool isSelected = data.color!.contains(option.text.replaceAll(" ", "_"));
      option.isSelected = isSelected;
    }

    for (var option in consistency) {
      bool isSelected = data.consistency!.contains(option.text.replaceAll(" ", "_"));
      option.isSelected = isSelected;
    }
    pads = data.pads ?? 0;
  }

  Future<DailyTrackerAnswers> convertTo(String date, String timeOfDay) async {
    DailyTrackerAnswers data = DailyTrackerAnswers();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = timeOfDay;
    data.answer = options.where((option) => option.isSelected).map((option) => option.text).toList();
    data.pads = pads;
    data.color = colour.where((option) => option.isSelected).map((option) => option.text.replaceAll(" ", "_")).toList();
    data.consistency = consistency.where((option) => option.isSelected).map((option) => option.text.replaceAll(" ", "_")).toList();
    return data;
  }
}

class CategoryBodyPartPain {
  bool editingBodyPartsEnabled;
  bool isEditing;
  List<BodyPart> selectedBodyParts;
  JustExisting justExisting;
  Eating eating;
  Toilet toilet;
  Travel travel;
  Exercise exercise;
  Sleep sleep;
  Sex sex;
  Work work;
  Headache headache;

  CategoryBodyPartPain(
      {required this.selectedBodyParts,
      required this.justExisting,
      required this.eating,
      required this.toilet,
      required this.travel,
      required this.exercise,
      required this.sleep,
      required this.sex,
      required this.work,
      required this.headache,
      this.editingBodyPartsEnabled = true,
      this.isEditing = false});
}

class BodyPart {
  final String? name;
  final String nameForUser;
  final String? category1;
  final Rect? area;
  final BodySide? bodySide;

  BodyPart({
    this.name,
    required this.nameForUser,
    this.category1,
    this.area,
    this.bodySide,
  });
}

class JustExisting {
  int? painLevel;
  List<OptionModel> feelsLikeOptions;
  List<OptionModel> painTimeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  JustExisting({
    this.painLevel,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Existing";
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;
    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];
    data.timezone = await TimeHelper.getCurrentTimezone();
    return data;
  }
}

class Eating {
  List<OptionModel> conditions;
  int? painLevel;
  List<OptionModel> feelsLikeOptions;
  List<OptionModel> painTimeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Eating(
      {required this.conditions, required this.feelsLikeOptions, required this.painTimeOptions, required this.impactGrid, required this.painLevel});

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in conditions) {
      bool isSelected = eventData.experience != null ? eventData.experience!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Eating";
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.experience = conditions.where((option) => option.isSelected).map((option) => option.text).toList();

    data.intensityScale = painLevel != null ? painLevel! : 0;

    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];

    data.timezone = await TimeHelper.getCurrentTimezone();
    return data;
  }
}

class Toilet {
  List<OptionModel> conditions;
  int? painLevel;
  List<OptionModel> feelsLikeOptions;
  List<OptionModel> painTimeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Toilet({
    required this.conditions,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
    required this.painLevel,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in conditions) {
      bool isSelected = eventData.experience != null ? eventData.experience!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Toilet";
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.experience = conditions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;
    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];

    data.timezone = await TimeHelper.getCurrentTimezone();
    return data;
  }
}

class Travel {
  List<OptionModel> conditions;
  int? painLevel;
  List<OptionModel> feelsLikeOptions;
  List<OptionModel> painTimeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Travel({
    required this.conditions,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
    required this.painLevel,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in conditions) {
      bool isSelected = eventData.experience != null ? eventData.experience!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Travel";

    data.experience = conditions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;

    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];

    data.timezone = await TimeHelper.getCurrentTimezone();
    return data;
  }
}

class Work {
  List<OptionModel> describeWorkDay;
  int? painLevel;
  List<OptionModel> feelsLikeOptions;
  List<OptionModel> painTimeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Work({
    required this.describeWorkDay,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
    required this.painLevel,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in describeWorkDay) {
      bool isSelected = eventData.experience != null ? eventData.experience!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Work";

    data.experience = describeWorkDay.where((option) => option.isSelected).map((option) => option.text).toList();
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;

    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];

    data.timezone = await TimeHelper.getCurrentTimezone();
    return data;
  }
}

class Exercise {
  List<OptionModel> cardio;
  List<OptionModel> strengthTraining;
  List<OptionModel> flexibilityAndBalance;
  List<OptionModel> sports;
  List<OptionModel> others;
  int? painLevel;
  List<OptionModel> feelsLikeOptions;
  List<OptionModel> painTimeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Exercise({
    required this.cardio,
    required this.strengthTraining,
    required this.flexibilityAndBalance,
    required this.sports,
    required this.others,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
    required this.painLevel,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;

    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));

    _updateExerciseType(eventData.exerciseType, 'Cardio', cardio);
    _updateExerciseType(eventData.exerciseType, 'Strength Training', strengthTraining);
    _updateExerciseType(eventData.exerciseType, 'Flexibility & Balance', flexibilityAndBalance);
    _updateExerciseType(eventData.exerciseType, 'Sports', sports);
    _updateExerciseType(eventData.exerciseType, 'Others', others);
  }

  void _updateExerciseType(List<ExerciseType>? exerciseTypes, String typeName, List<OptionModel> options) {
    if (exerciseTypes == null) return;
    var exerciseType = exerciseTypes.firstWhereOrNull((et) => et.name == typeName);
    if (exerciseType != null) {
      for (var option in options) {
        option.isSelected = exerciseType.types!.contains(option.text);
      }
    }
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Exercise";
    // data.experience = conditions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;

    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];
    data.exerciseType = _getSelectedExerciseTypes();
    data.timezone = await TimeHelper.getCurrentTimezone();
    return data;
  }

  List<ExerciseType> _getSelectedExerciseTypes() {
    List<ExerciseType> exerciseTypes = [];

    _addSelectedExerciseType('Cardio', cardio, exerciseTypes);
    _addSelectedExerciseType('Strength Training', strengthTraining, exerciseTypes);
    _addSelectedExerciseType('Flexibility & Balance', flexibilityAndBalance, exerciseTypes);
    _addSelectedExerciseType('Sports', sports, exerciseTypes);
    _addSelectedExerciseType('Others', others, exerciseTypes);

    return exerciseTypes;
  }

  void _addSelectedExerciseType(String name, List<OptionModel> options, List<ExerciseType> exerciseTypes) {
    List<String> selectedTypes = options.where((option) => option.isSelected).map((option) => option.text).toList();
    if (selectedTypes.isNotEmpty) {
      exerciseTypes.add(ExerciseType(name: name, types: selectedTypes));
    }
  }
}

class Sleep {
  List<OptionModel> conditions;
  int? painLevel;
  List<OptionModel> feelsLikeOptions;
  List<OptionModel> painTimeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Sleep({
    required this.conditions,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
    required this.painLevel,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in conditions) {
      bool isSelected = eventData.experience != null ? eventData.experience!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Sleep";
    data.experience = conditions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;

    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];
    data.timezone = await TimeHelper.getCurrentTimezone();
    return data;
  }
}

class Urination {
  List<OptionModel> painTimeOptions;
  int? painLevel;
  List<OptionModel> experience;
  List<OptionModel> activity;
  List<OptionModel> intimacyType;
  List<OptionModel> toolType;
  List<OptionModel> climaxType;
  List<OptionModel> feelsLikeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Urination({
    required this.experience,
    required this.activity,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
    required this.painLevel,
    required this.intimacyType,
    required this.toolType,
    required this.climaxType,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in experience) {
      bool isSelected = eventData.experience != null ? eventData.experience!.contains(option.text) : false;
      option.isSelected = isSelected;
    }

    for (var option in activity) {
      bool isSelected = eventData.intimacyActivity != null ? eventData.intimacyActivity!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in intimacyType) {
      bool isSelected = eventData.intimacyType != null ? eventData.intimacyType!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in toolType) {
      bool isSelected = eventData.toolType != null ? eventData.toolType!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in climaxType) {
      bool isSelected = eventData.climaxType != null ? eventData.climaxType!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Intimacy";
    data.experience = experience.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intimacyActivity = activity.where((option) => option.isSelected).map((option) => option.text).toList();
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;
    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];
    data.timezone = await TimeHelper.getCurrentTimezone();
    data.intimacyType = intimacyType.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intimacyTool = toolType.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intimacyOrgasm = climaxType.where((option) => option.isSelected).map((option) => option.text).toList();
    return data;
  }
}

class Sex {
  List<OptionModel> painTimeOptions;
  int? painLevel;
  List<OptionModel> experience;
  List<OptionModel> activity;
  List<OptionModel> intimacyType;
  List<OptionModel> toolType;
  List<OptionModel> climaxType;
  List<OptionModel> feelsLikeOptions;
  ImpactGrid impactGrid;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Sex({
    required this.experience,
    required this.activity,
    required this.feelsLikeOptions,
    required this.painTimeOptions,
    required this.impactGrid,
    required this.painLevel,
    required this.intimacyType,
    required this.toolType,
    required this.climaxType,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(EventData eventData) {
    painLevel = eventData.intensityScale;
    for (var option in experience) {
      bool isSelected = eventData.experience != null ? eventData.experience!.contains(option.text) : false;
      option.isSelected = isSelected;
    }

    for (var option in activity) {
      bool isSelected = eventData.intimacyActivity != null ? eventData.intimacyActivity!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in intimacyType) {
      bool isSelected = eventData.intimacyType != null ? eventData.intimacyType!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in toolType) {
      bool isSelected = eventData.toolType != null ? eventData.toolType!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in climaxType) {
      bool isSelected = eventData.climaxType != null ? eventData.climaxType!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in feelsLikeOptions) {
      bool isSelected = eventData.feeling != null ? eventData.feeling!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in painTimeOptions) {
      bool isSelected = eventData.timeOfDay != null ? HelperFunctions.formatTimeOfDay(eventData.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }

    impactGrid = eventData.partOfLifeEffect == null
        ? ImpactGrid(qualityOfLifeValue: 0, sleepValue: 0, socialLifeValue: 0, workValue: 0)
        : ImpactGrid(
            qualityOfLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[3])].impactLevel!),
            sleepValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[2])].impactLevel!),
            socialLifeValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[1])].impactLevel!),
            workValue: columns
                .indexOf(eventData.partOfLifeEffect![eventData.partOfLifeEffect!.indexWhere((element) => element.type == rows[0])].impactLevel!));
  }

  Future<DailyTrackerEvent> convertTo(List<BodyPart> bodyParts, String date) async {
    DailyTrackerEvent data = DailyTrackerEvent();
    data.name = bodyParts.map((bodyPart) => bodyPart.name!.replaceAll(" ", "-")).toList();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)!.text.replaceAll(" ", "");
    data.activity = "Intimacy";
    data.experience = experience.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intimacyActivity = activity.where((option) => option.isSelected).map((option) => option.text).toList();
    data.feeling = feelsLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intensityScale = painLevel != null ? painLevel! : 0;
    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];
    data.timezone = await TimeHelper.getCurrentTimezone();
    data.intimacyType = intimacyType.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intimacyTool = toolType.where((option) => option.isSelected).map((option) => option.text).toList();
    data.intimacyOrgasm = climaxType.where((option) => option.isSelected).map((option) => option.text).toList();
    return data;
  }
}

class Headache {
  int? painLevel;
  List<OptionModel> painTimeOptions;
  List<OptionModel> feltLikeOptions;
  List<OptionModel> locationOptions;
  List<OptionModel> typeOptions;
  List<OptionModel> onsetOptions;
  ImpactGrid impactGrid;
  DateTime durationTime;
  String headacheNotes;
  String notesPlaceholder;
  List<String> columns = ["None", "Mild", "Mod", "Severe"];
  List<String> rows = ["Work", "Social life", "Sleep", "Quality of life"];

  Headache({
    this.painLevel,
    required this.painTimeOptions,
    required this.feltLikeOptions,
    required this.locationOptions,
    required this.typeOptions,
    required this.onsetOptions,
    required this.impactGrid,
    required this.durationTime,
    required this.headacheNotes,
    required this.notesPlaceholder,
  });

  void validate() {
    OptionModel? time = painTimeOptions.firstWhereOrNull((option) => option.isSelected);
    if (time == null) {
      throw "Please select time";
    } else if (painLevel == 0) {
      throw "Please choose pain level on scale";
    }
  }

  void updateFrom(HeadacheResponseModel data) {
    painLevel = data.intensityScale;
    for (var option in painTimeOptions) {
      bool isSelected = data.timeOfDay != null ? HelperFunctions.formatTimeOfDay(data.timeOfDay) == option.text : false;
      option.isSelected = isSelected;
    }
    for (var option in feltLikeOptions) {
      bool isSelected = data.feltLike != null ? data.feltLike!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in locationOptions) {
      bool isSelected = data.location != null ? data.location!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in typeOptions) {
      bool isSelected = data.type != null ? data.type!.contains(option.text) : false;
      option.isSelected = isSelected;
    }
    for (var option in onsetOptions) {
      bool isSelected = data.onset != null ? data.onset == option.text : false;
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

    durationTime = data.durationInMinutes != null ? DateTime(0, 1, 1, 0, data.durationInMinutes!) : DateTime(0, 1, 1, 0, 0);
    headacheNotes = data.note ?? "";
  }

  Future<HeadacheRequestModel> convertTo(String date) async {
    HeadacheRequestModel data = HeadacheRequestModel();
    data.userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    data.date = date;
    data.timeOfDay = painTimeOptions.firstWhereOrNull((element) => element.isSelected == true)?.text.replaceAll(" ", "") ?? "Morning";
    data.intensityScale = painLevel ?? 0;
    data.feltLike = feltLikeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.location = locationOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.type = typeOptions.where((option) => option.isSelected).map((option) => option.text).toList();
    data.onset = onsetOptions.firstWhereOrNull((element) => element.isSelected == true)?.text ?? "";
    data.durationInMinutes = durationTime.hour * 60 + durationTime.minute;
    data.partOfLifeEffect = [
      PartOfLifeEffect(type: "Work", impactLevel: columns[impactGrid.workValue]),
      PartOfLifeEffect(type: "Social life", impactLevel: columns[impactGrid.socialLifeValue]),
      PartOfLifeEffect(type: "Sleep", impactLevel: columns[impactGrid.sleepValue]),
      PartOfLifeEffect(type: "Quality of life", impactLevel: columns[impactGrid.qualityOfLifeValue]),
    ];
    data.note = headacheNotes;
    return data;
  }
}

class CategoriesData {
  String title;
  Widget? icon;
  Color bgColor;
  CategoryDataType dataType;

  CategoriesData({required this.title, required this.bgColor, this.icon, required this.dataType});
}

class CycleData {
  String title;
  Icon icon;

  CycleData({required this.title, required this.icon});
}

class ImpactGrid {
  int workValue;
  int socialLifeValue;
  int sleepValue;
  int qualityOfLifeValue;

  ImpactGrid({required this.workValue, required this.socialLifeValue, required this.sleepValue, required this.qualityOfLifeValue});
}
