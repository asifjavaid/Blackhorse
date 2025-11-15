import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Screens/DailyTracker/daily_tracker_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyTrackerWeeklyCalendar extends StatelessWidget {
  const DailyTrackerWeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyTrackerProvider>(
      builder: (context, value, child) {
        return SizedBox(
            width: 100.w,
            // height: 60,
            child: TableCalendar(
              headerVisible: false,
              locale: Localizations.localeOf(context).toString(),
              rowHeight: 64,
              daysOfWeekVisible: false,
              calendarFormat: CalendarFormat.week,
              firstDay: DateTime.utc(2000),
              lastDay: DateTime.utc(
                2050,
              ),
              focusedDay: value.focusedDate,
              startingDayOfWeek: StartingDayOfWeek.monday,
              enabledDayPredicate: (day) => !DateTime(day.year, day.month, day.day).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)),
              selectedDayPredicate: (day) => isSameDay(day, DateTime.parse(value.selectedDateOfUserForTracking.date)),
              calendarBuilders: const CalendarBuilders(
                defaultBuilder: DailyTrackerUIHelper.defaultBuilder,
                outsideBuilder: DailyTrackerUIHelper.defaultBuilder,
                disabledBuilder: DailyTrackerUIHelper.disabledBuilder,
                selectedBuilder: DailyTrackerUIHelper.selectedBuilder,
                todayBuilder: DailyTrackerUIHelper.todayBuilder,
              ),
            ));
      },
    );
  }
}
