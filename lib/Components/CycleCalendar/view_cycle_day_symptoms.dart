import 'package:ekvi/Models/Cycle/cycle_predictions.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';

class ViewCycleDaySymptoms extends StatelessWidget {
  const ViewCycleDaySymptoms({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CycleCalendarProvider>(context, listen: true);
    var dailyTrackerProvider = Provider.of<DailyTrackerProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: true);

    TextTheme textTheme = Theme.of(context).textTheme;
    DateTime? selectedDate = provider.selectedCycleDay.date;
    List<CycleDayEvent>? symptoms = provider.selectedCycleDay.events;
    String formattedDate = selectedDate != null ? DateFormat('MMMM d').format(selectedDate) : "";

    DateTime today = DateTime.now();
    DateTime startOfToday = DateTime(today.year, today.month, today.day);

// Normalize selectedDate to the start of its day
    DateTime selectedDateStart = selectedDate != null ? DateTime(selectedDate.year, selectedDate.month, selectedDate.day) : DateTime(0); // Fallback for null

// Check if the selected date is in the future
    bool isFuture = selectedDate != null && selectedDateStart.isAfter(startOfToday);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formattedDate, style: textTheme.headlineMedium!.copyWith(color: AppColors.blackColor)),
            const SizedBox(height: 20),
            symptoms?.isNotEmpty == true
                ? Column(
                    children: symptoms!.map((symptom) {
                      String intensity = capitalize(symptom.intensity ?? '');
                      String type = capitalize(symptom.type ?? '');
                      IconData assetName = getAssetNameForSymptomType(symptom.type ?? "");

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: [
                            HelperFunctions.giveBackgroundToIcon(
                                Icon(
                                  assetName,
                                  color: AppColors.whiteColor,
                                  size: 16,
                                ),
                                height: 32,
                                width: 32,
                                bgColor: AppColors.secondaryColor600),
                            const SizedBox(width: 16),
                            Text(
                              "$intensity $type",
                              style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : Text(
                    "Nothing has been tracked on this day",
                    style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                  ),
            isFuture
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      const SizedBox(height: 24),
                      CustomButton(
                        title: "See All Symptoms",
                        onPressed: selectedDate != null
                            ? () {
                                DailyTrackerAccessedEvent(accessMethod: "Cycle Calendar", dateAccessed: DateTime.now(), userSegment: "N/A").log();
                                dashboardProvider.setProgrammaticTabChange(true);
                                dashboardProvider.setBottomNavIndex(2);
                                dailyTrackerProvider.updateSelectedDateOfUserForTracking(DateFormat('yyyy-MM-dd').format(selectedDate), notify: true);
                              }
                            : null,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  IconData getAssetNameForSymptomType(String type) {
    switch (type) {
      case 'Bleeding':
        return AppCustomIcons.drip;
      case 'Pain':
        return AppCustomIcons.bolt;
      default:
        return AppCustomIcons.bolt;
    }
  }
}
