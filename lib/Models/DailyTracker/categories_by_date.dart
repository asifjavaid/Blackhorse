// import 'package:ekvi/Models/DailyTracker/BowelMovement/bathroom_habbits.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bathroom_habbits.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_notes.dart';

class CompletedCategoriesByDate {
  Data? thingsExperience;
  Data? symptoms;
  Data? thingsPutInBody;
  Data? intimacyAndFertility;
  Data? bathroomHabits;
  Data? wellbeing;
  DailyTrackerNotes? notes;

  CompletedCategoriesByDate(
      {this.thingsExperience,
      this.symptoms,
      this.thingsPutInBody,
      this.intimacyAndFertility,
      this.bathroomHabits,
      this.wellbeing,
      this.notes});

  CompletedCategoriesByDate.fromJson(Map<String, dynamic> json) {
    thingsExperience = json['Feelings'] != null
        ? Data.fromJson(json['Feelings'] as List)
        : null;
    symptoms = json['Symptoms'] != null
        ? Data.fromJson(json['Symptoms'] as List)
        : null;
    intimacyAndFertility = json['Fertility & Intimacy'] != null
        ? Data.fromJson(json['Fertility & Intimacy'] as List)
        : null;
    thingsPutInBody =
        json['Intake'] != null ? Data.fromJson(json['Intake'] as List) : null;
    bathroomHabits = json['Bathroom Habits'] != null
        ? Data.fromJson(json['Bathroom Habits'] as List)
        : null;
    wellbeing = json['Wellbeing'] != null
        ? Data.fromJson(json['Wellbeing'] as List)
        : null;
    notes =
        json['note'] != null ? DailyTrackerNotes.fromJson(json['note']) : null;
  }
}

class Data {
  List<EventData>? bodyPain;
  List<Answers>? bleeding;
  List<Answers>? ovulationTest;
  List<Answers>? emotions;
  List<Answers>? intimacy;
  List<Answers>? harmones;
  List<Answers>? alcohol;
  List<Answers>? pregnancyTest;
  List<Answers>? mood;
  List<Answers>? stress;
  List<Answers>? energy;
  List<Answers>? nausea;
  List<Answers>? fatigue;
  List<Answers>? bloating;
  List<Answers>? brainFog;
  List<Answers>? headache;
  List<Answers>? painKillers;
  List<Answers>? movement;
  List<Answers>? selfCare;
  List<Answers>? painRelief;
  List<BathroomHabit>? bowelMovement;

  Data(
      {this.bodyPain,
      this.bleeding,
      this.ovulationTest,
      this.emotions,
      this.intimacy,
      this.harmones,
      this.alcohol,
      this.pregnancyTest,
      this.mood,
      this.stress,
      this.energy,
      this.nausea,
      this.fatigue,
      this.bloating,
      this.brainFog,
      this.painKillers});

  Data.fromJson(List<dynamic> jsonList) {
    for (var json in jsonList) {
      switch (json['type']) {
        case 'Pain':
          bodyPain = bodyPain ?? <EventData>[];
          bodyPain!.add(EventData.fromJson(json));
          break;
        case 'Bleeding':
          bleeding = bleeding ?? <Answers>[];
          bleeding!.add(Answers.fromJson(json));
          break;
        case 'OvulationTest':
          ovulationTest = ovulationTest ?? <Answers>[];
          json["type"] = "Ovulation test";
          ovulationTest!.add(Answers.fromJson(json));
          break;
        case 'Emotions':
          emotions = emotions ?? <Answers>[];
          emotions!.add(Answers.fromJson(json));
          break;
        case 'Intimacy':
          intimacy = intimacy ?? <Answers>[];
          intimacy!.add(Answers.fromJson(json));
          break;
        case 'Hormones':
          harmones = harmones ?? <Answers>[];
          harmones!.add(Answers.fromJson(json));
          break;
        case 'Alcohol':
          alcohol = alcohol ?? <Answers>[];
          alcohol!.add(Answers.fromJson(json));
          break;
        case 'PregnancyTest':
          pregnancyTest = pregnancyTest ?? <Answers>[];
          json["type"] = "Pregnancy test";
          pregnancyTest!.add(Answers.fromJson(json));
          break;
        case 'Mood':
          mood = mood ?? <Answers>[];
          mood!.add(Answers.fromJson(json));
          break;
        case 'Stress':
          stress = stress ?? <Answers>[];
          stress!.add(Answers.fromJson(json));
          break;
        case 'Energy':
          energy = energy ?? <Answers>[];
          energy!.add(Answers.fromJson(json));
          break;
        case 'Nausea':
          nausea = nausea ?? <Answers>[];
          nausea!.add(Answers.fromJson(json));
          break;
        case 'Fatigue':
          fatigue = fatigue ?? <Answers>[];
          fatigue!.add(Answers.fromJson(json));
          break;
        case 'Bloating':
          bloating = bloating ?? <Answers>[];
          bloating!.add(Answers.fromJson(json));
          break;
        case 'Brain Fog':
          brainFog = brainFog ?? <Answers>[];
          brainFog!.add(Answers.fromJson(json));
          break;
        case 'Headache':
          headache = headache ?? <Answers>[];
          headache!.add(Answers.fromJson(json));
          break;
        case 'Bowel Movement':
          bowelMovement = bowelMovement ?? <BathroomHabit>[];
          bowelMovement!.add(BathroomHabit.fromJson(json));
          break;
        case 'Painkiller':
          painKillers = painKillers ?? <Answers>[];
          painKillers!.add(Answers.fromJson(json));
          break;
        case 'Movement':
          movement = movement ?? <Answers>[];
          movement!.add(Answers.fromJson(json));
          break;
        case 'SelfCare':
          selfCare = selfCare ?? <Answers>[];
          selfCare!.add(Answers.fromJson(json));
          break;
        case 'PainRelief':
          painRelief = painRelief ?? <Answers>[];
          painRelief!.add(Answers.fromJson(json));
          break;
        default:
          break;
      }
    }
  }
}

class EventData {
  String? type;
  String? activity;
  List<String>? experience;
  List<String>? intimacyActivity;
  List<String>? toolType;
  List<String>? intimacyType;
  List<String>? climaxType;
  List<BodyPartName>? bodyPartName;
  List<String>? feeling;
  List<ExerciseType>? exerciseType;
  String? timeOfDay;
  String? date;
  List<PartOfLifeEffect>? partOfLifeEffect;
  String? userId;
  int? intensityScale;
  String? id;
  String? intensity;

  EventData(
      {this.type,
      this.activity,
      this.experience,
      this.bodyPartName,
      this.feeling,
      this.exerciseType,
      this.timeOfDay,
      this.toolType,
      this.intimacyType,
      this.climaxType,
      this.date,
      this.intimacyActivity,
      this.partOfLifeEffect,
      this.userId,
      this.intensityScale,
      this.id,
      this.intensity});

  EventData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    activity = json['activity'];
    intimacyType =
        json['intimacyType'] != null ? json['intimacyType'].cast<String>() : [];
    toolType =
        json['intimacyTool'] != null ? json['intimacyTool'].cast<String>() : [];
    climaxType = json['intimacyOrgasm'] != null
        ? json['intimacyOrgasm'].cast<String>()
        : [];
    experience =
        json['experience'] != null ? json['experience'].cast<String>() : [];
    intimacyActivity = json['intimacyActivity'] != null
        ? json['intimacyActivity'].cast<String>()
        : [];
    if (json['bodyPartName'] != null) {
      bodyPartName = <BodyPartName>[];
      json['bodyPartName'].forEach((v) {
        bodyPartName!.add(BodyPartName.fromJson(v));
      });
    }
    feeling = json['feeling'].cast<String>();
    if (json['exerciseType'] != null) {
      exerciseType = <ExerciseType>[];
      json['exerciseType'].forEach((v) {
        exerciseType!.add(ExerciseType.fromJson(v));
      });
    }
    timeOfDay = json['timeOfDay'];
    date = json['date'];
    if (json['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffect>[];
      json['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffect.fromJson(v));
      });
    }
    userId = json['userId'];
    intensityScale = json['intensityScale'];
    id = json['id'];
    intensity = json['intensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['activity'] = activity;
    data['intimacyTool'] = toolType;
    data['intimacyType'] = intimacyType;
    data['intimacyOrgasm'] = climaxType;
    data['experience'] = experience;
    data['intimacyActivity'] = intimacyActivity;
    if (bodyPartName != null) {
      data['bodyPartName'] = bodyPartName!.map((v) => v.toJson()).toList();
    }
    data['feeling'] = feeling;
    if (exerciseType != null) {
      data['exerciseType'] = exerciseType!.map((v) => v.toJson()).toList();
    }
    data['timeOfDay'] = timeOfDay;
    data['date'] = date;
    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] =
          partOfLifeEffect!.map((v) => v.toJson()).toList();
    }
    data['userId'] = userId;
    data['intensityScale'] = intensityScale;
    data['id'] = id;
    data['intensity'] = intensity;
    return data;
  }
}

class BodyPartName {
  String? category;
  String? bodySide;
  String? bodyPart;

  BodyPartName({this.category, this.bodySide, this.bodyPart});

  BodyPartName.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    bodySide = json['bodySide'];
    bodyPart = json['bodyPart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['bodySide'] = bodySide;
    data['bodyPart'] = bodyPart;
    return data;
  }
}

class Answers {
  String? question;
  String? date;
  String? userId;
  String? timeOfDay;
  String? id;
  List<String>? answer;
  String? type;
  int? intensityScale;
  int? intensity;
  int? effectiveScale;
  int? enjoyment;
  int? unit;

  Answers(
      {this.question,
      this.date,
      this.userId,
      this.timeOfDay,
      this.id,
      this.answer,
      this.type,
      this.intensity,
      this.intensityScale,
      this.effectiveScale,
      this.enjoyment,
      this.unit});

  Answers.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    date = json['date'];
    userId = json['userId'];
    timeOfDay = json['timeOfDay'];
    id = json['id'];
    answer = json['answer'] != null ? List<String>.from(json['answer']) : null;
    type = json['type'];
    intensity = json['intensity'] is int ? json['intensity'] : null;
    intensityScale = json["intensityScale"];
    effectiveScale = json["effectiveScale"];
    unit = json["unit"];
    enjoyment = json["enjoyment"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['date'] = date;
    data['userId'] = userId;
    data['timeOfDay'] = timeOfDay;
    data['id'] = id;
    data['answer'] = answer;
    data['type'] = type;
    data["intensity"] = intensity;
    data["intensityScale"] = intensityScale;
    data["effectiveScale"] = effectiveScale;
    data["unit"] = unit;
    data["enjoyment"] = enjoyment;
    return data;
  }
}
