import 'dart:io';

import 'package:ekvi/Components/DailyTracker/delete_panel.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerEdit/daily_tracker_edit.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/daily_tracker_view.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Components/DailyTracker/daily_tracker_weekly_calendar.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Routes/app_routes.dart';
import '../../generated/assets.dart';

class DailyTracker extends StatefulWidget {
  const DailyTracker({
    super.key,
  });

  @override
  State<DailyTracker> createState() => _DailyTrackerState();
}

class _DailyTrackerState extends State<DailyTracker> {
  var provider = Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!, listen: false);

  @override
  void initState() {
    super.initState();
    provider.fetchUserProfile(showLoader: false);
  }

  @override
  void dispose() {
    provider.setDailyTrackerViewMode = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientBackground(
      child: Consumer<DailyTrackerProvider>(
          builder: (context, value, child) => SlidingUpPanel(
              backdropTapClosesPanel: false,
              controller: value.panelController,
              padding: null,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              backdropEnabled: false,
              backdropOpacity: 0.6,
              renderPanelSheet: true,
              maxHeight: 15.h,
              minHeight: 0,
              panel: const DeletePanel(),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DailyTrackerHeader(),
                      value.getDailyTrackerViewMode == null
                          ? const SizedBox.shrink()
                          : value.getDailyTrackerViewMode
                              ? const DailyTrackerView()
                              : const DailyTrackerEdit(),
                    ],
                  ),
                ),
              ))),
    ));
  }
}

// ignore: must_be_immutable
class DailyTrackerHeader extends StatelessWidget {
  bool? dailyTrackerPushedAsNamedRoute;
  DailyTrackerHeader({super.key, this.dailyTrackerPushedAsNamedRoute});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!, listen: false);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: (provider.getDailyTrackerViewMode != null && provider.getDailyTrackerViewMode) ? 40 : 16, right: 16, bottom: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  AppNavigation.navigateTo(AppRoutes.createTrackingSettings).then((value) {
                    provider.fetchUserProfile(showLoader: true);
                  });
                },
                child: SvgPicture.asset(
                  height: 16,
                   width: 16,
                   color: AppColors.actionColor600,
                  "${Assets.customiconsSetting}",
                  semanticsLabel: 'Settings',
                ),
              ),
              const Spacer(),
              Text("Daily Tracker", textAlign: TextAlign.center, style: textTheme.displaySmall),
              const Spacer(),
              (provider.getDailyTrackerViewMode != null && provider.getDailyTrackerViewMode)
                  ? GestureDetector(
                      onTap: () => HelperFunctions.openCustomBottomSheet(context, content: _helpPanel(), height: Platform.isAndroid ? 300 : 330),
                      child: SvgPicture.asset(
                        "${AppConstant.assetIcons}info.svg",
                        semanticsLabel: 'Daily Tracker Info',
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const DailyTrackerWeeklyCalendar(),
        const SizedBox(height: 16),
      ],
    );
  }
}

Widget _helpPanel() {
  TextTheme textTheme = Theme.of(AppNavigation.currentContext!).textTheme;
  return SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("What does it mean?", textAlign: TextAlign.start, style: textTheme.headlineSmall!.copyWith(color: AppColors.neutralColor600)),
      const SizedBox(
        height: 24,
      ),
      Row(
        children: [
          Text(
            "1-10",
            style: textTheme.bodySmall,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Intensity of the tracked symptom",
            style: textTheme.bodySmall,
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          SvgPicture.asset("${AppConstant.assetIcons}dt_help_1.svg"),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Tracked intensity",
            style: textTheme.bodySmall,
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          SvgPicture.asset("${AppConstant.assetIcons}dt_help_2.svg"),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Tracked symptom, without intensity",
            style: textTheme.bodySmall,
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: AppColors.primaryColor500),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            width: 32,
            height: 32,
            child: Center(
              child: Text(
                '1',
                style: textTheme.bodyLarge!.copyWith(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Units tracked",
            style: textTheme.bodySmall,
          )
        ],
      ),
    ]),
  );
}
