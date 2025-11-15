import 'package:ekvi/Providers/AppUpdater/app_updater_provider.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Providers/CycleTracking/cycle_tracking.dart';
import 'package:ekvi/Providers/DailyTracker/Alcohol/alcohol_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Bleeding/bleeding_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Bloating/bloating_provider.dart';
import 'package:ekvi/Providers/DailyTracker/BrainFog/brain_fog_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Energy/energy_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Fatigue/fatigue_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Headache/headache_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Hormones/hormones_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Initmacy/intimacy_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Nausea/nausea_provider.dart';
import 'package:ekvi/Providers/DailyTracker/OvulationTest/ovulation_test_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PregnancyTest/pregnancy_test_provider.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_provider.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Stress/stress_provider.dart';
import 'package:ekvi/Providers/DailyTracker/YourWellBeing/your_well_being_provider.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Providers/DeleteAccountProvider/delete_account_provider.dart';
import 'package:ekvi/Providers/EditProfile/edit_profile_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_audio_player_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_video_player_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_article_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Providers/FAQs/faqs_provider.dart';
import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Providers/Insights/insights_provider.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Providers/Insights/multi_symptoms_chart_provider.dart';
import 'package:ekvi/Providers/LocaleProvider/locale_provider.dart';
import 'package:ekvi/Providers/Login/login_provider.dart';
import 'package:ekvi/Providers/Notifications/notifications_provider.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_provider.dart';
import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Providers/Reminders/contraceptive_implant_provider.dart';
import 'package:ekvi/Providers/Reminders/contraceptive_injection_provider.dart';
import 'package:ekvi/Providers/Reminders/contraceptive_patch_povider.dart';
import 'package:ekvi/Providers/Reminders/iud_provider.dart';
import 'package:ekvi/Providers/Reminders/medication_reminder_provider.dart';
import 'package:ekvi/Providers/Reminders/oral_contraception_provider.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Providers/Reminders/vaginal_ring_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Providers/Splash/splash_provider.dart';
import 'package:ekvi/Providers/userProvider/free_user_provider.dart';
import 'package:ekvi/Providers/WellnessWeekly/wellness_weekly_provider.dart';
import 'package:ekvi/Providers/WellnessWeekly/wins_of_the_week_provider.dart';
import 'package:ekvi/Providers/WellnessWeekly/symptom_shifts_provider.dart';
import 'package:ekvi/Providers/WellnessWeekly/affirmations_provider.dart';
import 'package:ekvi/Providers/WellnessWeekly/wellbeing_practices_provider.dart';
import 'package:ekvi/Providers/WellnessWeekly/wellbeing_levels_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'DailyTracker/BowelMovement/bowel_movement_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => SplashProvider()),
  ChangeNotifierProvider(create: (_) => RegisterProvider()),
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => DashboardProvider()),
  ChangeNotifierProvider(create: (_) => AppUpdaterProvider()),
  ChangeNotifierProvider(create: (_) => DailyTrackerProvider()),
  ChangeNotifierProvider(create: (_) => EditProfileProvider()),
  ChangeNotifierProvider(create: (_) => NotificationsProvider()),
  ChangeNotifierProvider(create: (_) => CycleCalendarProvider()),
  ChangeNotifierProvider(create: (_) => CycleTrackingProvider()),
  ChangeNotifierProvider(create: (_) => FreeUserProvider()),
  ChangeNotifierProvider(create: (_) => SideNavManagerProvider()),
  ChangeNotifierProvider(create: (_) => LocaleProvider()),
  ChangeNotifierProvider(create: (_) => FAQsProvider()),
  ChangeNotifierProvider(create: (_) => OnboardingProvider()),
  ChangeNotifierProvider(create: (_) => DeleteAccountProvider()),
  ChangeNotifierProvider(create: (_) => BowelMovementProvider()),
  ChangeNotifierProvider(create: (_) => SelfcareProvider()),
  ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
  ChangeNotifierProvider(create: (_) => EkvipediaArticleProvider()),
  ChangeNotifierProvider(create: (_) => YourWellBeingProvider()),
  ...getRemindersProviders(),
  ...getInsightsProviders(),
  ...getDailyTrackerProviders(),
  ...ekvipediaProviders(),
  ...painKillerProviders(),
  ...getMovementProviders(),
  ...getSelfcareProviders(),
  ...getPainReliefProviders(),
  ...getWellnessWeeklyProviders(),
];

List<SingleChildWidget> getInsightsProviders() => [
      ChangeNotifierProvider(create: (_) => InsightsProvider()),
      ChangeNotifierProvider(
          create: (_) => InsightsSymptomTimeSelectionProvider()),
      ChangeNotifierProvider(create: (_) => MultiSymptomsChartProvider()),
    ];

List<SingleChildWidget> getRemindersProviders() => [
      ChangeNotifierProvider(create: (_) => RemindersProvider()),
      ChangeNotifierProvider(create: (_) => OralContraceptionProvider()),
      ChangeNotifierProvider(create: (_) => VaginalRingProvider()),
      ChangeNotifierProvider(create: (_) => ContraceptivePatchProvider()),
      ChangeNotifierProvider(create: (_) => ContraceptivePatchProvider()),
      ChangeNotifierProvider(create: (_) => ContraceptiveInjectionProvider()),
      ChangeNotifierProvider(create: (_) => IUDReminderProvider()),
      ChangeNotifierProvider(create: (_) => ContraceptiveImplantProvider()),
      ChangeNotifierProvider(create: (_) => MedicationReminderProvider()),
    ];

List<SingleChildWidget> getDailyTrackerProviders() => [
      ChangeNotifierProvider(create: (_) => BleedingProvider()),
      ChangeNotifierProvider(create: (_) => MoodProvider()),
      ChangeNotifierProvider(create: (_) => StressProvider()),
      ChangeNotifierProvider(create: (_) => EnergyProvider()),
      ChangeNotifierProvider(create: (_) => NauseaProvider()),
      ChangeNotifierProvider(create: (_) => FatigueProvider()),
      ChangeNotifierProvider(create: (_) => BloatingProvider()),
      ChangeNotifierProvider(create: (_) => BrainFogProvider()),
      ChangeNotifierProvider(create: (_) => AlcoholProvider()),
      ChangeNotifierProvider(create: (_) => HormonesProvider()),
      ChangeNotifierProvider(create: (_) => IntimacyProvider()),
      ChangeNotifierProvider(create: (_) => OvulationTestProvider()),
      ChangeNotifierProvider(create: (_) => PregnancyTestProvider()),
      ChangeNotifierProvider(create: (_) => BowelMovementProvider()),
      ChangeNotifierProvider(create: (_) => HeadacheProvider()),
    ];

List<SingleChildWidget> ekvipediaProviders() => [
      ChangeNotifierProvider(create: (_) => EkvipediaProvider()),
      ChangeNotifierProvider(create: (_) => EkviJourneysProvider()),
      ChangeNotifierProvider(create: (_) => EkviJourneysVideoPlayerProvider()),
      ChangeNotifierProvider(create: (_) => EkviJourneysAudioPlayerProvider()),
      ChangeNotifierProvider(create: (_) => EkviJourneysCourseProvider()),
    ];

List<SingleChildWidget> painKillerProviders() => [
      ChangeNotifierProvider(create: (_) => PainKillersProvider()),
      ChangeNotifierProvider(create: (_) => PainKillersVaultProvider()),
    ];

List<SingleChildWidget> getMovementProviders() => [
      ChangeNotifierProvider(create: (_) => MovementProvider()),
      ChangeNotifierProvider(create: (_) => MovementVaultProvider()),
    ];

List<SingleChildWidget> getSelfcareProviders() => [
      ChangeNotifierProvider(create: (_) => SelfcareProvider()),
      ChangeNotifierProvider(create: (_) => SelfcareVaultProvider()),
    ];

List<SingleChildWidget> getPainReliefProviders() => [
      ChangeNotifierProvider(create: (_) => PainReliefProvider()),
      ChangeNotifierProvider(create: (_) => PainReliefVaultProvider()),
    ];

List<SingleChildWidget> getWellnessWeeklyProviders() => [
      ChangeNotifierProvider(create: (_) => WellnessWeeklyProvider()),
      ChangeNotifierProvider(create: (_) => WinsOfTheWeekProvider()),
      ChangeNotifierProvider(create: (_) => SymptomShiftsProvider()),
      ChangeNotifierProvider(create: (_) => AffirmationsProvider()),
      ChangeNotifierProvider(create: (_) => WellbeingPracticesProvider()),
      ChangeNotifierProvider(create: (_) => WellbeingLevelsProvider()),
    ];
