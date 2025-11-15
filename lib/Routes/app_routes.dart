import 'package:ekvi/Components/Insights/MultiSymptomChart/multi_symptoms_chart.dart';
import 'package:ekvi/Components/Insights/MultiSymptomChart/multi_symptoms_selection.dart';
import 'package:ekvi/Screens/ContraceptionReminders/contraceptive_implant.dart';
import 'package:ekvi/Screens/ContraceptionReminders/contraceptive_injection_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/contraceptive_patch_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/iud_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/oral_contraception_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/vaginal_ring_reminder.dart';
import 'package:ekvi/Screens/CycleCalendar/cycle_calendar_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Movement/movement_practices_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Pain-Relief/add_pain_relief_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/PainKillers/your_pills_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/ekvi_journeys_module_completion_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/YourWellBeing/your_well_being_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaEvents/ekvipedia_events_list_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaSavedLessonsByType/ekvipedia_saved_lessons_by_type_screen.dart';
import 'package:ekvi/Screens/Splash/splash_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/daily_tracker_category.dart';
import 'package:ekvi/Screens/DeleteAccount/delete_account.dart';
import 'package:ekvi/Screens/EditProfile/edit_profile.dart';
import 'package:ekvi/Screens/EditProfile/edit_profile_settings.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaNewsEkvi/ekvipedia_news_ekvi_list_screen.dart';
import 'package:ekvi/Screens/FAQs/faqs.dart';
import 'package:ekvi/Screens/Insights/insights_screen.dart';
import 'package:ekvi/Screens/Intercom/intercom.dart';
import 'package:ekvi/Screens/Login/login_landing_screen.dart';
import 'package:ekvi/Screens/LoginWithBankId/login_bank_id.dart';
import 'package:ekvi/Screens/Onboarding/onboarding_screen.dart';
import 'package:ekvi/Screens/Register/register_landing_screen.dart';
import 'package:ekvi/Screens/Register/register_with_apple.dart';
import 'package:ekvi/Screens/Register/register_with_google.dart';
import 'package:ekvi/Screens/Reminders/contraception_menu.dart';
import 'package:ekvi/Screens/Reminders/reminders.dart';
import 'package:ekvi/Screens/SideNavManager/side_nav_manager.dart';
import 'package:ekvi/Screens/SubscriptionPlan/subscription_plan.dart';
import 'package:ekvi/Screens/Welcome/welcome_screen.dart';
import 'package:ekvi/Screens/WellnessWeekly/create_wellness_weekly_journal/create_wellness_weekly_journal.dart';
import 'package:ekvi/Screens/WellnessWeekly/wellness_weekly_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initial = "/";
  static const String welcomeRoute = "/welcomeRoute";
  static const String registerRoute = "/registerUp";
  static const String registerWithBankID = "/registerWithBankID";
  static const String registerWithGoogle = "/registerWithGoogle";
  static const String registerWithApple = "/registerWithApple";
  static const String loginRoute = "/login";
  static const String onboarding = "/onboarding";
  static const String dashboard = "/dashboard";
  static const String hormoneCheatSheet = "/hormoneCheatSheet";
  static const String cyclePredictionAndEditing = "/cyclePredictionAndEditing";
  static const String supportAndFeedBack = "/supportAndFeedBack";
  static const String cycle = "/cycle";
  static const String sideNavManager = "/sideNavManager";
  static const String categoryEdit = "/categoryEdit";
  static const String painEventEdit = "/painEventEdit";
  static const String bodyPain = "/bodyPain";
  static const String cycleHistory = "/cycleHistory";
  static const String symptomsAnalytics = "/symptomsAnalytics";
  static const String editProfile = "/editProfile";
  static const String editProfileSettings = "/editProfileSettings";
  static const String selectAvatar = "/selectAvatar";
  static const String reminders = "/reminders";
  static const String medicationReminder = "/medicationReminder";
  static const String contraceptionMenu = "/contraceptionMenu";
  static const String oralContraceptionReminder = "/oralContraceptionReminder";
  static const String vaginalRingReminder = "/vaginalRingReminder";
  static const String contraceptivePatchReminder = "/contraceptivePatchReminder";
  static const String contraceptiveInjectionReminder = "/contracepticeInjectionReminder";
  static const String iudReminder = "/iudReminder";
  static const String contraceptiveImplantReminder = "/contraceptiveImplantReminder";
  static const String signicatWebView = "/signicatWebView";
  static const String notesRoute = "/notesRoute";
  static const String loginWithBankId = "/loginWithBankId";
  static const String backDoorLogin = "/backDoorLogin";
  static const String cycleTracking = "/cycleTracking";
  static const String faqs = "/faqs";
  static const String deleteAccount = "/deleteAccount";
  static const String multisymptomschart = "/multisymptomschart";
  static const String multisymptomselection = "/multisymptomselection";
  static const String ekvipediaArticle = "/ekvipediaArticle";
  static const String ekvipediaEvents = "/ekvipediaEvents";
  static const String ekvipediaAllEvents = "/ekvipediaAllEvents";
  static const String newsFromEkvi = "/newsFromEkvi";
  static const String ekvipediaTopics = "/ekvipediaTopics";
  static const String subscribe = "/subscribe";
  static const String subscriptionWelcome = "/subscriptionWelcome";
  static const String subscriptionPlan = "/subscriptionPlan";
  static const String ekvipediaArticleReferences = "/ekvipediaArticleReferences";
  static const String ekviJourneysLessonReferences = "/ekviJourneysLessonReferences";
  static const String painKillerAddScreen = "/painKillerAddScreen";
  static const String painKillerEditScreen = "/painKillerEditScreen";
  static const String allPainKillersVault = "/allPainKillersVault";

  // Movement Practices
  static const String addMovementPracticeScreen = "/addMovementPracticesScreen";
  static const String updateMovementPracticeScreen = "/updateMovementPracticesScreen";
  static const String movementPracticesScreen = "/movementPracticesScreen";

  // Selfcare Practices
  static const String addSelfCarePracticesScreen = "/addSelfCarePracticesScreen";
  static const String updateSelfCarePracticesScreen = "/updateSelfCarePracticesScreen";
  static const String yourWellBeingScreen = "/yourWellBeingScreen";

  //Pain Relief
  static const String addPainReliefPracticesScreen = "/addPainReliefPracticesScreen";
  static const String updatePainReliefPracticesScreen = "/updatePainReliefPracticesScreen";
  //ekvi-journey
  static const String ekviJourneysCourse = "/ekviJourneysCourse";
  static const String ekviJourneysLesson = "/ekviJourneysLesson";
  static const String ekviJouneysAudioLesson = "/ekviJourneysAudioLesson";
  static const String ekviJourneysVedioLesson = "/ekviJourneysVedioLesson";
  static const String ekviJourneysModuleCompletion = "/ekviJourneysModuleCompletion";
  static const String ekvipediaSavedLessonsByType = "/ekvipediaSavedLessonsByType";

  //Wellness Weekly
  static const String wellnessWeeklyScreen = "/wellnessWeeklyScreen";
  static const String createWellnessWeeklyJournal = "/createWellnessWeeklyJournal";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.initial: (context) => const SplashScreen(),
      AppRoutes.welcomeRoute: (context) => const WelcomeScreen(),
      AppRoutes.registerRoute: (context) => const RegisterLandingScreen(),
      AppRoutes.registerWithGoogle: (context) => const RegisterWithGoogle(),
      AppRoutes.registerWithApple: (context) => const RegisterWithApple(),
      AppRoutes.loginWithBankId: (context) => const LoginWithBankId(),
      AppRoutes.editProfile: (context) => const EditProfileScreen(),
      AppRoutes.editProfileSettings: (context) => const EditProfileSettings(),
      AppRoutes.cyclePredictionAndEditing: (context) => const CycleCalendarScreen(),
      AppRoutes.supportAndFeedBack: (context) => const IntercomScreen(),
      AppRoutes.loginRoute: (context) => const LoginLandingScreen(),
      AppRoutes.cycleHistory: (context) => const InsightsScreen(),
      AppRoutes.onboarding: (context) => const OnboardingScreen(),
      AppRoutes.newsFromEkvi: (context) => const EkviNewsList(),
      AppRoutes.reminders: (context) => const Reminders(),
      AppRoutes.ekvipediaAllEvents: (context) => const EkviEventsListScreen(),
      AppRoutes.sideNavManager: (context) => const SideNavManager(),
      AppRoutes.categoryEdit: (context) => const DailyTrackerCategory(),
      AppRoutes.contraceptionMenu: (context) => const ContraceptionMenu(),
      AppRoutes.oralContraceptionReminder: (context) => const OralContraceptionReminder(),
      AppRoutes.vaginalRingReminder: (context) => const VaginalRingReminder(),
      AppRoutes.contraceptivePatchReminder: (context) => const ContraceptivePatchReminder(),
      AppRoutes.contraceptiveInjectionReminder: (context) => const ContraceptiveInjectionReminder(),
      AppRoutes.iudReminder: (context) => const IUDReminder(),
      AppRoutes.contraceptiveImplantReminder: (context) => const ContraceptiveImplantReminder(),
      AppRoutes.faqs: (context) => const FAQScreen(),
      AppRoutes.deleteAccount: (context) => const DeleteAccountScreen(),
      AppRoutes.multisymptomschart: (context) => const MultiSymptomsChart(),
      AppRoutes.multisymptomselection: (context) => const MultiSymptomsSelection(),
      AppRoutes.subscriptionPlan: (context) => const SubscriptionPlan(),
      AppRoutes.allPainKillersVault: (context) => const YourPillsScreen(),
      AppRoutes.movementPracticesScreen: (context) => const MovementPracticesScreen(),
      AppRoutes.yourWellBeingScreen: (context) => const YourWellBeingScreen(),
      AppRoutes.ekviJourneysModuleCompletion: (context) => const EkviJourneysModuleCompletionScreen(),
      AppRoutes.addPainReliefPracticesScreen: (context) => const AddPainReliefScreen(),
      AppRoutes.ekvipediaSavedLessonsByType: (context) => const EkvipediaSavedLessonsByTypeScreen(),
      AppRoutes.wellnessWeeklyScreen: (context) => const WellnessWeeklyScreen(),
      AppRoutes.createWellnessWeeklyJournal: (context) => const CreateWellnessWeeklyJournal(),
    };
  }
}
