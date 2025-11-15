import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/BodyPain/body_pain.dart';
import 'package:ekvi/Screens/BodyPain/body_pain_event.dart';
import 'package:ekvi/Screens/ContraceptionReminders/contraceptive_implant.dart';
import 'package:ekvi/Screens/ContraceptionReminders/contraceptive_injection_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/contraceptive_patch_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/iud_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/oral_contraception_reminder.dart';
import 'package:ekvi/Screens/ContraceptionReminders/vaginal_ring_reminder.dart';
import 'package:ekvi/Screens/CycleCalendar/cycle_calendar_screen.dart';
import 'package:ekvi/Screens/CycleTracking/cycle_tracking.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Movement/add_movement_practice_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Movement/update_movement_practice_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Pain-Relief/update_pain_relief_practice_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/PainKillers/add_pain_killer_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/PainKillers/edit_pain_killer_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Selfcare/add_selfcare_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Selfcare/update_selfcare_practice_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/daily_tracker_category.dart';
import 'package:ekvi/Screens/Dashboard/dashboard.dart';
import 'package:ekvi/Screens/DeleteAccount/delete_account.dart';
import 'package:ekvi/Screens/EditProfile/edit_profile.dart';
import 'package:ekvi/Screens/EditProfile/edit_profile_settings.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysCourse/ekvi_journey_course_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_audio_lesson_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_lesson_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_vedio_lesson_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/ekvi_journeys_module_completion_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/ekvipedia_article_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_references.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/lesson_reference_preview.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaEvents/ekvipedia_event_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaTopic/ekvipedia_topic_screen.dart';
import 'package:ekvi/Screens/FAQs/faqs.dart';
import 'package:ekvi/Screens/Insights/insights_screen.dart';
import 'package:ekvi/Screens/Intercom/intercom.dart';
import 'package:ekvi/Screens/Login/login_landing_screen.dart';
import 'package:ekvi/Screens/LoginWithBankId/login_bank_id.dart';
import 'package:ekvi/Screens/Notes/notes_screen.dart';
import 'package:ekvi/Screens/Onboarding/onboarding_screen.dart';
import 'package:ekvi/Screens/Register/register_landing_screen.dart';
import 'package:ekvi/Screens/Register/register_with_apple.dart';
import 'package:ekvi/Screens/Register/register_with_google.dart';
import 'package:ekvi/Screens/Reminders/contraception_menu.dart';
import 'package:ekvi/Screens/Reminders/medication_reminder.dart';
import 'package:ekvi/Screens/Reminders/reminders.dart';
import 'package:ekvi/Screens/SideNavManager/side_nav_manager.dart';
import 'package:ekvi/Screens/SignicatWebView/signicat_web_view.dart';
import 'package:ekvi/Screens/Splash/splash_screen.dart';
import 'package:ekvi/Screens/SubscriptionPlan/subscribe_screen.dart';
import 'package:ekvi/Screens/SubscriptionPlan/subscription_welcome.dart';
import 'package:ekvi/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.welcomeRoute:
        return _screenRoute(screen: const WelcomeScreen());
      case AppRoutes.initial:
        return _screenRoute(screen: const SplashScreen());
      case AppRoutes.registerRoute:
        return _screenRoute(screen: const RegisterLandingScreen());
      // case AppRoutes.registerWithBankID:
      //   return _screenRoute(screen: const RegisterWithBankID());
      case AppRoutes.registerWithGoogle:
        return _screenRoute(screen: const RegisterWithGoogle());
      case AppRoutes.registerWithApple:
        return _screenRoute(screen: const RegisterWithApple());
      case AppRoutes.loginWithBankId:
        return _screenRoute(
          screen: const LoginWithBankId(),
        );

      case AppRoutes.editProfile:
        return _screenRoute(screen: const EditProfileScreen());

      case AppRoutes.editProfileSettings:
        return _screenRoute(screen: const EditProfileSettings());
      case AppRoutes.cyclePredictionAndEditing:
        return _screenRoute(screen: const CycleCalendarScreen());
      case AppRoutes.supportAndFeedBack:
        return _screenRoute(screen: const IntercomScreen());
      case AppRoutes.loginRoute:
        return _screenRoute(screen: const LoginLandingScreen());
      case AppRoutes.cycleHistory:
        return _screenRoute(screen: const InsightsScreen());

      case AppRoutes.cycleTracking:
        return _screenRoute(
            screen: CycleTracking(
          screenArguments: args as ScreenArguments,
        ));
      case AppRoutes.bodyPain:
        return _screenRoute(
          screen: const BodyPain(),
        );
      case AppRoutes.signicatWebView:
        return _screenRoute(
          screen: SignicatWebView(arguments: args as ScreenArguments),
        );

      case AppRoutes.onboarding:
        return _screenRoute(screen: const OnboardingScreen());

      case AppRoutes.reminders:
        return _screenRoute(screen: const Reminders());
      case AppRoutes.medicationReminder:
        return _screenRoute(
            screen: MedicationReminderScreen(
                args: args != null
                    ? args as ScreenArguments
                    : ScreenArguments()));
      case AppRoutes.sideNavManager:
        return _screenRoute(screen: const SideNavManager());

      case AppRoutes.categoryEdit:
        return _screenRoute(screen: const DailyTrackerCategory());

      case AppRoutes.painEventEdit:
        return _screenRoute(screen: const BodyPainEvent());
      case AppRoutes.contraceptionMenu:
        return _screenRoute(screen: const ContraceptionMenu());
      case AppRoutes.oralContraceptionReminder:
        return _screenRoute(screen: const OralContraceptionReminder());
      case AppRoutes.vaginalRingReminder:
        return _screenRoute(screen: const VaginalRingReminder());
      case AppRoutes.contraceptivePatchReminder:
        return _screenRoute(screen: const ContraceptivePatchReminder());
      case AppRoutes.contraceptiveInjectionReminder:
        return _screenRoute(screen: const ContraceptiveInjectionReminder());
      case AppRoutes.iudReminder:
        return _screenRoute(screen: const IUDReminder());
      case AppRoutes.contraceptiveImplantReminder:
        return _screenRoute(screen: const ContraceptiveImplantReminder());
      case AppRoutes.notesRoute:
        return _screenRoute(
            screen: NotesScreen(
          arguments: args as ScreenArguments,
        ));

      case AppRoutes.faqs:
        return _screenRoute(screen: const FAQScreen());
      case AppRoutes.deleteAccount:
        return _screenRoute(screen: const DeleteAccountScreen());
      case AppRoutes.ekvipediaArticle:
        return _screenRoute(
            screen: EkvipediaArticleScreen(
          arguments: args != null ? args as ScreenArguments : ScreenArguments(),
        ));

      case AppRoutes.ekvipediaEvents:
        return _screenRoute(
            screen: EkvipediaEventScreen(
          arguments: args != null ? args as ScreenArguments : ScreenArguments(),
        ));
      case AppRoutes.ekvipediaTopics:
        return _screenRoute(
            screen: EkvipediaTopic(
          arguments: args != null ? args as ScreenArguments : ScreenArguments(),
        ));

      case AppRoutes.ekvipediaArticleReferences:
        return _screenRoute(
            screen: ArticleReferencesScreen(
          arguments: args != null ? args as ScreenArguments : ScreenArguments(),
        ));

      case AppRoutes.painKillerEditScreen:
        return _screenRoute(
            screen: EditPainKillerScreen(
          args: args != null ? args as ScreenArguments : ScreenArguments(),
        ));

      case AppRoutes.painKillerAddScreen:
        return _screenRoute(screen: const AddPainKillerScreen());

      case AppRoutes.addMovementPracticeScreen:
        return _screenRoute(screen: const AddMovementPracticeScreen());

      case AppRoutes.updateMovementPracticeScreen:
        return _screenRoute(
            screen: UpdateMovementPracticeScreen(
          args: args != null ? args as ScreenArguments : ScreenArguments(),
        ));

      case AppRoutes.addSelfCarePracticesScreen:
        return _screenRoute(screen: const AddSelfcareScreen());

      case AppRoutes.updateSelfCarePracticesScreen:
        return _screenRoute(
            screen: UpdateSelfcarePracticeScreen(
          args: args != null ? args as ScreenArguments : ScreenArguments(),
        ));

      case AppRoutes.updatePainReliefPracticesScreen:
        return _screenRoute(
            screen: UpdatePainReliefPracticeScreen(
          args: args != null ? args as ScreenArguments : ScreenArguments(),
        ));

      case AppRoutes.ekviJourneysCourse:
        return _screenRoute(
          screen: EkviJourneysCourseScreen(
            arguments:
                args != null ? args as ScreenArguments : ScreenArguments(),
          ),
        );
      case AppRoutes.ekviJourneysLesson:
        return _screenRoute(
            screen: EkviJourneysLessonScreen(
          arguments: args != null ? args as ScreenArguments : ScreenArguments(),
        ));
      case AppRoutes.ekviJouneysAudioLesson:
        return _screenRoute(
          screen: const EkviJourneysAudioLessonScreen(
              // arguments: args != null ? args as ScreenArguments : ScreenArguments(),
              ),
        );
      case AppRoutes.ekviJourneysVedioLesson:
        return _screenRoute(
          screen: const EkviJourneysVedioLessonScreen(
              // arguments: args != null ? args as ScreenArguments : ScreenArguments(),
              ),
        );

      case AppRoutes.ekviJourneysModuleCompletion:
        return _screenRoute(screen: const EkviJourneysModuleCompletionScreen());

      case AppRoutes.ekviJourneysLessonReferences:
        return _screenRoute(
          screen: LessonReferenceScreen(
            arguments:
                args != null ? args as ScreenArguments : ScreenArguments(),
          ),
        );
      case AppRoutes.subscribe:
        return _screenRoute(
            screen: SubscribeScreen(
          navigationCallback: args != null
              ? (args as ScreenArguments).navigationCallback
              : null,
        ));
      case AppRoutes.subscriptionWelcome:
        return _screenRoute(
            screen: SubscriptionWelcome(
          navigationCallback: args != null
              ? (args as ScreenArguments).navigationCallback
              : null,
        ));
      default:
        return _screenRoute(screen: const Dashboard());
    }
  }

  static Route<dynamic> _screenRoute({Widget? screen}) {
    return MaterialPageRoute(builder: (context) => screen!);
  }
}
