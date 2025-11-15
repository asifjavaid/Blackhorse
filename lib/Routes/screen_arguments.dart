import 'package:ekvi/Models/Authentication/create_signicat_session_model.dart';
import 'package:ekvi/Models/DailyTracker/Movement/user_movements_model.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/user_pain_killer_model.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/user_pain_relief_model.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/user_selfcare_model.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:flutter/material.dart';

class ScreenArguments {
  final CreateSignicatEkviSessionResponse? webviewData;
  final String? signicatAccessToken;
  void Function(String)? notesCallback;
  final String? notes;
  final bool? isSideNavRoute;
  final String? eventTimeOfDay;
  final bool? dailyTrackerPushedAsNamedRoute;
  final bool? feedbackOpenedFromBottomnav;
  final bool? cycleHistoryOpenedFromBottomnav;
  final bool? cycleTrackingShouldPop;
  final String? medicationReminderId;
  final String? symptom;
  ArticleContent? article;
  final UserPainKillerResponseModel? painkiller;
  final UserMovementsResponseModel? movementPractice;
  final UserSelfCareResponseModel? selfcarePractice;
  final UserPainReliefResponseModel? painReliefPractice;
  final String? moduleId;
  final String? courseId;
  final bool isCurrentLessonFlow;
  final bool isStartCourseJourney;
  final bool isContinueCourseJourney;
  final String? lessonId;
  final String? lessonType;
  final String? categoryTitle;
  final LessonStructure? lesson;
  final VoidCallback? navigationCallback;

  ScreenArguments({
    this.webviewData,
    this.signicatAccessToken,
    this.notesCallback,
    this.notes,
    this.isSideNavRoute,
    this.eventTimeOfDay,
    this.dailyTrackerPushedAsNamedRoute,
    this.feedbackOpenedFromBottomnav,
    this.cycleTrackingShouldPop,
    this.cycleHistoryOpenedFromBottomnav,
    this.medicationReminderId,
    this.symptom,
    this.article,
    this.painkiller,
    this.movementPractice,
    this.selfcarePractice,
    this.painReliefPractice,
    this.moduleId,
    this.courseId,
    this.isCurrentLessonFlow = false,
    this.isStartCourseJourney = false,
    this.isContinueCourseJourney = false,
    this.lessonId,
    this.lessonType,
    this.categoryTitle,
    this.lesson,
    this.navigationCallback,
  });
}
