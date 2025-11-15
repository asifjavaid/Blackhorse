import 'package:ekvi/Components/DailyTracker/calendar_date_button.dart';
import 'package:ekvi/Models/DailyTracker/categories_by_date.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyTrackerUIHelper {
  static Widget defaultBuilder(context, day, focusedDay) {
    final dayName = DateFormat('E').format(day);
    return CalendarDateButton(currentDate: day, dayName: dayName, isFutureDate: false, isSelected: false, isToday: false);
  }

  static Widget disabledBuilder(context, day, focusedDay) {
    final dayName = DateFormat('E').format(day);
    return CalendarDateButton(currentDate: day, dayName: dayName, isFutureDate: true, isSelected: false, isToday: false);
  }

  static Widget selectedBuilder(context, day, focusedDay) {
    final dayName = DateFormat('E').format(day);
    return CalendarDateButton(currentDate: day, dayName: dayName, isFutureDate: false, isSelected: true, isToday: false);
  }

  static Widget todayBuilder(context, day, focusedDay) {
    final dayName = DateFormat('E').format(day);
    return CalendarDateButton(currentDate: day, dayName: dayName, isFutureDate: false, isSelected: false, isToday: true);
  }

  static Color getPainScaleColor(int level) {
    if (level <= 3) return AppColors.successColor500;
    if (level <= 7) return AppColors.accentColorTwo500;
    return AppColors.errorColor500;
  }

  static Color getMoodScaleColor(int level) {
    if (level <= 3) return AppColors.errorColor500;
    if (level <= 7) return AppColors.accentColorTwo500;
    return AppColors.successColor500;
  }

  static List<EventData> sortPainByTimeOfDay(List<EventData> data) {
    List<String> order = [
      'Morning',
      'Afternoon',
      'Evening',
      'Night',
      'AllDay',
    ];

    data.sort((a, b) {
      return order.indexOf(a.timeOfDay!) - order.indexOf(b.timeOfDay!);
    });

    return data;
  }

  static List<Answers> sortAnswersByTimeOfDay(List<Answers> data) {
    List<String> order = [
      'Morning',
      'Afternoon',
      'Evening',
      'Night',
      'AllDay',
    ];

    data.sort((a, b) {
      return order.indexOf(a.timeOfDay!) - order.indexOf(b.timeOfDay!);
    });

    return data;
  }

  static String getBleedingIcon(String intensity) {
    for (var option in DataInitializations.categoriesData().bleeding.options) {
      if (option.text == intensity) {
        return option.trailingIcon!;
      }
    }
    return "${AppConstant.assetIcons}no_bleeding.svg";
  }

  static Color getBowelMovementColor(int level) {
    if (level <= 2) return AppColors.errorColor500;
    if (level > 2 && level <= 4) return AppColors.accentColorTwo500;
    if (level > 4 && level <= 6) return AppColors.successColor500;
    if (level > 6 && level <= 8) return AppColors.accentColorTwo500;
    if (level > 8 && level <= 10) return AppColors.errorColor500;
    return AppColors.errorColor500;
  }
}
