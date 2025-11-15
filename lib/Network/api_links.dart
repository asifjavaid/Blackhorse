class ApiLinks {
  // User
  static const String createUser = "/user";
  static const String updateUser = "/user";
  static const String getUser = "/user";
  static const String uploadPic = "/user/upload";
  static const String createSignicatEkviToken = "/session/tokexn";
  static const String createSignicatEkviSession = "/session";
  static const String loginEkviUser = "/session/sessionID/login";
  static const String createOtp = "/otp/create?email=";
  static const String verifyOtp = "/otp/verify?email=";
  static const String storeFCMToken = "/notification/token";
  static const String googleAuthentication = "/google-authentication";
  static const String appleAuthentication = "/apple-authentication";
  static const String termsAndConditions = "https://en.ekvi.io/terms/";
  static const String deleteUserProfile = "/user/userIdPlaceholder/profile";

  // Onboarding
  static const String getUserProgress =
      "/onboarding/user-progress/userIdPlaceholder";
  static const String saveUserAnswer =
      "/onboarding/user-answer/userIdPlaceholder";
  static const String goBackToPreviousAnswer =
      "/onboarding/user-progress/userIdPlaceholder/order";
  static const String syncUserCycleInformation = "/period-cycle";

  // Dashboard
  static const String getMyDay = "/my-day";
  static const String getMyDayInsights = "/my-day/userIdPlaceholder/insights";
  static const String getMyDaySymptomExpectations =
      "/my-day/userIdPlaceholder/symptom-trackers";
  static const String getMyDayHormonalCalendar =
      "/my-day/userIdPlaceholder/hormonal-calendar";
  static const String getMyDayTipsAndNews = "/my-day/userIdPlaceholder/news";
  static const String getMyDayHormoneCheatSheet =
      "/my-day/userIdPlaceholder/hormones";
  static String getFeatureAlert(String userId) => "/alert-feature/$userId/user";

  // Daily Symptom Tracker

  // Save answers
  static const String dailyTracker = "/daily-tracker";
  static const String bleedingCategory =
      "/answers/userIdPlaceholder/type/Bleeding";
  static const String harmonesCategory =
      "/answers/userIdPlaceholder/type/Hormones";
  static const String emotionsCategory =
      "/answers/userIdPlaceholder/type/Emotions";
  static const String alcoholCategory =
      "/answers/userIdPlaceholder/type/Alcohol";
  static const String ovulationTestCategory =
      "/answers/userIdPlaceholder/type/OvulationTest";
  static const String pregnancyTestCategory =
      "/answers/userIdPlaceholder/type/PregnancyTest";
  static const String sexCategory = "/answers/userIdPlaceholder/type/Sex";
  static const String saveAlcohol = "/alcohol";
  static const String trackPainKiller = "/painKiller/track";
  static const String createPainkiller = "/painKiller";
  static String getPainkillers(String userId) => "/painKiller/user/$userId";
  static String getIngredients(String userId) =>
      "/painKiller/ingredients/user/$userId";
  static String updatePainkiller(String id) => "/painKiller/$id";
  static const String deletePainkiller = "/painkiller";
  static const String deletePainkillerTrackingRecord = "/painkiller/track";
  static String getUserPainkillerIngredients(String userId) =>
      '/painkiller/user/$userId/ingredient';
// Movements
  static const String createNewPractice = "/movement/practice";
  static String getMovementPractices(String id) =>
      "/movement/practice/user/$id";
  static String updateMovementPractice(String id) => "/movement/practice/$id";
  static const String deleteMovementPractice = "/movement/practice";
  static const String movementLog = "/movement/log";
  static const String deleteMovementTrackingRecord = "/movement/log";

  // Self Care
  static const String selfcareLog = "/self-care/log";
  static String getSelfcareTrackingData(
          String userId, String date, String timeOfDay) =>
      "/self-care/log/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static const String createSelfCarePractice = "/self-care/practice";
  static String getSelfCarePractices(String id) =>
      "/self-care/practice/user/$id";
  static String updateSelfCarePractice(String id) => "/self-care/practice/$id";
  static const String deleteSelfCarePractice = "/self-care/practice";
  static const String deleteSelfCareTrackingRecord = "/self-care/log";

  static const String saveBleeding = "/bleeding";
  static const String saveOvulationTest = "/ovulation-test";
  static const String savePregnancyTest = "/pregnancy-test";
  static const String saveHormones = "/hormones";
  static const String saveIntimacy = "/intimacy";
  static const String saveMood = "/mood";
  static const String saveEnergy = "/energy";
  static const String saveStress = "/stress";
  static const String saveNausea = "/nausea";
  static const String saveFatigue = "/fatigue";
  static const String saveBowelMovement = "/bowel-movement";
  static const String saveBloating = "/bloating";
  static const String saveBrainFog = "/brain-fog";
  static const String deleteAlcohol = "/alcohol";
  static const String deleteHormones = "/hormones";
  static const String deleteStress = "/stress";
  static const String deleteEnergy = "/energy";
  static const String deleteMood = "/mood";
  static const String deleteNausea = "/nausea";
  static const String deleteFatigue = "/fatigue";
  static const String deleteBowelMovement = "/bowel-movement";
  static const String deleteBloating = "/bloating";
  static const String deleteBleeding = "/bleeding";
  static const String deleteBrainFog = "/brain-fog";
  static const String deleteIntimacy = "/intimacy";
  static const String deleteOvulationTest = "/ovulation-test";
  static const String deletePregnancyTest = "/pregnancy-test";
  static String deleteBleedingAtDates(String userId) =>
      "/bleeding/$userId/dates";

  // Pain Relief
  static const painReliefLog = "/pain-relief/log";
  static String getPainReliefTrackingData(
          String userId, String date, String timeOfDay) =>
      "/pain-relief/log/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static const createPainReliefPractice = "/pain-relief/practice";
  static String getPainReliefPractices(String id) =>
      "/pain-relief/practice/user/$id";
  static String updatePainReliefPractice(String id) =>
      "/pain-relief/practice/$id";
  static const String deletePainReliefPractice = "/pain-relief/practice";
  static const String deletePainReliefTrackingRecord = "/pain-relief/log";

  // Get answers
  static const String getBleedingCategory =
      "/bleeding/userIdPlaceholder/user/datePlaceholder/date/timeOfDayPlaceHolder/timeOfDay";
  static const String getHormonesCategory =
      "/answers/userIdPlaceholder/date/datePlaceholder/timeOfDay/timeOfDayPlaceHolder/type/Hormones";
  static const String getEmotionsCategory =
      "/answers/userIdPlaceholder/date/datePlaceholder/timeOfDay/timeOfDayPlaceHolder/type/Emotions";
  static const String getAlcoholCategory =
      "/answers/userIdPlaceholder/date/datePlaceholder/timeOfDay/timeOfDayPlaceHolder/type/Alcohol";
  static const String getOvulationTestCategory =
      "/answers/userIdPlaceholder/date/datePlaceholder/timeOfDay/timeOfDayPlaceHolder/type/OvulationTest";
  static const String getPregnancyTestCategory =
      "/answers/userIdPlaceholder/date/datePlaceholder/timeOfDay/timeOfDayPlaceHolder/type/PregnancyTest";
  static const String getSexCategory =
      "/answers/userIdPlaceholder/date/datePlaceholder/timeOfDay/timeOfDayPlaceHolder/type/Sex";

  static const String painKillersCategory =
      "/medicine/userIdPlaceholder/date/datePlaceholder";
  static const String getPainKillerDetail =
      "/medicine/userIdPlaceholder/date/datePlaceholder/name/";
  static const String savePainKillerData = "/medicine/userIdPlaceholder";
  static const String bodyPainEvent =
      "/events/userIdPlaceholder/date/datePlaceholder/timeOfDay/timeOfDayPlaceHolder/type";
  static const String patchBodyPainEvent = "/pain";
  static const String dailyTrackerNotes = "/note";
  static const String updateDailyTrackerNotes = "/note/id";
  static const String getAllBodyPartsByDate =
      "/events/userIdPlaceholder/date/datePlaceholder/bodyparts";
  static const String getAllCompletedCategoriesByDate =
      "/events/v1/userIdPlaceholder/date/datePlaceholder";
  static const String getAllTrackedSymptomEventsForCalendars =
      "/events/userIdPlaceholder/startDate/startDatePlaceholder/endDate/endDatePlaceholder";
  static String getSymptomFeedback(String userId, String symptom) =>
      "/symptom-feedback/$userId/user/$symptom/symptom";
  static String updateSymptomFeedback(String id) => "/symptom-feedback/$id";
  static String getAlcoholData(String userId, String date, String timeOfDay) =>
      "/alcohol/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getHormonesData(String userId, String date, String timeOfDay) =>
      "/hormones/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getIntimacyData(String userId, String date, String timeOfDay) =>
      "/intimacy/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getOvulationTestData(
          String userId, String date, String timeOfDay) =>
      "/ovulation-test/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getMoodData(String userId, String date, String timeOfDay) =>
      "/mood/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getStressData(String userId, String date, String timeOfDay) =>
      "/stress/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getEnergyData(String userId, String date, String timeOfDay) =>
      "/energy/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getNauseaData(String userId, String date, String timeOfDay) =>
      "/nausea/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getFatigueData(String userId, String date, String timeOfDay) =>
      "/fatigue/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getBloatingData(String userId, String date, String timeOfDay) =>
      "/bloating/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getBrainFogData(String userId, String date, String timeOfDay) =>
      "/brain-fog/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getPregnancyTestData(
          String userId, String date, String timeOfDay) =>
      "/pregnancy-test/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getBowelMoveData(
          String userId, String date, String timeOfDay) =>
      "/bowel-movement/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getPainKillerData(
          String userId, String date, String timeOfDay) =>
      "/painkiller/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static String getMovementTrackingData(
          String userId, String date, String timeOfDay) =>
      "/movement/log/$userId/user/$date/date/$timeOfDay/timeOfDay";

  // Headache
  static const String saveHeadache = "/headache";
  static String getHeadacheData(String userId, String date, String timeOfDay) =>
      "/headache/$userId/user/$date/date/$timeOfDay/timeOfDay";
  static const String deleteHeadache = "/headache";
  static String getHeadacheFeedback(String userId) =>
      "/symptom-feedback/$userId/user/headache/symptom";
  static String updateHeadacheFeedback(String id) => "/symptom-feedback/$id";

  // Reminders and Notifications
  static const String createMedicineReminder = "/medication";
  static const String createContraceptionReminder = "/contraception";
  static const String createPeriodReminder = "/period";
  static const String getAllContraceptionReminders =
      "/contraception/userIdPlaceholder/user";
  static const String getAllMedicinesReminders =
      "/medication/userIdPlaceholder/user";
  static const String getAllPeriodReminders = "/period/userIdPlaceholder/user";
  static const String getPeriodReminder = "/period/id";
  static const String getContraceptionReminder = "/contraception/id";
  static const String getMedicationReminder = "/medication/id";
  static const String updateMedicationReminder = "/medication/id";

  // Cycle
  static const String saveCycleTrackingSettings = "/period-cycle";
  static const String getCalendarData = "/calender/user/userIdPlaceholder";

  // Insights
  static const String getInsights = "/insight/v1";

  //Journeys
  static const String syncContentful = "/ekvi-journeys/sync-contentful";
  static String journeysList(String userId) =>
      "/ekvi-journeys/users/$userId/courses";
  static String latestJourneys(String userId) =>
      "/ekvi-journeys/users/$userId/courses/latest-journeys";
  static String expandHorizon(String userId) =>
      "/ekvi-journeys/users/$userId/courses/expand-horizon";
  static String recentlyAccessed(String userId, {int limit = 3}) =>
      "/ekvi-journeys/users/$userId/courses/recently-accessed?limit=$limit";
  static String courseStructure(String userId, String courseId,
          {bool isPremium = false}) =>
      "/ekvi-journeys/users/$userId/courses/$courseId/structure?isPremium=$isPremium";
  static String getLesson(String userId, String moduleId, {bool? sequential}) {
    final queryParam = sequential != null ? "?sequential=$sequential" : "";
    return "/ekvi-journeys/users/$userId/modules/$moduleId/lesson$queryParam";
  }

  static String lessonProgress(String userId) =>
      "/ekvi-journeys/users/$userId/progress/lesson";
  static String getCurrentCourseLesson(String userId) =>
      "/ekvi-journeys/users/$userId/current-course/lesson";
  static String nextLesson(
      String userId, String moduleId, int currentLessonOrder,
      {bool? sequential}) {
    final baseUrl =
        "/ekvi-journeys/users/$userId/modules/$moduleId/lesson/next?currentLessonOrder=$currentLessonOrder";
    final sequentialParam = sequential != null ? "&sequential=$sequential" : "";
    return "$baseUrl$sequentialParam";
  }

  static String previousLesson(String userId, String moduleId,
      {int? currentLessonOrder, bool? sequential}) {
    final baseUrl =
        "/ekvi-journeys/users/$userId/modules/$moduleId/lesson/previous";
    final lessonOrderParam = currentLessonOrder != null
        ? "?currentLessonOrder=$currentLessonOrder"
        : "?";
    final sequentialParam = sequential != null ? "&sequential=$sequential" : "";
    return "$baseUrl$lessonOrderParam$sequentialParam";
  }

  static String saveLesson(String userId, String lessonId) =>
      "/ekvi-journeys/users/$userId/lessons/$lessonId/save";
  static String unSaveLesson(String userId, String lessonId) =>
      "/ekvi-journeys/users/$userId/lessons/$lessonId/un-save";

  static String getSavedLessons(String userId) =>
      "/ekvi-journeys/users/$userId/saved-lessons";
  static String getLessonStructurebyId(String userId, String lessonId) =>
      "/ekvi-journeys/users/$userId/lessons/$lessonId/structure";

  // Course Journey Navigation
  static String startCourseJourney(String userId, String courseId) =>
      "/ekvi-journeys/users/$userId/courses/$courseId/start";
  static String continueCourseJourney(String userId, String courseId) =>
      "/ekvi-journeys/users/$userId/courses/$courseId/continue";
}
