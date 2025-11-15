import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Providers/LocaleProvider/locale_provider.dart';
import 'package:ekvi/Screens/CycleCalendar/cycle_predictions_ui_helper.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthCalendarWidget extends StatelessWidget {
  final DateTime focusedDay;

  const MonthCalendarWidget({super.key, required this.focusedDay});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CycleCalendarProvider, LocaleProvider>(
        builder: (context, value, value2, child) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ContentBox(
                width: 92.w,
                listView: false,
                showShadow: false,
                bgColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                children: [
                  TableCalendar(
                    locale: Localizations.localeOf(context).toString(),
                    availableGestures: AvailableGestures.none,
                    rowHeight: 67,
                    calendarStyle: CyclePredictionsUIHelper.buildCalendarStyle(),
                    headerStyle: CyclePredictionsUIHelper.buildHeaderStyle(),
                    daysOfWeekStyle: CyclePredictionsUIHelper.buildDaysOfWeekStyle(),
                    calendarFormat: CalendarFormat.month,
                    firstDay: DateTime(focusedDay.year, focusedDay.month, 1),
                    lastDay: DateTime(focusedDay.year, focusedDay.month + 1, 0),
                    focusedDay: focusedDay,
                    eventLoader: value.getEventsForDay,
                    daysOfWeekHeight: 33,
                    selectedDayPredicate: (day) => isSameDay(day, value.selectedCycleDay.date),
                    enabledDayPredicate: value.isEditMode
                        ? (day) {
                            DateTime today = DateTime.now();
                            return !day.isAfter(DateTime.utc(today.year, today.month, today.day));
                          }
                        : null,
                    onDaySelected: value.isEditMode
                        ? (selectedDay, focusedDay) {
                            value.handlePeriodEditing(selectedDay);
                          }
                        : value.handleViewCycleDaySymptoms,
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: value.eventMarkerBuilder,
                      defaultBuilder: CyclePredictionsUIHelper.defaultBuilder,
                      disabledBuilder: CyclePredictionsUIHelper.disabledBuilder,
                      todayBuilder: CyclePredictionsUIHelper.todayBuilder,
                      selectedBuilder: CyclePredictionsUIHelper.selectedBuilder,
                    ),
                  ),
                ],
              ),
            ));
  }
}
