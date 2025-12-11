import 'dart:developer';

import 'package:ekvi/Screens/Ekvipedia/ekvipedia_screen.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/l10n/app_localizations.dart';

import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/Insights/insights_amplitude_events.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Providers/Insights/insights_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Insights/insights_screen.dart';
import 'package:ekvi/Screens/CycleCalendar/cycle_calendar_screen.dart';
import 'package:ekvi/Screens/DailyTracker/daily_tracker.dart';
import 'package:ekvi/Screens/Dashboard/dashboard.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';

import '../../generated/assets.dart';

List<PersistentTabConfig> _navBarsTabs(BuildContext context) {
  return [
    PersistentTabConfig(
      screen: const Dashboard(),
      item: ItemConfig(
        icon: SvgPicture.asset(
          Assets.customiconsHomeFilled,
          color: AppColors.actionColor600,
          height: 16,
          width: 16,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.customiconsHome,
          color: AppColors.actionColor500,
          height: 18,
          width: 18,
        ),
        title: AppLocalizations.of(context)!.home,
        textStyle:
            Theme.of(AppNavigation.currentContext!).textTheme.labelMedium!,
        activeForegroundColor: AppColors.actionColor600,
        activeColorSecondary: AppColors.actionColor400,
        inactiveForegroundColor: AppColors.actionColor500,
      ),
    ),
    PersistentTabConfig(
      screen: const CycleCalendarScreen(),
      item: ItemConfig(
        icon: SvgPicture.asset(
          Assets.customiconsVector,
          color: AppColors.actionColor600,
          height: 16,
          width: 16,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.customiconsMyDay,
          color: AppColors.actionColor500,
          height: 16,
          width: 16,
        ),
        title: AppLocalizations.of(context)!.cycle,
        textStyle:
            Theme.of(AppNavigation.currentContext!).textTheme.labelMedium!,
        activeForegroundColor: AppColors.actionColor600,
        activeColorSecondary: AppColors.actionColor400,
        inactiveForegroundColor: AppColors.actionColor500,
      ),
    ),
    PersistentTabConfig(
      screen: const DailyTracker(),
      item: ItemConfig(
        icon: SvgPicture.asset(
          Assets.customiconsPlus,
          color: AppColors.actionColor600,
          height: 16,
          width: 16,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.customiconsPlus,
          color: AppColors.actionColor500,
          height: 16,
          width: 16,
        ),
        title: AppLocalizations.of(context)!.tracking,
        textStyle:
            Theme.of(AppNavigation.currentContext!).textTheme.labelMedium!,
        activeForegroundColor: AppColors.actionColor600,
        activeColorSecondary: AppColors.actionColor400,
        inactiveForegroundColor: AppColors.actionColor500,
      ),
    ),
    PersistentTabConfig(
      screen: InsightsScreen(
        arguments: ScreenArguments(cycleHistoryOpenedFromBottomnav: true),
      ),
      item: ItemConfig(
        icon: SvgPicture.asset(
            Assets.customiconsHeartFilled,
            height: 16,
            width: 16,
            color: AppColors.actionColor600
        ),
        inactiveIcon: SvgPicture.asset(
            Assets.customiconsHeart,
            height: 16,
            width: 16,
            color: AppColors.actionColor500
        ),
        title: AppLocalizations.of(context)!.insights,
        textStyle:
            Theme.of(AppNavigation.currentContext!).textTheme.labelMedium!,
        activeForegroundColor: AppColors.actionColor600,
        activeColorSecondary: AppColors.actionColor400,
        inactiveForegroundColor: AppColors.actionColor500,
      ),
    ),
    PersistentTabConfig(
      screen: const EkvipediaScreen(),
      item: ItemConfig(
        icon: SvgPicture.asset("${AppConstant.assetIcons}ekvipedia.svg"),
        inactiveIcon: SvgPicture.asset(
            Assets.customiconsEkvipedia,
            height: 16,
            width: 16,
            color: AppColors.actionColor500
        ),
        title: "Ekvipedia",
        textStyle: Theme.of(AppNavigation.currentContext!)
            .textTheme
            .labelMedium!
            .copyWith(
              color: AppColors.actionColor600,
            ),
        activeForegroundColor: AppColors.actionColor600,
        activeColorSecondary: AppColors.actionColor400,
        inactiveForegroundColor: AppColors.actionColor500,
      ),
    ),
  ];
}

class BottomNavManager extends StatefulWidget {
  const BottomNavManager({super.key});

  @override
  State<BottomNavManager> createState() => _BottomNavManagerState();
}

class _BottomNavManagerState extends State<BottomNavManager> {
  int? previousIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, value, child) => PersistentTabView(
              controller: value.controllerForBottomNavigation,
              tabs: _navBarsTabs(context),
              navBarHeight: 56,
              backgroundColor: Colors.white,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: false,
              onTabChanged: (index) {
                if (!value.isProgrammaticTabChange && previousIndex != index) {
                  handleTabApiCalls(index);
                  previousIndex = index;
                }
                value.setProgrammaticTabChange(false);
              },
              navBarBuilder: (navBarConfig) =>
                  Style2BottomNavBar(navBarConfig: navBarConfig),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                  curve: Curves.ease, duration: Duration(milliseconds: 400)),
            ));
  }

  void handleTabApiCalls(int index) {
    try {
      switch (index) {
        case 0:
          // Provider.of<DashboardProvider>(AppNavigation.currentContext!, listen: false).callDashboardApi();
          break;
        case 1:
          Provider.of<CycleCalendarProvider>(AppNavigation.currentContext!,
                  listen: false)
              .fetchCycleCalendarData();
          break;
        case 2:
          DailyTrackerAccessedEvent(
                  accessMethod: "Bottom Navigation",
                  dateAccessed: DateTime.now(),
                  userSegment: "N/A")
              .log();
          Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!,
                  listen: false)
              .updateSelectedDateOfUserForTracking(
                  DateFormat('yyyy-MM-dd').format(DateTime.now()));
          break;
        case 3:
          InsightsAccessedEvent(
                  accessMethod: "Bottom Navigation",
                  dateAccessed: DateTime.now(),
                  userSegment: "N/A")
              .log();
          Provider.of<InsightsProvider>(AppNavigation.currentContext!,
                  listen: false)
              .callAllInsightsAPIs();
          break;
      }
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
  }
}
