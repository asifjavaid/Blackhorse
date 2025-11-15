import 'package:ekvi/Models/Amplitude/amplitude_event.dart';
import 'package:ekvi/Models/DailyTracker/Alcohol/alcohol_model.dart';
import 'package:ekvi/Models/DailyTracker/Bloating/bloating_model.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_model.dart';
import 'package:ekvi/Models/DailyTracker/BrainFog/brain_fog_model.dart';
import 'package:ekvi/Models/DailyTracker/Headache/headache_model.dart';
import 'package:ekvi/Models/DailyTracker/Energy/energy_model.dart';
import 'package:ekvi/Models/DailyTracker/Fatigue/fatigue_model.dart';
import 'package:ekvi/Models/DailyTracker/Hormones/hormones_model.dart';
import 'package:ekvi/Models/DailyTracker/Intimacy/intimacy_model.dart';
import 'package:ekvi/Models/DailyTracker/Mood/mood_model.dart';
import 'package:ekvi/Models/DailyTracker/Nausea/nausea_model.dart';
import 'package:ekvi/Models/DailyTracker/OvulationTest/ovulation_test_model.dart';
import 'package:ekvi/Models/DailyTracker/PregnancyTest/pregnancy_test_model.dart';
import 'package:ekvi/Models/DailyTracker/Stress/stress_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class DailyTrackerAccessedEvent extends BaseEvent {
  final String accessMethod;
  final DateTime dateAccessed;
  final String userSegment;

  DailyTrackerAccessedEvent({
    required this.accessMethod,
    required this.dateAccessed,
    required this.userSegment,
  });

  @override
  String get eventName => 'DailyTrackerAccessed';
  @override
  String get description => 'User accesses Daily Tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'accessMethod': accessMethod,
        'dateAccessed': dateAccessed.toIso8601String(),
        'userSegment': userSegment,
      };
}

class SymptomTrackingStarted extends BaseEvent {
  final String symptomCategory;
  final DateTime startTime;
  final String userId;

  SymptomTrackingStarted({
    required this.symptomCategory,
    required this.startTime,
    required this.userId,
  });

  @override
  String get eventName => 'SymptomTrackingStarted';

  @override
  String get description => 'User starts tracking a symptom';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': symptomCategory,
        'startTime': startTime.toIso8601String(),
        'userId': userId,
      };
}

class AmplitudeBleedingDetails extends BaseEvent {
  final DailyTrackerAnswers data;

  AmplitudeBleedingDetails({
    required this.data,
  });

  @override
  String get eventName => 'BleedingDetails';

  @override
  String get description => 'User attempted to save bleeding details';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Bleeding",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "Intensity": data.answer?[0]
      };
}

class AmplitudeHormoneDetails extends BaseEvent {
  final HormonesResponseModel data;

  AmplitudeHormoneDetails({
    required this.data,
  });

  @override
  String get eventName => 'HormoneDetails';

  @override
  String get description => 'User attempted to save hormone details';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Hormones",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "hormones": data.answer
      };
}

class AmplitudeAlcoholDetails extends BaseEvent {
  final AlcoholResponseModel data;

  AmplitudeAlcoholDetails({
    required this.data,
  });

  @override
  String get eventName => 'AlcoholDetails';

  @override
  String get description => 'User attempted to save alcohol details';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Alcohol",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "Alcohol": data.answer
      };
}

class AmplitudeIntimacyDetails extends BaseEvent {
  final IntimacyResponseModel data;

  AmplitudeIntimacyDetails({
    required this.data,
  });

  @override
  String get eventName => 'IntimacyDetails';

  @override
  String get description => 'User attempted to save intimacy details';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Intimacy",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "intimacy": data.answer,
        "activity": data.activity
      };
}

class AmplitudePregnancyDetails extends BaseEvent {
  final PregnancyTestResponseModel data;

  AmplitudePregnancyDetails({
    required this.data,
  });

  @override
  String get eventName => 'PregnancyDetails';

  @override
  String get description => 'User attempted to save pregnancy details';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Pregnancy Test",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "pregnancy": data.answer
      };
}

class AmplitudeOvulationTestDetails extends BaseEvent {
  final OvulationTestResponseModel data;

  AmplitudeOvulationTestDetails({
    required this.data,
  });

  @override
  String get eventName => 'OvulationTestDetails';

  @override
  String get description => 'User attempted to save ovulation test details';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Ovulation Test",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "ovulationTest": data.answer
      };
}

class AmplitudeMoodDetails extends BaseEvent {
  final MoodResponseModel data;

  AmplitudeMoodDetails({
    required this.data,
  });

  @override
  String get eventName => 'MoodDetails';

  @override
  String get description =>
      'User attempted to save mood details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Mood",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "instensity": data.intensityScale,
        "moods": data.answer,
        "notes": data.note
      };
}

class AmplitudeStressDetails extends BaseEvent {
  final StressResponseModel data;

  AmplitudeStressDetails({
    required this.data,
  });

  @override
  String get eventName => 'StressDetails';

  @override
  String get description =>
      'User attempted to save stress details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Stress",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "stress": data.answer,
        "notes": data.note
      };
}

class AmplitudeEnergyDetails extends BaseEvent {
  final EnergyResponseModel data;

  AmplitudeEnergyDetails({
    required this.data,
  });

  @override
  String get eventName => 'EnergyDetails';

  @override
  String get description =>
      'User attempted to save energy details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Energy",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "energy": data.answer,
        "notes": data.note
      };
}

class AmplitudeNauseaDetails extends BaseEvent {
  final NauseaResponseModel data;

  AmplitudeNauseaDetails({
    required this.data,
  });

  @override
  String get eventName => 'NauseaDetails';

  @override
  String get description =>
      'User attempted to save nausea details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Nausea",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "instensity": data.intensityScale,
        "nausea": data.answer,
        "duration": data.duration,
        "notes": data.note
      };
}

class AmplitudeFatigueDetails extends BaseEvent {
  final FatigueResponseModel data;

  AmplitudeFatigueDetails({
    required this.data,
  });

  @override
  String get eventName => 'FatigueDetails';

  @override
  String get description =>
      'User attempted to save fatigue details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Fatigue",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "instensity": data.intensityScale,
        "duration": data.duration,
        "nausea": data.answer,
        "notes": data.note
      };
}

class AmplitudeBowelMovementDetails extends BaseEvent {
  final BowelMovResponseModel data;
  final String userId;

  AmplitudeBowelMovementDetails({required this.data, required this.userId});

  @override
  String get eventName => 'BowelMovementDetails';

  @override
  String get description =>
      'User attempted to save Bowel Movement details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Bowel Movement",
        'timeOfday': data.timeOfDay,
        'userId': userId,
        "stoolConsistency": data.stoolConsistency,
        "stoolFrequency": data.stoolFrequency,
        "stoolColour": data.stoolColour,
        "stoolSize": data.stoolSize,
        "stoolEffort": data.stoolEffort,
        "stoolComponents": data.stoolComponents,
        "stoolDuration": data.stoolDuration,
        "stoolNotes": data.stoolNotes
      };
}

class AmplitudeBloatingDetails extends BaseEvent {
  final BloatingResponseModel data;

  AmplitudeBloatingDetails({
    required this.data,
  });

  @override
  String get eventName => 'BloatingDetails';

  @override
  String get description =>
      'User attempted to save bloating details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Bloating",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "instensity": data.intensityScale,
        "duration": data.duration,
        "nausea": data.answer,
        "notes": data.note
      };
}

class AmplitudeBrainFogDetails extends BaseEvent {
  final BrainFogResponseModel data;

  AmplitudeBrainFogDetails({
    required this.data,
  });

  @override
  String get eventName => 'BrainFogDetails';

  @override
  String get description =>
      'User attempted to save brain fog details in daily tracker';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Brain Fog",
        'timeOfday': data.timeOfDay,
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
        "instensity": data.intensityScale,
        "duration": data.duration,
        "nausea": data.answer,
        "notes": data.note
      };
}

// Body Pain

class AmplitudeBodyPartsSelection extends BaseEvent {
  List<BodyPart> bodyParts;

  AmplitudeBodyPartsSelection({required this.bodyParts});

  @override
  String get eventName => 'BodyPartsSelection';

  @override
  String get description => 'User selected body parts to save pain';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': "Pain",
        'selectedBodyParts':
            bodyParts.map((bodyPart) => bodyPart.nameForUser).toList(),
        'bodyArea': bodyParts[0].category1!,
        "bodySide": bodyParts[0].bodySide == BodySide.Front ? "Front" : "Back",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainActivity extends BaseEvent {
  String activity;
  List<BodyPart> bodyParts;

  AmplitudeBodyPainActivity({required this.activity, required this.bodyParts});

  @override
  String get eventName => 'BodyPainActivitySelected';

  @override
  String get description => 'User selected activity after selecting body parts';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "activity": activity,
        'symptomCategory': "Pain",
        'selectedBodyParts':
            bodyParts.map((bodyPart) => bodyPart.nameForUser).toList(),
        'bodyArea': bodyParts[0].category1!,
        "bodySide": bodyParts[0].bodySide == BodySide.Front ? "Front" : "Back",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainExistingDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainExistingDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainExistingDetails';

  @override
  String get description =>
      'User saved existing event details after selecting body parts';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.activity,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainEatingDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainEatingDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainEatingDetails';

  @override
  String get description =>
      'User saved eating details after selecting body parts and choosing activity';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.name,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "experience": eventData.experience,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainToiletDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainToiletDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainToiletDetails';

  @override
  String get description =>
      'User saved toilet details after selecting body parts and choosing activity';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.name,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "experience": eventData.experience,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainTravelDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainTravelDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainTravelDetails';

  @override
  String get description =>
      'User saved travel details after selecting body parts and choosing activity';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.name,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "experience": eventData.experience,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainExerciseDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainExerciseDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainExerciseDetails';

  @override
  String get description =>
      'User saved exercise details after selecting body parts and choosing activity';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.name,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "experience": eventData.experience,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainSleepDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainSleepDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainSleepDetails';

  @override
  String get description =>
      'User saved sleep details after selecting body parts and choosing activity';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.name,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "experience": eventData.experience,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainIntimacyDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainIntimacyDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainIntimacyDetails';

  @override
  String get description =>
      'User saved intimacy details after selecting body parts and choosing activity';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.name,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "experience": eventData.experience,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeBodyPainWorkDetails extends BaseEvent {
  DailyTrackerEvent eventData;
  AmplitudeBodyPainWorkDetails({required this.eventData});

  @override
  String get eventName => 'BodyPainWorkDetails';

  @override
  String get description =>
      'User saved travel details after selecting body parts and choosing activity';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "bodyPart": eventData.name?.map((e) => e.replaceAll("-", " ")).toList(),
        "activity": eventData.name,
        "timeOfDay": eventData.timeOfDay,
        "feelsLike": eventData.feeling,
        "experience": eventData.experience,
        "painIntensity": eventData.intensityScale,
        "impactInLife": eventData.partOfLifeEffect,
        'symptomCategory': "Pain",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

void handleEventAmplitudeDetailsLogging(
    DailyTrackerEvent eventData, PainEventsCategory eventCategory) {
  switch (eventCategory) {
    case PainEventsCategory.Existing:
      AmplitudeBodyPainExistingDetails(eventData: eventData).log();

      break;
    case PainEventsCategory.Eating:
      AmplitudeBodyPainEatingDetails(eventData: eventData).log();

      break;
    case PainEventsCategory.Toilet:
      AmplitudeBodyPainToiletDetails(eventData: eventData).log();
      break;
    case PainEventsCategory.Travel:
      AmplitudeBodyPainTravelDetails(eventData: eventData).log();
      break;
    case PainEventsCategory.Exercise:
      AmplitudeBodyPainExerciseDetails(eventData: eventData).log();
      break;
    case PainEventsCategory.Sleep:
      AmplitudeBodyPainSleepDetails(eventData: eventData).log();
      break;
    case PainEventsCategory.Intimacy:
      AmplitudeBodyPainIntimacyDetails(eventData: eventData).log();
      break;
    case PainEventsCategory.Work:
      AmplitudeBodyPainIntimacyDetails(eventData: eventData).log();
      break;

    default:
  }
}

class SymptomTrackingCompleted extends BaseEvent {
  final String symptomCategory;
  final bool completionStatus;

  SymptomTrackingCompleted({
    required this.symptomCategory,
    this.completionStatus = true,
  });

  @override
  String get eventName => 'SymptomTrackingCompleted';

  @override
  String get description => 'User completed tracking a symptom';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': symptomCategory,
        'completionStatus': completionStatus ? 'Completed' : 'Incomplete',
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmpltudeSymptomFeedback extends BaseEvent {
  final String symptomCategory;
  final bool feedback;

  AmpltudeSymptomFeedback({
    required this.symptomCategory,
    this.feedback = true,
  });

  @override
  String get eventName => 'SymptomFeedback';

  @override
  String get description => 'User submitted feedback for symptom';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptomCategory': symptomCategory,
        'feedback': feedback ? 'Positive' : 'Negative',
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}

class AmplitudeHeadacheDetails extends BaseEvent {
  HeadacheRequestModel data;
  AmplitudeHeadacheDetails({required this.data});

  @override
  String get eventName => 'HeadacheDetails';

  @override
  String get description => 'User saved headache details';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        "timeOfDay": data.timeOfDay,
        "intensityScale": data.intensityScale,
        "feltLike": data.feltLike,
        "location": data.location,
        "type": data.type,
        "onset": data.onset,
        "durationInMinutes": data.durationInMinutes,
        "impactInLife": data.partOfLifeEffect,
        'symptomCategory': "Headache",
        'userId':
            await SharedPreferencesHelper.getStringPrefValue(key: "userId"),
      };
}
