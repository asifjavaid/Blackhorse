import 'dart:io';

import 'package:ekvi/Core/di/one_signal_singleton.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/DailyTracker/categories_by_date.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Providers/EditProfile/edit_profile_provider.dart';
import 'package:ekvi/Providers/LocaleProvider/locale_provider.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_provider.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/amplitude_helper.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/intercom_helper.dart';
import 'package:ekvi/Utils/helpers/local_notification_helper.dart';
import 'package:ekvi/Utils/helpers/purchase_helper.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Utils/helpers/time_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HelperFunctions {
  static Future<void> initializeApplication() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await Future.delayed(const Duration(milliseconds: 500));
    await LocaleProvider().init();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    LocalNotificationsHelper().initNotifications(initScheduled: true);
    TimeHelper.initializeTimezones();
    listenNotifications();
    IntercomHelper.loadIntercom();
    AmplitudeHelper.init();
    await Firebase.initializeApp();
    await initializeAppServices();
  }

  static Future<void> initializeUserData() async {
    try {
      var userProfileProvider = Provider.of<EditProfileProvider>(
          AppNavigation.currentContext!,
          listen: false);
      await userProfileProvider
          .fetchUserProfile(showLoader: false)
          .then((userProfile) async {
        IntercomHelper.initializeIntercomUser(userProfile);
        AmplitudeHelper.setUserId(userProfile.id);
        AmplitudeHelper.setUserProperties(
            {"email": userProfile.email, "username": userProfile.userName});
        await initializeAppServices();
      });

      var remindersProvider = Provider.of<RemindersProvider>(
          AppNavigation.currentContext!,
          listen: false);
      remindersProvider.clearAndGetAllRemindersAndSchedule();
    } catch (e) {
      throw "Error initializing user data, $e";
    }
  }

  static Future<void> initializeAppServices() async {
    await UserManager().initialize();
    await PurchasesHelper().initialize();
    await OneSignalService().initialize();
    AudioPlayer();
  }

  static Future<String> getAccessToken() async {
    final userToken =
        await SharedPreferencesHelper.getStringPrefValue(key: "token");
    return userToken ?? "";
  }

  static Widget buildDatePicker(
          DateTime? selectedDate, Function(DateTime) callback) =>
      SizedBox(
        height: 35.h,
        child: CupertinoDatePicker(
            minimumYear: 1970,
            maximumYear: DateTime.now().year,
            initialDateTime: selectedDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (dateTime) => callback(dateTime)),
      );
  static Widget buildTimePicker(
          DateTime selectedTime, Function(DateTime) callback) =>
      SizedBox(
        height: 35.h,
        child: CupertinoDatePicker(
            minimumYear: 1970,
            maximumYear: DateTime.now().year,
            initialDateTime: selectedTime,
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (dateTime) => callback(dateTime)),
      );
  static Map<String, String> getFirstAndLastDates() {
    DateTime date = DateTime.now();
    DateTime firstDateOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDateOfThirdMonth = DateTime(date.year, date.month + 3, 0);

    String firstDateFormatted =
        DateFormat('yyyy-MM-dd').format(firstDateOfMonth);
    String lastDateFormatted =
        DateFormat('yyyy-MM-dd').format(lastDateOfThirdMonth);

    return {
      'startDate': firstDateFormatted,
      'endDate': lastDateFormatted,
    };
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    // Check email format using a regular expression
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[a-zA-Z]{2,})+$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null; // Return null if validation passes
  }

  static DateTime combineDateTime(String date, String time) {
    return DateTime.parse('$date $time');
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 16) {
      return 'Please enter phone number  (+47) XXX XX XXX';
    }

    return null;
  }

  static DateTime calculateMonth(int index) {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month + index;

    if (index < 0) {
      // Adjust for indexes in the past
      while (month <= 0) {
        year -= 1;
        month += 12; // Increment month by 12 when going back one year
      }
    } else {
      // Adjust for indexes in the future
      while (month > 12) {
        year += 1;
        month -= 12; // Decrement month by 12 when going forward one year
      }
    }

    return DateTime(year, month);
  }

  static int abs(int val) => val < 0 ? -val : val;

  static String? checkboxValidator(bool? value) {
    if (value == false) {
      return 'You need to agree to the terms.';
    }
    return null;
  }

  static MayDayIconType getReminderIconType(String reminderType) {
    switch (reminderType) {
      case "medication":
        return MayDayIconType.medicationReminder;
      case "contraception":
        return MayDayIconType.contraceptionReminder;
      case "period":
        return MayDayIconType.periodReminder;
      default:
        return MayDayIconType.trackingIncomplete;
    }
  }

  static String cleanJsonString(String input) {
    String cleanedString = input.replaceAll("\\", "").trim();
    if (cleanedString.startsWith("\"") && cleanedString.endsWith("\"")) {
      cleanedString = cleanedString.substring(1, cleanedString.length - 1);
    }
    return cleanedString;
  }

  static double calculatePercentageDiscount(
      double originalPrice, double discountedPrice) {
    double discountAmount = originalPrice - discountedPrice;
    double percentageDiscount = (discountAmount / originalPrice) * 100;
    return percentageDiscount;
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime.toLocal());
  }

  static String? formatDateTimetoMonthYear(String? dateTimeString) {
    if (dateTimeString != null) {
      DateTime? parsedDate = DateTime.tryParse(dateTimeString);
      if (parsedDate != null) {
        DateTime localDate = parsedDate.toLocal();
        return DateFormat('MMM d').format(localDate);
      }

      return "";
    }

    return null;
  }

  static String? formatDateTime(String? dateTimeString) {
    if (dateTimeString != null) {
      DateTime? parsedDate = DateTime.tryParse(dateTimeString);
      if (parsedDate != null) {
        DateTime localDate = parsedDate.toLocal();
        return DateFormat('dd MMM, yyyy').format(localDate);
      }

      return "";
    }

    return null;
  }

  static int stringToHash(String input) {
    int hash = 5381;
    for (int i = 0; i < input.length; i++) {
      hash = (hash * 33) ^ input.codeUnitAt(i);
    }
    return hash;
  }

  static Widget createIcon(String iconAddress) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          iconAddress,
        ),
      ),
    );
  }

  static IconData getPhaseIcon(String phase) {
    switch (phase) {
      case 'follicular phase':
        return AppCustomIcons.follicular;
      case 'luteal phase':
        return AppCustomIcons.luteal;
      case 'ovulation phase':
        return AppCustomIcons.ovulation;
      case 'menstruation phase':
        return AppCustomIcons.drip;
      default:
        return AppCustomIcons.drip;
    }
  }

  static void showSheet(BuildContext context,
          {required Widget child, required VoidCallback onClicked}) =>
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [child],
                cancelButton: CupertinoActionSheetAction(
                    onPressed: onClicked, child: const Text("Done")),
              ));

  static String generateEventLink(
      String staticURL, List<BodyPart> bodyParts, PainEventsCategory event) {
    String name = bodyParts.length == 1
        ? bodyParts[0].nameForUser.replaceAll(" ", "-")
        : bodyParts[0].category1!.replaceAll(" ", "-");
    return "$staticURL/$name/event/${event.toString().split(".")[1]}";
  }

  static String generateLinkByUserIdDateAndTime(
      String url, String userId, String date, String? time) {
    return time == null
        ? url
            .replaceAll("userIdPlaceholder", userId)
            .replaceAll("datePlaceholder", date)
        : url
            .replaceAll("userIdPlaceholder", userId)
            .replaceAll("datePlaceholder", date)
            .replaceAll("timeOfDayPlaceHolder", time);
  }

  static String generateLinkByUserId(String url, String userId) {
    return url.replaceAll("userIdPlaceholder", userId);
  }

  static int customRound(double value) {
    double decimalPart = value - value.floor();
    if (decimalPart >= 0.8) {
      return value.ceil();
    }
    return value.floor();
  }

  static SymptomCategory getSymptomCategoryFromString(String title) {
    if (title == "Hormones") {
      return SymptomCategory.Hormones;
    } else if (title == "OvulationTest") {
      return SymptomCategory.Ovulation_test;
    } else if (title == "PregnancyTest") {
      return SymptomCategory.Pregnancy_test;
    } else if (title == "Dr Visit") {
      return SymptomCategory.Dr_Visit;
    } else if (title == "Sex") {
      return SymptomCategory.Intimacy;
    } else if (title == "Brain fog") {
      return SymptomCategory.Brain_Fog;
    } else if (title == "Headache") {
      return SymptomCategory.Headache;
    } else if (title.toLowerCase() == "bowel movement") {
      return SymptomCategory.Bowel_movement;
    } else if (title.toLowerCase() == "urination") {
      return SymptomCategory.Urination;
    }
    else if (title.toLowerCase() == "painkillers") {
      return SymptomCategory.Pain_Killers;
    } else if (title.toLowerCase() == "self-care") {
      return SymptomCategory.Self_Care;
    } else if (title.toLowerCase() == "pain relief") {
      return SymptomCategory.Pain_Relief;
    }

    title = title.replaceAll(" ", "_");
    int index = SymptomCategory.values.indexWhere(
      (category) => category.toString().split('.').last == title,
    );

    return SymptomCategory.values[index];
  }

  static double getPainLevelTextMargin(int? selectedPainLevel) {
    double leftMargin = 0;

    switch (selectedPainLevel!) {
      case 1:
        leftMargin = 0.0;
        break;
      case 2:
        leftMargin = 5.w;
        break;

      case 3:
        leftMargin = 10.w;
        break;

      case 4:
        leftMargin = 20.w;
        break;

      case 5:
        leftMargin = 24.w;
        break;

      case 6:
        leftMargin = 45.w;
        break;

      case 7:
        leftMargin = 52.w;
        break;

      case 8:
        leftMargin = 64.w;
        break;

      case 9:
        leftMargin = 64.w;
        break;

      case 10:
        leftMargin = 66.w;
        break;
    }
    return leftMargin;
  }

  static PainEventsCategory getPainEventsCategoryFromString(String title) {
    title = title.replaceAll(" ", "_");

    if (title == "I’m_just_existing") {
      return PainEventsCategory.Existing;
    } else {
      PainEventsCategory category = PainEventsCategory.values[
          PainEventsCategory.values.indexWhere(
              (category) => category.toString().split('.').last == title)];
      return category;
    }
  }

  static String formatDateString(String? dateStr) {
    if (dateStr == null) return "";

    try {
      DateTime parsedDate = DateFormat('yyyy-M-d').parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return "";
    }
  }

  static String validateNumeric(String? value) {
    if (value == null || value == 'NaN' || double.tryParse(value) == null) {
      return "0";
    }
    return value;
  }

  static DateTime getFirstDateOfCurrentMonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  static Container giveBackgroundToIcon(Widget icon,
      {Color? bgColor, bool? isRectangle, double? height, double? width}) {
    return Container(
      height: height ?? 50,
      width: width ?? 50,
      decoration: (isRectangle ?? false)
          ? BoxDecoration(
              shape: BoxShape.rectangle,
              color: bgColor ?? AppColors.secondaryColor400,
              borderRadius: BorderRadius.circular(6))
          : BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? AppColors.secondaryColor400),
      child: Center(
        child: icon,
      ),
    );
  }

  static showNotification(BuildContext context, String message,
      {int seconds = 1}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  static void initializeOnboarding() {
    var provider =
        Provider.of<OnboardingProvider>(AppNavigation.currentContext!);
    provider.fetchUserProgress();
  }

  static String getDeviceType() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isMacOS) {
      return 'MacOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else if (Platform.isFuchsia) {
      return 'Fuchsia';
    } else {
      return 'Unknown';
    }
  }

  static bool isNextDate(DateTime selectedDay, List<DateTime> selectedDates) {
    DateTime lastSelectedDate = selectedDates.last;
    DateTime nextDate = lastSelectedDate.add(const Duration(days: 1));
    return selectedDay.isAtSameMomentAs(nextDate);
  }

  static String getFormattedDateFromDateTime(DateTime dateTime) {
    return DateFormat("d'${getDaySuffix(dateTime.day)}' MMMM, yyyy")
        .format(dateTime);
  }

  static String getFormattedDate(SelectedDateOfUserForTracking date) {
    return DateFormat(
            "EEEE d'${getDaySuffix(DateFormat('yyyy-MM-dd').parse(date.date).day)}', MMMM")
        .format(DateFormat('yyyy-MM-dd').parse(date.date));
  }

  static List<BodyPart> getMatchingBodyParts(
      EventData eventData, List<BodyPart> availableBodyParts) {
    List<BodyPart> matchingBodyParts = [];

    if (eventData.bodyPartName != null) {
      Set<String> bodyPartNames = eventData.bodyPartName!
          .map((bp) => bp.bodyPart!.replaceAll("-", " "))
          .toSet();
      matchingBodyParts = availableBodyParts
          .where((bodyPart) => bodyPartNames.contains(bodyPart.nameForUser))
          .toList();
    }

    return matchingBodyParts;
  }

  static String? formatTimeOfDay(String? timeOfDay) {
    if (timeOfDay == "AllDay") {
      return "All Day";
    }
    return timeOfDay;
  }

  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static bool isGibberishUsername(String username) {
    final gibberishPattern = RegExp(r'^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+$');

    if (gibberishPattern.hasMatch(username)) {
      return true;
    }
    return false;
  }

  static void openCustomBottomSheet(
    BuildContext context, {
    double? height,
    Color? bgColor,
    required Widget content,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: bgColor ?? AppColors.neutralColor50,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          height: height ?? 600,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.neutralColor50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: const [AppThemes.shadowUp],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: content,
        );
      },
    );
  }

  static bool isArticleLocked(accessType) {
    if (UserManager().isPremium) {
      return false;
    } else if (!UserManager().isPremium && accessType) {
      return true;
    } else if (!UserManager().isPremium && !accessType) {
      return false;
    } else {
      return false;
    }
  }

  static bool isJourneyLocked(String? accessType) {
    final premiumUser = UserManager().isPremium;
    final isPremiumContent = (accessType ?? '').toLowerCase() == 'premium';
    final premiumLike =
        isPremiumContent || accessType == null || accessType.isEmpty;
    return premiumLike && !premiumUser;
  }

  static String getCurrencySymbol(String currencyCode) {
    String currencySymbol =
        NumberFormat.simpleCurrency(name: currencyCode).currencySymbol;
    return currencySymbol;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
}

void listenNotifications() => LocalNotificationsHelper.onNotifications.stream
    .listen(onClickedNotification);
void onClickedNotification(String? payLoad) {
  // AppNavigation.navigateTo(AppRoutes.notifications);
}

class UniqueTagGenerator {
  static int _counter = 0;

  static String generate() {
    _counter++;
    return 'SnackBarHeroTag_${DateTime.now().millisecondsSinceEpoch}_$_counter';
  }
}
