import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CalendarDateButton extends StatelessWidget {
  final DateTime currentDate;
  final String dayName;
  final bool isFutureDate;
  final bool isToday;
  final bool isSelected;
  const CalendarDateButton({super.key, required this.currentDate, required this.dayName, required this.isFutureDate, required this.isSelected, required this.isToday});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<DailyTrackerProvider>(builder: (context, value, child) {
      return Container(
        margin: const EdgeInsets.only(left: 6),
        child: InkWell(
          onTap: isFutureDate ? null : () => handleDateButtonPressed(value, currentDate),
          child: Container(
            width: 12.w,
            decoration: BoxDecoration(
                color: isSelected ? AppColors.secondaryColor500 : AppColors.primaryColor400,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: isToday ? AppColors.primaryColor500 : Colors.transparent)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    dayName.substring(0, 1),
                    style: textTheme.labelMedium!.copyWith(
                        color: isSelected
                            ? AppColors.neutralColor600
                            : isToday
                                ? AppColors.primaryColor600
                                : AppColors.neutralColor600),
                  ),
                  Text(
                    currentDate.day.toString().padLeft(2, '0'),
                    style: textTheme.headlineMedium!.copyWith(
                        color: isSelected
                            ? AppColors.neutralColor600
                            : isToday
                                ? AppColors.primaryColor600
                                : AppColors.neutralColor600),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void handleDateButtonPressed(DailyTrackerProvider value, DateTime currentDate) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    value.updateSelectedDateOfUserForTracking(formattedDate, notify: true);
  }
}
