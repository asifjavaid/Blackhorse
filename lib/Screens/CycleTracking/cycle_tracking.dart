import 'package:ekvi/Providers/CycleTracking/cycle_tracking.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Buttons/custom_field_dropdown.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class CycleTracking extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const CycleTracking({super.key, this.screenArguments});

  @override
  State<CycleTracking> createState() => _CycleTrackingState();
}

class _CycleTrackingState extends State<CycleTracking> {
  var provider = Provider.of<CycleTrackingProvider>(
      AppNavigation.currentContext!,
      listen: false);
  var dashboardProvider = Provider.of<DashboardProvider>(
      AppNavigation.currentContext!,
      listen: false);
  @override
  void initState() {
    provider.getCycleTracking();
    super.initState();
  }

  @override
  void dispose() {
    provider.setEnableButton(true, notify: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
        body: GradientBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getHeader(context),
              Consumer<CycleTrackingProvider>(
                  builder: (context, value, child) => Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 16),
                              // const TextAndSwitch(
                              //   text: "I get my periods",
                              // ),
                              const SizedBox(height: 16),
                              WhiteContainer(
                                child: _regularityWidget(
                                    value, textTheme, context),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  localizations.myCycleDetails,
                                  style: textTheme.displaySmall,
                                ),
                              ),
                              const SizedBox(height: 16),
                              WhiteContainer(
                                  width: 94.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          localizations
                                              .whenDidYourLastCycleStart,
                                          style: textTheme.headlineSmall),
                                      SizedBox(height: 2.h),
                                      CustomButton(
                                        titleAtStart: false,
                                        title: DateFormat("dd/MM/yy").format(
                                            value.selectedCycleStartDate),
                                        color: AppColors.primaryColor400,
                                        fontColor: AppColors.blackColor,
                                        tralingIcon: const Icon(
                                          AppCustomIcons.arrow_down,
                                          color: AppColors.actionColor600,
                                          size: 16,
                                        ),
                                        onPressed: () =>
                                            HelperFunctions.showSheet(context,
                                                child: buildDatePicker(),
                                                onClicked: (() =>
                                                    Navigator.pop(context))),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 16),
                              WhiteContainer(
                                  width: 94.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          localizations
                                              .howLongIsYourAverageCycle,
                                          style: textTheme.headlineSmall),
                                      SizedBox(height: 2.h),
                                      CustomFieldDropdown(
                                          options: value.lengthOptions,
                                          value: value.selectedCycleLength,
                                          getLabel: (String value) => value,
                                          onChanged: (String? newValue) =>
                                              value.setCycleLength(newValue)),
                                    ],
                                  )),
                              const SizedBox(height: 16),
                              WhiteContainer(
                                  width: 94.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          localizations
                                              .howLongIsYourAveragePeriod,
                                          style: textTheme.headlineSmall),
                                      SizedBox(height: 2.h),
                                      CustomFieldDropdown(
                                          options: value.lengthOptions,
                                          value: value.selectedPeriodLength,
                                          getLabel: (String value) => value,
                                          onChanged: (String? newValue) =>
                                              value.setPeriodLength(newValue)),
                                    ],
                                  )),
                              const SizedBox(height: 16),
                              // const TextAndSwitch(
                              //   text: "Chance of getting pregnant",
                              // ),
                              const SizedBox(height: 16),
                            ],
                          ),
                          CustomButton(
                              title: localizations.save,
                              onPressed: value.enableButton
                                  ? () => value.handleSaveCycleTracking(
                                      cycleTrackingShouldPop: widget
                                          .screenArguments
                                          ?.cycleTrackingShouldPop)
                                  : null),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      )),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  BackNavigation _getHeader(BuildContext context) {
    var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(
        AppNavigation.currentContext!,
        listen: false);
    return BackNavigation(
      title: AppLocalizations.of(context)!.cycleTracking,
      callback: () {
        if (widget.screenArguments?.cycleTrackingShouldPop ?? false) {
          dashboardProvider.callDashboardApi();
          AppNavigation.goBack();
        } else {
          sideNavManagerProvider.onSelected(
              MenuItems(AppNavigation.currentContext!).bottomNavManager);
        }
      },
    );
  }

  Column _regularityWidget(
      CycleTrackingProvider value, TextTheme textTheme, BuildContext context) {
    List<String> cycleRegularityOptions = [
      AppLocalizations.of(context)!.myCycleIsRegular,
      AppLocalizations.of(context)!.myCycleIsIrregular,
      AppLocalizations.of(context)!.iDontKnow
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppLocalizations.of(context)!.regularity,
        style: textTheme.headlineSmall,
      ),
      ...cycleRegularityOptions.map((regularity) => SizedBox(
            height: 4.h,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              shape: const Border(
                bottom: BorderSide.none,
              ),
              title: Text(regularity, style: textTheme.bodySmall),
              controlAffinity: ListTileControlAffinity.trailing,
              value: regularity,
              groupValue: value.periodRegularity,
              onChanged: (newValue) => value.setSelectedRegularity(newValue),
              activeColor: AppColors.primaryColor600,
            ),
          )),
    ]);
  }

  Widget buildDatePicker() => Consumer<CycleTrackingProvider>(
      builder: (context, value, child) => SizedBox(
            height: 35.h,
            child: CupertinoDatePicker(
                minimumYear: 2015,
                maximumYear: DateTime.now().year,
                initialDateTime: value.selectedCycleStartDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (dateTime) =>
                    value.setCycleStartDate(dateTime)),
          ));
}

// ignore: must_be_immutable
class WhiteContainer extends StatelessWidget {
  double? width;
  Widget child;
  WhiteContainer({
    super.key,
    required this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(11)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}

class TextAndSwitch extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool) callback;

  const TextAndSwitch(
      {super.key,
      required this.text,
      required this.value,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return WhiteContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: textTheme.headlineSmall,
          ),
          FlutterSwitch(
              width: 60,
              height: 35.0,
              valueFontSize: 25.0,
              toggleSize: 30.0,
              value: value,
              borderRadius: 29.0,
              activeColor: AppColors.actionColor600,
              onToggle: (val) => callback(val)),
        ],
      ),
    );
  }
}
