import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nb.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nb')
  ];

  /// No description provided for @menu_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get menu_settings;

  /// No description provided for @menu_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get menu_profile;

  /// No description provided for @menu_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get menu_dashboard;

  /// No description provided for @menu_cycleTracking.
  ///
  /// In en, this message translates to:
  /// **'Cycle Tracking'**
  String get menu_cycleTracking;

  /// No description provided for @menu_reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get menu_reminders;

  /// No description provided for @menu_supportFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback & Support'**
  String get menu_supportFeedback;

  /// No description provided for @menu_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get menu_language;

  /// No description provided for @menu_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get menu_logout;

  /// Title for the main health companion feature
  ///
  /// In en, this message translates to:
  /// **'The health companion you deserve'**
  String get healthCompanion;

  /// No description provided for @authenticateWithBiometric.
  ///
  /// In en, this message translates to:
  /// **'Authenticate With Biometric'**
  String get authenticateWithBiometric;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUpNow.
  ///
  /// In en, this message translates to:
  /// **'Sign-up Now'**
  String get signUpNow;

  /// No description provided for @not_regular_period_tracker_title.
  ///
  /// In en, this message translates to:
  /// **'We’re not a regular period tracker.'**
  String get not_regular_period_tracker_title;

  /// No description provided for @not_regular_period_tracker_description.
  ///
  /// In en, this message translates to:
  /// **'With Ekvi, you can easily and precisely track a broad range of symptoms related to endometriosis and other reproductive diseases.'**
  String get not_regular_period_tracker_description;

  /// No description provided for @health_companion_title.
  ///
  /// In en, this message translates to:
  /// **'...we’re your health companion for life'**
  String get health_companion_title;

  /// No description provided for @health_companion_description.
  ///
  /// In en, this message translates to:
  /// **'Helping you to track, understand and share your symptoms with healthcare providers, all in one app.'**
  String get health_companion_description;

  /// No description provided for @revolutionizing_support_title.
  ///
  /// In en, this message translates to:
  /// **'Revolutionizing endometriosis support'**
  String get revolutionizing_support_title;

  /// No description provided for @revolutionizing_support_description.
  ///
  /// In en, this message translates to:
  /// **'Ekvi guides you toward effective solutions through symptom analysis and actionable insights.'**
  String get revolutionizing_support_description;

  /// Prompt to begin or initiate a process
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @welcomeToEkvi.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ekvi! Please enter your details'**
  String get welcomeToEkvi;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & conditions and privacy policy'**
  String get termsAndConditions;

  /// No description provided for @receiveContentFromEkvi.
  ///
  /// In en, this message translates to:
  /// **'I want to receive inspiring and empowering content from Ekvi'**
  String get receiveContentFromEkvi;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signUpLoginText.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get signUpLoginText;

  /// No description provided for @signUpAgreementPrefix.
  ///
  /// In en, this message translates to:
  /// **'By signing up I have read and agree to Ekvi’s '**
  String get signUpAgreementPrefix;

  /// No description provided for @termsAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Terms & conditions'**
  String get termsAndPrivacy;

  /// No description provided for @newsletterSubscription.
  ///
  /// In en, this message translates to:
  /// **'I want to receive inspiring and empowering content from Ekvi'**
  String get newsletterSubscription;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @greetingMessage.
  ///
  /// In en, this message translates to:
  /// **'Hey there,'**
  String get greetingMessage;

  /// No description provided for @welcomeBackMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to Ekvi! To keep your account and data extra safe, we’ll ask you to log in with your BankID when you haven’t been logged in for a while.'**
  String get welcomeBackMessage;

  /// No description provided for @loginWithBankID.
  ///
  /// In en, this message translates to:
  /// **'Login With BankID'**
  String get loginWithBankID;

  /// No description provided for @notUnaSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up with a new account'**
  String get notUnaSignUp;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNo.
  ///
  /// In en, this message translates to:
  /// **'Phone no'**
  String get phoneNo;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cycleTracking.
  ///
  /// In en, this message translates to:
  /// **'Cycle Tracking'**
  String get cycleTracking;

  /// No description provided for @iGetMyPeriods.
  ///
  /// In en, this message translates to:
  /// **'I get my periods'**
  String get iGetMyPeriods;

  /// No description provided for @regularity.
  ///
  /// In en, this message translates to:
  /// **'Regularity'**
  String get regularity;

  /// No description provided for @myCycleIsRegular.
  ///
  /// In en, this message translates to:
  /// **'My cycle is regular'**
  String get myCycleIsRegular;

  /// No description provided for @myCycleIsIrregular.
  ///
  /// In en, this message translates to:
  /// **'My cycle is irregular'**
  String get myCycleIsIrregular;

  /// No description provided for @iDontKnow.
  ///
  /// In en, this message translates to:
  /// **'I don’t know'**
  String get iDontKnow;

  /// No description provided for @myCycleDetails.
  ///
  /// In en, this message translates to:
  /// **'My Cycle Details'**
  String get myCycleDetails;

  /// No description provided for @whenDidYourLastCycleStart.
  ///
  /// In en, this message translates to:
  /// **'When did your last cycle start?'**
  String get whenDidYourLastCycleStart;

  /// No description provided for @selectValue.
  ///
  /// In en, this message translates to:
  /// **'Select value'**
  String get selectValue;

  /// No description provided for @howLongIsYourAverageCycle.
  ///
  /// In en, this message translates to:
  /// **'How long is your average cycle?'**
  String get howLongIsYourAverageCycle;

  /// No description provided for @howLongIsYourAveragePeriod.
  ///
  /// In en, this message translates to:
  /// **'How long is your average period?'**
  String get howLongIsYourAveragePeriod;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @addANewReminder.
  ///
  /// In en, this message translates to:
  /// **'Add a new reminder'**
  String get addANewReminder;

  /// No description provided for @periodBeginsIn2Days.
  ///
  /// In en, this message translates to:
  /// **'Period begins in 2 days'**
  String get periodBeginsIn2Days;

  /// No description provided for @contraception.
  ///
  /// In en, this message translates to:
  /// **'Contraception'**
  String get contraception;

  /// No description provided for @medication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get medication;

  /// No description provided for @currentReminders.
  ///
  /// In en, this message translates to:
  /// **'Current reminders'**
  String get currentReminders;

  /// No description provided for @tapOnTheSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Tap on the symptoms if you want to edit them, give them a long press for a delete option'**
  String get tapOnTheSymptoms;

  /// No description provided for @reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get reminderTime;

  /// No description provided for @personalizeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Personalize your message'**
  String get personalizeYourMessage;

  /// No description provided for @heyGorgeousPeriodMessage.
  ///
  /// In en, this message translates to:
  /// **'Hey gorgeous! Your period is about to start 💜'**
  String get heyGorgeousPeriodMessage;

  /// No description provided for @contraceptions.
  ///
  /// In en, this message translates to:
  /// **'Contraceptions'**
  String get contraceptions;

  /// No description provided for @addNewReminder.
  ///
  /// In en, this message translates to:
  /// **'Add a new reminder'**
  String get addNewReminder;

  /// No description provided for @textPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Text could go here'**
  String get textPlaceholder;

  /// No description provided for @oral.
  ///
  /// In en, this message translates to:
  /// **'Oral (the pill)'**
  String get oral;

  /// No description provided for @ring.
  ///
  /// In en, this message translates to:
  /// **'Ring'**
  String get ring;

  /// No description provided for @patch.
  ///
  /// In en, this message translates to:
  /// **'Patch'**
  String get patch;

  /// No description provided for @injection.
  ///
  /// In en, this message translates to:
  /// **'Injection'**
  String get injection;

  /// No description provided for @iud.
  ///
  /// In en, this message translates to:
  /// **'IUD'**
  String get iud;

  /// No description provided for @implant.
  ///
  /// In en, this message translates to:
  /// **'Implant'**
  String get implant;

  /// No description provided for @oralContraceptives.
  ///
  /// In en, this message translates to:
  /// **'Oral contraceptives'**
  String get oralContraceptives;

  /// No description provided for @pillOralReminderMessage.
  ///
  /// In en, this message translates to:
  /// **'Hey gorgeous! It’s time for your pill 💜'**
  String get pillOralReminderMessage;

  /// No description provided for @numberOfPills.
  ///
  /// In en, this message translates to:
  /// **'Number of pills in the package'**
  String get numberOfPills;

  /// No description provided for @packageInfo.
  ///
  /// In en, this message translates to:
  /// **'This information helps us send reminders when it’s time to change pack or when to get new ones.'**
  String get packageInfo;

  /// No description provided for @vaginalRing.
  ///
  /// In en, this message translates to:
  /// **'Vaginal ring'**
  String get vaginalRing;

  /// No description provided for @ringInsertion.
  ///
  /// In en, this message translates to:
  /// **'Ring insertion'**
  String get ringInsertion;

  /// No description provided for @ringChangeReminder.
  ///
  /// In en, this message translates to:
  /// **'When do you want to get a reminder to change your ring?'**
  String get ringChangeReminder;

  /// No description provided for @contraceptivesPatch.
  ///
  /// In en, this message translates to:
  /// **'Contraceptives patch'**
  String get contraceptivesPatch;

  /// No description provided for @numberOfPatches.
  ///
  /// In en, this message translates to:
  /// **'Number of patches in the package'**
  String get numberOfPatches;

  /// No description provided for @patchReminderDescription.
  ///
  /// In en, this message translates to:
  /// **'This information helps us send reminders when it’s time to change pack or when to get new ones.'**
  String get patchReminderDescription;

  /// No description provided for @contraceptivesInjection.
  ///
  /// In en, this message translates to:
  /// **'Contraceptives injection'**
  String get contraceptivesInjection;

  /// No description provided for @injectionFrequency.
  ///
  /// In en, this message translates to:
  /// **'Injection frequency'**
  String get injectionFrequency;

  /// No description provided for @injectionFrequencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the number of weeks between injections and the start date. This information helps us send reminders when it’s time to get new a new one.'**
  String get injectionFrequencyDescription;

  /// No description provided for @stringCheck.
  ///
  /// In en, this message translates to:
  /// **'String check'**
  String get stringCheck;

  /// No description provided for @iudReplacement.
  ///
  /// In en, this message translates to:
  /// **'IUD replacement'**
  String get iudReplacement;

  /// No description provided for @iudReplacementDescription.
  ///
  /// In en, this message translates to:
  /// **'Log the number of years the IUD is valid so we can send you a reminder when it’s time for a new one. Ovulation predictions depend on the type of IUD.'**
  String get iudReplacementDescription;

  /// No description provided for @contraceptivesImplant.
  ///
  /// In en, this message translates to:
  /// **'Contraceptives implant'**
  String get contraceptivesImplant;

  /// No description provided for @logNumberOfYearsImplant.
  ///
  /// In en, this message translates to:
  /// **'Log the number of years the implant is valid so we can send you a reminder when it’s time for a new one.'**
  String get logNumberOfYearsImplant;

  /// No description provided for @newMedication.
  ///
  /// In en, this message translates to:
  /// **'New medication'**
  String get newMedication;

  /// No description provided for @typeOfMedication.
  ///
  /// In en, this message translates to:
  /// **'Type of medication'**
  String get typeOfMedication;

  /// No description provided for @dailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get dailyReminder;

  /// No description provided for @customizeReminder.
  ///
  /// In en, this message translates to:
  /// **'Customize reminder'**
  String get customizeReminder;

  /// No description provided for @ekviFeedbackSupport.
  ///
  /// In en, this message translates to:
  /// **'Feedback & Support'**
  String get ekviFeedbackSupport;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @messageOurExperts.
  ///
  /// In en, this message translates to:
  /// **'Message our experts or leave feedback for future features'**
  String get messageOurExperts;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'F&Q'**
  String get helpCenter;

  /// No description provided for @faqGuidesLegal.
  ///
  /// In en, this message translates to:
  /// **'Answers to all your questions'**
  String get faqGuidesLegal;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotificationYet.
  ///
  /// In en, this message translates to:
  /// **'No notification yet!'**
  String get noNotificationYet;

  /// No description provided for @stayTuned.
  ///
  /// In en, this message translates to:
  /// **'Stay tuned for any upcoming messages or alerts.'**
  String get stayTuned;

  /// No description provided for @cyclePredictions.
  ///
  /// In en, this message translates to:
  /// **'Cycle Predictions'**
  String get cyclePredictions;

  /// No description provided for @yourPredictionsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Period days saved'**
  String get yourPredictionsUpdated;

  /// No description provided for @tapOnDays.
  ///
  /// In en, this message translates to:
  /// **'Tap on the days you had your period'**
  String get tapOnDays;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @editDaysWithPeriod.
  ///
  /// In en, this message translates to:
  /// **'Edit Days With Bleeding'**
  String get editDaysWithPeriod;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @follicular.
  ///
  /// In en, this message translates to:
  /// **'Follicular'**
  String get follicular;

  /// No description provided for @ovulation.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get ovulation;

  /// No description provided for @lutheal.
  ///
  /// In en, this message translates to:
  /// **'Lutheal'**
  String get lutheal;

  /// No description provided for @bleeding.
  ///
  /// In en, this message translates to:
  /// **'Bleeding'**
  String get bleeding;

  /// No description provided for @pain.
  ///
  /// In en, this message translates to:
  /// **'Pain'**
  String get pain;

  /// No description provided for @myCycle.
  ///
  /// In en, this message translates to:
  /// **'My Cycle'**
  String get myCycle;

  /// No description provided for @cycleDescription.
  ///
  /// In en, this message translates to:
  /// **'Every cycle is a new adventure waiting to be unwrapped! From sunrise to sunset, your body\'s scripting a story filled with surprises and triumphs.'**
  String get cycleDescription;

  /// No description provided for @cycleHistory.
  ///
  /// In en, this message translates to:
  /// **'Cycle history'**
  String get cycleHistory;

  /// No description provided for @cycleHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Oh, the tales your cycle history could tell! Each month, it weaves a unique story of your body\'s journey.'**
  String get cycleHistoryDescription;

  /// No description provided for @fertileWindow.
  ///
  /// In en, this message translates to:
  /// **'Fertile window'**
  String get fertileWindow;

  /// No description provided for @dataPredictionInfo.
  ///
  /// In en, this message translates to:
  /// **'We don’t have enough data to predict the patterns in your cycle. The more you track, the better predictions we will be able to find.'**
  String get dataPredictionInfo;

  /// No description provided for @addCycleData.
  ///
  /// In en, this message translates to:
  /// **'Add your cycle data'**
  String get addCycleData;

  /// No description provided for @addCycleButton.
  ///
  /// In en, this message translates to:
  /// **'Add Cycle'**
  String get addCycleButton;

  /// No description provided for @cycleInformation.
  ///
  /// In en, this message translates to:
  /// **'We don’t have enough information about your cycle to show any information here. Let’s change that!'**
  String get cycleInformation;

  /// No description provided for @topSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Top Symptoms'**
  String get topSymptoms;

  /// No description provided for @symptomsDescription.
  ///
  /// In en, this message translates to:
  /// **'Based on your fabulous tracking, here are your key symptoms from your last cycle phase.'**
  String get symptomsDescription;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon!'**
  String get comingSoon;

  /// No description provided for @unveilMagicDescription.
  ///
  /// In en, this message translates to:
  /// **'Get ready to unveil the magic of your unique cycle! Our upcoming feature will whisk you away on a journey through your tracking patterns and symptoms. Discover the hidden gems of your cycle like never before, and chart a course to a happier, healthier you! Stay tuned for this exciting addition coming soon.'**
  String get unveilMagicDescription;

  /// No description provided for @appForYou.
  ///
  /// In en, this message translates to:
  /// **'We’re building this app for you!'**
  String get appForYou;

  /// No description provided for @yourThoughts.
  ///
  /// In en, this message translates to:
  /// **'So your thoughts mean the world to us. If you had a wishlist for this screen, what magical ingredients would you sprinkle to make it uniquely yours? Share your dreams, and let\'s make this app an even greater masterpiece together!\n\nLooking forward to hearing your ideas! Big hugs from the Ekvi team 💜'**
  String get yourThoughts;

  /// No description provided for @shareWishes.
  ///
  /// In en, this message translates to:
  /// **'Share Your Wishes'**
  String get shareWishes;

  /// No description provided for @myDay.
  ///
  /// In en, this message translates to:
  /// **'My Day'**
  String get myDay;

  /// No description provided for @feelingToday.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get feelingToday;

  /// No description provided for @moreTrackingBetterPredictions.
  ///
  /// In en, this message translates to:
  /// **'The more you track, the better our predictions will be, and the better support can we give you'**
  String get moreTrackingBetterPredictions;

  /// No description provided for @trackTodaySymtoms.
  ///
  /// In en, this message translates to:
  /// **'Track Today’s Symptoms'**
  String get trackTodaySymtoms;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @cycle.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get cycle;

  /// No description provided for @tracking.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get tracking;

  /// No description provided for @stories.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get stories;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @dailyTracker.
  ///
  /// In en, this message translates to:
  /// **'Daily Tracker'**
  String get dailyTracker;

  /// No description provided for @crackTheCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Crack the code to your body’s quirks and discover your cycle’s secret language. Track symptoms like a pro and embrace the unpredictable journey of being wonderfully, uniquely you!'**
  String get crackTheCodeDescription;

  /// No description provided for @thingsIExperience.
  ///
  /// In en, this message translates to:
  /// **'Things I experience'**
  String get thingsIExperience;

  /// No description provided for @emotions.
  ///
  /// In en, this message translates to:
  /// **'Emotions'**
  String get emotions;

  /// No description provided for @thingsIPutInMyBody.
  ///
  /// In en, this message translates to:
  /// **'Things I put in my body'**
  String get thingsIPutInMyBody;

  /// No description provided for @hormones.
  ///
  /// In en, this message translates to:
  /// **'Hormones'**
  String get hormones;

  /// No description provided for @painkillers.
  ///
  /// In en, this message translates to:
  /// **'Painkillers'**
  String get painkillers;

  /// No description provided for @alcohol.
  ///
  /// In en, this message translates to:
  /// **'Alcohol'**
  String get alcohol;

  /// No description provided for @coffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get coffee;

  /// No description provided for @fertilityAndPregnancy.
  ///
  /// In en, this message translates to:
  /// **'Fertility & pregnancy'**
  String get fertilityAndPregnancy;

  /// No description provided for @ovulationTest.
  ///
  /// In en, this message translates to:
  /// **'Ovulationt Test'**
  String get ovulationTest;

  /// No description provided for @pregnancyTest.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy test'**
  String get pregnancyTest;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sex;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @aching.
  ///
  /// In en, this message translates to:
  /// **'Aching'**
  String get aching;

  /// No description provided for @agonising.
  ///
  /// In en, this message translates to:
  /// **'Agonising'**
  String get agonising;

  /// No description provided for @burning.
  ///
  /// In en, this message translates to:
  /// **'Burning'**
  String get burning;

  /// No description provided for @constant.
  ///
  /// In en, this message translates to:
  /// **'Constant'**
  String get constant;

  /// No description provided for @cramping.
  ///
  /// In en, this message translates to:
  /// **'Cramping'**
  String get cramping;

  /// No description provided for @dull.
  ///
  /// In en, this message translates to:
  /// **'Dull'**
  String get dull;

  /// No description provided for @random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get random;

  /// No description provided for @sharp.
  ///
  /// In en, this message translates to:
  /// **'Sharp'**
  String get sharp;

  /// No description provided for @shooting.
  ///
  /// In en, this message translates to:
  /// **'Shooting'**
  String get shooting;

  /// No description provided for @spasm.
  ///
  /// In en, this message translates to:
  /// **'Spasm'**
  String get spasm;

  /// No description provided for @stabbing.
  ///
  /// In en, this message translates to:
  /// **'Stabbing'**
  String get stabbing;

  /// No description provided for @throbbing.
  ///
  /// In en, this message translates to:
  /// **'Throbbing'**
  String get throbbing;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @afternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get afternoon;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @night.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get night;

  /// No description provided for @allDay.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get allDay;

  /// No description provided for @abdominalPain.
  ///
  /// In en, this message translates to:
  /// **'Abdominal pain'**
  String get abdominalPain;

  /// No description provided for @stomachCramps.
  ///
  /// In en, this message translates to:
  /// **'Stomach cramps'**
  String get stomachCramps;

  /// No description provided for @bloating.
  ///
  /// In en, this message translates to:
  /// **'Bloating'**
  String get bloating;

  /// No description provided for @nausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get nausea;

  /// No description provided for @vomiting.
  ///
  /// In en, this message translates to:
  /// **'Vomiting'**
  String get vomiting;

  /// No description provided for @acidRefluxOrHeartburn.
  ///
  /// In en, this message translates to:
  /// **'Acid reflux or heartburn'**
  String get acidRefluxOrHeartburn;

  /// No description provided for @feelingOfFullness.
  ///
  /// In en, this message translates to:
  /// **'Feeling of fullness'**
  String get feelingOfFullness;

  /// No description provided for @lossOfAppetite.
  ///
  /// In en, this message translates to:
  /// **'Loss of appetite'**
  String get lossOfAppetite;

  /// No description provided for @gasAndFlatulence.
  ///
  /// In en, this message translates to:
  /// **'Gas and flatulence'**
  String get gasAndFlatulence;

  /// No description provided for @difficultySwallowing.
  ///
  /// In en, this message translates to:
  /// **'Difficulty swallowing'**
  String get difficultySwallowing;

  /// No description provided for @indigestion.
  ///
  /// In en, this message translates to:
  /// **'Indigestion'**
  String get indigestion;

  /// No description provided for @belchingOrBurping.
  ///
  /// In en, this message translates to:
  /// **'Belching or burping'**
  String get belchingOrBurping;

  /// No description provided for @painAfterEating.
  ///
  /// In en, this message translates to:
  /// **'Pain after eating'**
  String get painAfterEating;

  /// No description provided for @painOpeningBowels.
  ///
  /// In en, this message translates to:
  /// **'Pain opening bowels'**
  String get painOpeningBowels;

  /// No description provided for @painPassingUrine.
  ///
  /// In en, this message translates to:
  /// **'Pain passing urine'**
  String get painPassingUrine;

  /// No description provided for @bladderPain.
  ///
  /// In en, this message translates to:
  /// **'Bladder pain'**
  String get bladderPain;

  /// No description provided for @diarrhea.
  ///
  /// In en, this message translates to:
  /// **'Diarrhea'**
  String get diarrhea;

  /// No description provided for @constipation.
  ///
  /// In en, this message translates to:
  /// **'Constipation'**
  String get constipation;

  /// No description provided for @flight.
  ///
  /// In en, this message translates to:
  /// **'Flight'**
  String get flight;

  /// No description provided for @train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get train;

  /// No description provided for @bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get bus;

  /// No description provided for @tram.
  ///
  /// In en, this message translates to:
  /// **'Tram'**
  String get tram;

  /// No description provided for @aerobicsDancing.
  ///
  /// In en, this message translates to:
  /// **'Aerobics & Dancing'**
  String get aerobicsDancing;

  /// No description provided for @cycling.
  ///
  /// In en, this message translates to:
  /// **'Cycling'**
  String get cycling;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get gym;

  /// No description provided for @kegels.
  ///
  /// In en, this message translates to:
  /// **'Kegels'**
  String get kegels;

  /// No description provided for @pilates.
  ///
  /// In en, this message translates to:
  /// **'Pilates'**
  String get pilates;

  /// No description provided for @restDay.
  ///
  /// In en, this message translates to:
  /// **'Rest day'**
  String get restDay;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @swimming.
  ///
  /// In en, this message translates to:
  /// **'Swimming'**
  String get swimming;

  /// No description provided for @stretching.
  ///
  /// In en, this message translates to:
  /// **'Stretching'**
  String get stretching;

  /// No description provided for @strengthTraining.
  ///
  /// In en, this message translates to:
  /// **'Strength training'**
  String get strengthTraining;

  /// No description provided for @teamSports.
  ///
  /// In en, this message translates to:
  /// **'Team sports'**
  String get teamSports;

  /// No description provided for @walking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get walking;

  /// No description provided for @yoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get yoga;

  /// No description provided for @difficultyFallingAsleep.
  ///
  /// In en, this message translates to:
  /// **'Difficulty falling asleep'**
  String get difficultyFallingAsleep;

  /// No description provided for @insomnia.
  ///
  /// In en, this message translates to:
  /// **'Insomnia'**
  String get insomnia;

  /// No description provided for @wakingUpDuringNight.
  ///
  /// In en, this message translates to:
  /// **'Waking up during the night'**
  String get wakingUpDuringNight;

  /// No description provided for @daytimeFatigue.
  ///
  /// In en, this message translates to:
  /// **'Daytime fatigue'**
  String get daytimeFatigue;

  /// No description provided for @sleepwalking.
  ///
  /// In en, this message translates to:
  /// **'Sleepwalking'**
  String get sleepwalking;

  /// No description provided for @nightTerrors.
  ///
  /// In en, this message translates to:
  /// **'Night terrors'**
  String get nightTerrors;

  /// No description provided for @wakingUpTired.
  ///
  /// In en, this message translates to:
  /// **'Waking up tired'**
  String get wakingUpTired;

  /// No description provided for @protected.
  ///
  /// In en, this message translates to:
  /// **'Protected'**
  String get protected;

  /// No description provided for @unprotected.
  ///
  /// In en, this message translates to:
  /// **'Unprotected'**
  String get unprotected;

  /// No description provided for @masturbation.
  ///
  /// In en, this message translates to:
  /// **'Masturbation'**
  String get masturbation;

  /// No description provided for @painDuringSex.
  ///
  /// In en, this message translates to:
  /// **'Pain during sex'**
  String get painDuringSex;

  /// No description provided for @painAfterSex.
  ///
  /// In en, this message translates to:
  /// **'Pain after sex'**
  String get painAfterSex;

  /// No description provided for @noBleeding.
  ///
  /// In en, this message translates to:
  /// **'No bleeding'**
  String get noBleeding;

  /// No description provided for @spotting.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get spotting;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// No description provided for @heavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get heavy;

  /// No description provided for @superHeavy.
  ///
  /// In en, this message translates to:
  /// **'Super heavy'**
  String get superHeavy;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @calm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get calm;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @indifferent.
  ///
  /// In en, this message translates to:
  /// **'Indifferent'**
  String get indifferent;

  /// No description provided for @angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// No description provided for @insecure.
  ///
  /// In en, this message translates to:
  /// **'Insecure'**
  String get insecure;

  /// No description provided for @sensitive.
  ///
  /// In en, this message translates to:
  /// **'Sensitive'**
  String get sensitive;

  /// No description provided for @grateful.
  ///
  /// In en, this message translates to:
  /// **'Grateful'**
  String get grateful;

  /// No description provided for @apathetic.
  ///
  /// In en, this message translates to:
  /// **'Apathetic'**
  String get apathetic;

  /// No description provided for @obsessiveThoughts.
  ///
  /// In en, this message translates to:
  /// **'Obsessive thoughts'**
  String get obsessiveThoughts;

  /// No description provided for @confused.
  ///
  /// In en, this message translates to:
  /// **'Confused'**
  String get confused;

  /// No description provided for @selfCritical.
  ///
  /// In en, this message translates to:
  /// **'Self critical'**
  String get selfCritical;

  /// No description provided for @relaxed.
  ///
  /// In en, this message translates to:
  /// **'Relaxed'**
  String get relaxed;

  /// No description provided for @selfCompassion.
  ///
  /// In en, this message translates to:
  /// **'Self-compassion'**
  String get selfCompassion;

  /// No description provided for @highSexDrive.
  ///
  /// In en, this message translates to:
  /// **'High sex drive'**
  String get highSexDrive;

  /// No description provided for @lowSexDrive.
  ///
  /// In en, this message translates to:
  /// **'Low sex drive'**
  String get lowSexDrive;

  /// No description provided for @frisky.
  ///
  /// In en, this message translates to:
  /// **'Frisky'**
  String get frisky;

  /// No description provided for @intimacy.
  ///
  /// In en, this message translates to:
  /// **'Intimacy'**
  String get intimacy;

  /// No description provided for @satisfaction.
  ///
  /// In en, this message translates to:
  /// **'Satisfaction'**
  String get satisfaction;

  /// No description provided for @energetic.
  ///
  /// In en, this message translates to:
  /// **'Energetic'**
  String get energetic;

  /// No description provided for @motivated.
  ///
  /// In en, this message translates to:
  /// **'Motivated'**
  String get motivated;

  /// No description provided for @unmotivated.
  ///
  /// In en, this message translates to:
  /// **'Unmotivated'**
  String get unmotivated;

  /// No description provided for @focused.
  ///
  /// In en, this message translates to:
  /// **'Focused'**
  String get focused;

  /// No description provided for @productive.
  ///
  /// In en, this message translates to:
  /// **'Productive'**
  String get productive;

  /// No description provided for @unproductive.
  ///
  /// In en, this message translates to:
  /// **'Unproductive'**
  String get unproductive;

  /// No description provided for @creative.
  ///
  /// In en, this message translates to:
  /// **'Creative'**
  String get creative;

  /// No description provided for @brainFog.
  ///
  /// In en, this message translates to:
  /// **'Brain fog'**
  String get brainFog;

  /// No description provided for @hopeful.
  ///
  /// In en, this message translates to:
  /// **'Hopeful'**
  String get hopeful;

  /// No description provided for @stressed.
  ///
  /// In en, this message translates to:
  /// **'Stressed'**
  String get stressed;

  /// No description provided for @anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get anxious;

  /// No description provided for @feelingGuilty.
  ///
  /// In en, this message translates to:
  /// **'Feeling guilty'**
  String get feelingGuilty;

  /// No description provided for @shameful.
  ///
  /// In en, this message translates to:
  /// **'Shameful'**
  String get shameful;

  /// No description provided for @lonely.
  ///
  /// In en, this message translates to:
  /// **'Lonely'**
  String get lonely;

  /// No description provided for @nervous.
  ///
  /// In en, this message translates to:
  /// **'Nervous'**
  String get nervous;

  /// No description provided for @irritable.
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get irritable;

  /// No description provided for @negative.
  ///
  /// In en, this message translates to:
  /// **'Negative'**
  String get negative;

  /// No description provided for @positive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get positive;

  /// No description provided for @faintLine.
  ///
  /// In en, this message translates to:
  /// **'Faint line'**
  String get faintLine;

  /// No description provided for @didntHaveSex.
  ///
  /// In en, this message translates to:
  /// **'Didn’t have sex'**
  String get didntHaveSex;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @justExisting.
  ///
  /// In en, this message translates to:
  /// **'Just existing'**
  String get justExisting;

  /// No description provided for @eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get eating;

  /// No description provided for @toilet.
  ///
  /// In en, this message translates to:
  /// **'Toilet'**
  String get toilet;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exercise;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'nb'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'nb':
      return AppLocalizationsNb();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
