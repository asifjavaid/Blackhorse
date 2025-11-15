// import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Cycle/cycle_predictions.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class CycleHelper {
  static Map<DateTime, List<CycleDayEvent>> generateEvents(CycleCalendarAPI apiResponse) {
    Map<DateTime, List<CycleDayEvent>> eventMap = {};

    apiResponse.calendarData?.forEach((calendarData) {
      String? dateStr = calendarData.date;
      if (dateStr != null) {
        String dateTimeString = "${dateStr}T00:00:00Z";
        DateTime date = DateTime.parse(dateTimeString);
        List<CycleDayEvent> eventList = calendarData.events?.cast<CycleDayEvent>() ?? [];
        eventMap[date] = eventList;
      }
    });

    return eventMap;
  }

  static Future<List<DailyTrackerAnswers>> computeAddPeriodPayload(List<DateTime> periodDates, Map<DateTime, List<CycleDayEvent>> eventMap) async {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    var userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    return periodDates.map((date) {
      var event = eventMap[date]?[0];
      String? intensity = event?.intensity;
      return DailyTrackerAnswers(date: dateFormat.format(date), timeOfDay: "AllDay", answer: intensity != null ? [intensity] : [], userId: userId);
    }).toList();
  }

  static List<String> computeRemovePeriodPayload(List<DateTime> periodDates) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return periodDates.map((date) => dateFormat.format(date)).toList();
  }

  static Set<DateTime> extractBleedingDates(Map<DateTime, List<CycleDayEvent>> eventMap) {
    Set<DateTime> bleedingDates = {};
    for (var entry in eventMap.entries) {
      for (var event in entry.value) {
        if (event.type == 'Bleeding') {
          bleedingDates.add(entry.key);
          break;
        }
      }
    }
    return bleedingDates;
  }

  static clonePeriodEvents(Map<DateTime, List<CycleDayEvent>> events) {
    Map<DateTime, List<CycleDayEvent>> clonedPeriodEvents = {};
    events.forEach((date, events) {
      var bleedingEvents = events.where((event) => event.type == 'Bleeding').toList();
      if (bleedingEvents.isNotEmpty) {
        clonedPeriodEvents[date] = bleedingEvents;
      }
    });

    return clonedPeriodEvents;
  }

  static DateChanges computeAddedAndRemovedDates(Map<DateTime, List<CycleDayEvent>> originalEvents, Map<DateTime, List<CycleDayEvent>> modifiedEvents) {
    Set<DateTime> originalBleedingDates = extractBleedingDates(originalEvents);
    Set<DateTime> bleedingDates = extractBleedingDates(modifiedEvents);

    List<DateTime> addedDates = bleedingDates.difference(originalBleedingDates).toList();
    List<DateTime> removedDates = originalBleedingDates.difference(bleedingDates).toList();
    DateChanges dateChanges = DateChanges(addedDates: addedDates, removedDates: removedDates);
    return dateChanges;
  }

  static Future<DateChanges> computeDifferencesInDates(Map<DateTime, List<CycleDayEvent>> originalEvents, Map<DateTime, List<CycleDayEvent>> modifiedEvents) async {
    return CycleHelper.computeAddedAndRemovedDates(originalEvents, modifiedEvents);
  }
}
