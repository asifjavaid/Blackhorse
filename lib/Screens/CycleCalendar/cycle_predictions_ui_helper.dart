import 'package:ekvi/Components/CycleCalendar/cycle_calendar_icon_information.dart';
import 'package:ekvi/Components/CycleCalendar/svg_circle_widget.dart';
import 'package:ekvi/Components/CycleCalendar/view_cycle_day_symptoms.dart';
import 'package:ekvi/Models/Cycle/cycle_predictions.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CyclePredictionsUIHelper {
  static Widget panelContent(PanelType panelType) {
    switch (panelType) {
      case PanelType.viewCycleCalendarInformation:
        return const CycleCalendarIconInformation();
      case PanelType.viewSymptoms:
        return const ViewCycleDaySymptoms();
      default:
        return const SizedBox.shrink();
    }
  }

  static Widget? eventMarkerForEvents(DateTime date, List<CycleDayEvent> events) {
    String? svgAssetPath;
    Color? circleColor;

    for (var event in events) {
      switch (event.type) {
        case "Bleeding":
          svgAssetPath = "${AppConstant.assetIcons}bleeding_drop.svg";
          break;

        case "Pain":
          switch (event.intensity) {
            case 'Severe':
              circleColor = AppColors.errorColor500;
              break;
            case 'Moderate':
              circleColor = AppColors.accentColorTwo500;
              break;
            case 'Mild':
              circleColor = AppColors.successColor500;
              break;
            default:
              break;
          }
          break;
        default:
      }
    }
    return events.isEmpty
        ? null
        : SvgCircleWidget(
            svgAssetPath: svgAssetPath,
            circleColor: circleColor,
            animationDuration: const Duration(seconds: 1),
          );
  }

  static Widget defaultBuilder(context, day, focusedDay) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Text(
        day.day.toString(),
      ),
    );
  }

  static Widget disabledBuilder(context, day, focusedDay) {
    return Consumer<CycleCalendarProvider>(
        builder: (context, value, child) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: value.isEditMode
                  ? Text(
                      day.day.toString(),
                      style: TextStyle(
                        color: AppColors.blackColor.withOpacity(0.3),
                      ),
                    )
                  : const SizedBox.shrink(),
            ));
  }

  static Widget todayBuilder(context, day, focusedDay) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SvgCircleWidget(
            circleColor: Colors.transparent,
            svgAssetPath: "${AppConstant.assetIcons}current_day.svg",
            animationDuration: Duration(seconds: 1),
          ),
          Text(
            day.day.toString(),
          ),
        ],
      ),
    );
  }

  static Widget selectedBuilder(context, day, focusedDay) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SvgCircleWidget(
            circleColor: AppColors.primaryColor600,
            circleBgColor: AppColors.primaryColor600,
            animationDuration: Duration(milliseconds: 300),
          ),
          Text(
            day.day.toString(),
          ),
        ],
      ),
    );
  }

  static CalendarStyle buildCalendarStyle() {
    return CalendarStyle(
      defaultTextStyle: Theme.of(AppNavigation.currentContext!).textTheme.bodyMedium!,
      markerSize: 2,
      todayTextStyle: const TextStyle(color: AppColors.blackColor),
      todayDecoration: const BoxDecoration(
        color: AppColors.secondaryColor400,
        shape: BoxShape.circle,
      ),
    );
  }

  static HeaderStyle buildHeaderStyle() {
    return HeaderStyle(
      titleCentered: true,
      formatButtonVisible: false,
      leftChevronVisible: false,
      rightChevronVisible: false,
      titleTextStyle: Theme.of(AppNavigation.currentContext!).textTheme.headlineSmall!,
    );
  }

  static DaysOfWeekStyle buildDaysOfWeekStyle() {
    return DaysOfWeekStyle(
      dowTextFormatter: (date, locale) {
        return DateFormat.EEEE(locale).format(date).substring(0, 3).toUpperCase();
      },
      weekdayStyle: Theme.of(AppNavigation.currentContext!).textTheme.labelMedium!.copyWith(color: AppColors.neutralColor500),
      weekendStyle: Theme.of(AppNavigation.currentContext!).textTheme.labelMedium!.copyWith(color: AppColors.neutralColor500),
    );
  }

  static double calculatePanelMaxHeight(SelectedCycleDay selectedDay) {
    DateTime today = DateTime.now();
    DateTime startOfToday = DateTime(today.year, today.month, today.day);
    DateTime? selectedDateStart;
    if (selectedDay.date != null) {
      selectedDateStart = DateTime(selectedDay.date!.year, selectedDay.date!.month, selectedDay.date!.day);
    }
    bool isFuture = selectedDateStart != null && selectedDateStart.isAfter(startOfToday);
    if (isFuture) return 150;
    const double baseHeightPerEvent = 35.0;
    const double minimumHeight = 212.0;
    int numberOfEvents = selectedDay.events?.length ?? 0;
    double calculatedHeight = minimumHeight + (baseHeightPerEvent * numberOfEvents);
    double maxHeight = 100.h;
    return calculatedHeight > maxHeight ? maxHeight : calculatedHeight;
  }
}
