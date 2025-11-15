import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Models/WellnessWeekly/wellness_weekly_models.dart';
import 'package:ekvi/Models/WellnessWeekly/wins_of_the_week_model.dart';
import 'package:ekvi/Models/WellnessWeekly/symptom_shifts_model.dart';
import 'package:ekvi/Models/WellnessWeekly/affirmations_model.dart';
import 'package:ekvi/Models/WellnessWeekly/wellbeing_practices_model.dart';
import 'package:ekvi/Models/WellnessWeekly/wellbeing_levels_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:intl/intl.dart';

class WellnessWeeklyService {
  static Future<Either<dynamic, WellnessWeeklyPopupResponse>>
      getPopupStatus() async {
    return await ApiManager.safeApiCall(
      () async {
        final userId = UserManager().userId;
        final endpoint =
            '/api/wellness-weekly/$userId/wellness-weekly-popup-status';
        final response = await ApiBaseHelper.httpGetRequest(endpoint);
        final WellnessWeeklyPopupResponse responseModel =
            WellnessWeeklyPopupResponse.fromJson(response);
        return responseModel;
      },
      showLoader: true,
    );
  }

  /// Dismiss wellness weekly popup
  static Future<Either<dynamic, bool>> dismissPopup() async {
    return await ApiManager.safeApiCall(
      () async {
        final userId = UserManager().userId;
        final endpoint =
            '/api/wellness-weekly/$userId/wellness-weekly-popup-dismissed';
        await ApiBaseHelper.httpPostRequest(endpoint, jsonEncode({}));

        // will handle according to backend response later
        return true;
      },
      showLoader: true,
    );
  }

  /// Get wellness weekly report
  static Future<Either<dynamic, Map<String, dynamic>>>
      getWellnessWeeklyReport() async {
    return await ApiManager.safeApiCall(
      () async {
        final userId = UserManager().userId;
        final endpoint = '/api/wellness-weekly/$userId/report';
        final response = await ApiBaseHelper.httpGetRequest(endpoint);

        return response as Map<String, dynamic>;
      },
      showLoader: true,
    );
  }

  /// Get wins of the week
  static Future<Either<dynamic, WinsOfTheWeekModel>> getWinsOfTheWeek(
      String weekStartDate) async {
    return await ApiManager.safeApiCall(
      () async {
        // final userId = UserManager().userId;
        // // final endpoint =
        // //     '/api/wellness-weekly/$userId/wins-of-the-week?week_start_date=$weekStartDate';

        // final response = await ApiBaseHelper.httpGetRequest(endpoint);
        // return WinsOfTheWeekModel.fromJson(response);

        // Hardcoded response for now
        await Future.delayed(const Duration(milliseconds: 500));
        return WinsOfTheWeekModel(
          weekStartDate: weekStartDate,
          state: 'no_data', // Can be: 'wins', 'mixed', 'no_wins', 'no_data'
          lowestPainDay: 'Wednesday',
          lowPainDaysCount: 4,
          highestMoodDay: 'Friday',
          highMoodDaysCount: 5,
        );
      },
      showLoader: false,
    );
  }

  static String getCurrentWeekStartDate() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return '${monday.year.toString().padLeft(4, '0')}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
  }

  /// Get symptom shifts
  static Future<Either<dynamic, SymptomShiftsModel>> getSymptomShifts(
      String weekStartDate) async {
    return await ApiManager.safeApiCall(
      () async {
        // final userId = UserManager().userId;
        // final endpoint =
        //     '/api/wellness-weekly/$userId/symptom-shifts?week_start_date=$weekStartDate';

        // final response = await ApiBaseHelper.httpGetRequest(endpoint);
        // return SymptomShiftsModel.fromJson(response);

        // Hardcoded response for now
        await Future.delayed(const Duration(milliseconds: 500));
        return SymptomShiftsModel(
          weekStartDate: weekStartDate,
          state: 'wins', // Can be: 'wins', 'mixed', 'no_wins', 'no_data'
          symptomShifts: [
            SymptomShift(
              symptom: 'pain',
              percentChange: -25,
              currentWeekAvg: 3.2,
              previousWeekAvg: 4.3,
              symptomType: 'negative',
              isImprovement: true,
            ),
            SymptomShift(
              symptom: 'mood',
              percentChange: 15,
              currentWeekAvg: 7.8,
              previousWeekAvg: 6.8,
              symptomType: 'positive',
              isImprovement: true,
            ),
            SymptomShift(
              symptom: 'bleeding',
              percentChange: -20,
              currentWeekAvg: 2.1,
              previousWeekAvg: 2.6,
              symptomType: 'negative',
              isImprovement: true,
            ),
          ],
        );
      },
      showLoader: false,
    );
  }

  /// Get affirmations
  static Future<Either<dynamic, AffirmationsModel>> getAffirmations(
      String weekStartDate) async {
    return await ApiManager.safeApiCall(
      () async {
        // final userId = UserManager().userId;
        // final endpoint =
        //     '/api/wellness-weekly/$userId/affirmations?week_start_date=$weekStartDate';

        // final response = await ApiBaseHelper.httpGetRequest(endpoint);
        // return AffirmationsModel.fromJson(response);

        // Hardcoded response for now
        await Future.delayed(const Duration(milliseconds: 500));
        return AffirmationsModel(
          overallReportType:
              'wins', // Can be: 'wins', 'mixed', 'no_wins', 'no_data'
          affirmations: [
            Affirmation(
              id: 'uuid-1',
              text: "You're doing the work. These shifts matter.",
              category: 'wins',
              theme: 'celebration',
              displayOrder: 1,
            ),
            Affirmation(
              id: 'uuid-2',
              text: "Your body is responding to your care. Keep listening.",
              category: 'wins',
              theme: 'validation',
              displayOrder: 2,
            ),
            Affirmation(
              id: 'uuid-3',
              text:
                  "Small wins add up to big changes. You're building something beautiful.",
              category: 'wins',
              theme: 'progress',
              displayOrder: 3,
            ),
          ],
          metadata: AffirmationsMetadata(
            totalAvailable: 15,
            category: 'wins',
            rotationApplied: true,
            selectionMethod: 'report_type_based',
          ),
        );
      },
      showLoader: false,
    );
  }

  /// Get wellbeing practices
  static Future<Either<dynamic, WellbeingPracticesModel>> getWellbeingPractices(
      String weekStartDate) async {
    return await ApiManager.safeApiCall(
      () async {
        // final userId = UserManager().userId;
        // final endpoint =
        //     '/api/wellness-weekly/$userId/wellbeing-practices?week_start_date=$weekStartDate';

        // final response = await ApiBaseHelper.httpGetRequest(endpoint);
        // return WellbeingPracticesModel.fromJson(response);

        // Hardcoded response for now
        await Future.delayed(const Duration(milliseconds: 500));
        return WellbeingPracticesModel(
          weekStartDate: weekStartDate,
          state: 'wins', // Can be: 'wins', 'mixed', 'no_wins', 'no_data'
          practices: [
            WellbeingPractice(
              practiceName: 'Walking',
              emoji: '🚶‍♂️',
              count: 12,
              category: 'movement',
            ),
            WellbeingPractice(
              practiceName: 'Meditation',
              emoji: '🧘‍♀️',
              count: 8,
              category: 'self_care',
            ),
            WellbeingPractice(
              practiceName: 'Journaling',
              emoji: '✏️',
              count: 6,
              category: 'self_care',
            ),
            WellbeingPractice(
              practiceName: 'Yoga',
              emoji: '🧘',
              count: 5,
              category: 'movement',
            ),
            WellbeingPractice(
              practiceName: 'Weightlifting',
              emoji: '🏋️',
              count: 3,
              category: 'movement',
            ),
            WellbeingPractice(
              practiceName: 'Bubble bath',
              emoji: '🛁',
              count: 2,
              category: 'self_care',
            ),
            WellbeingPractice(
              practiceName: 'Movie night',
              emoji: '🍿',
              count: 1,
              category: 'self_care',
            ),
            WellbeingPractice(
              practiceName: 'Reading',
              emoji: '📚',
              count: 4,
              category: 'self_care',
            ),
          ],
          summary: WellbeingSummary(
            totalPractices: 8,
            totalEntries: 41,
            selfCareCount: 5,
            movementCount: 3,
          ),
        );
      },
      showLoader: false,
    );
  }

  /// Get wellbeing levels
  static Future<Either<dynamic, WellbeingLevelsModel>> getWellbeingLevels(
      String weekStartDate) async {
    return await ApiManager.safeApiCall(
      () async {
        // final userId = UserManager().userId;
        // final endpoint =
        //     '/api/wellness-weekly/$userId/wellbeing-levels?week_start_date=$weekStartDate';

        // final response = await ApiBaseHelper.httpGetRequest(endpoint);
        // return WellbeingLevelsModel.fromJson(response);

        // Hardcoded response for now
        await Future.delayed(const Duration(milliseconds: 500));
        return WellbeingLevelsModel(
          hasSufficientData: true,
          state: 'no_data', // Can be: 'wins', 'mixed', 'no_wins', 'no_data'
          dailyAverages: [
            DailyAverage(
              day: 'Monday',
              moodAvg: 6.5,
              energyAvg: 5.8,
              stressAvg: 4.2,
              date: '2024-01-15',
            ),
            DailyAverage(
              day: 'Tuesday',
              moodAvg: 7.2,
              energyAvg: 6.1,
              stressAvg: 3.8,
              date: '2024-01-16',
            ),
            DailyAverage(
              day: 'Wednesday',
              moodAvg: 6.8,
              energyAvg: 5.9,
              stressAvg: 4.0,
              date: '2024-01-17',
            ),
            DailyAverage(
              day: 'Thursday',
              moodAvg: 7.5,
              energyAvg: 6.3,
              stressAvg: 3.5,
              date: '2024-01-18',
            ),
            DailyAverage(
              day: 'Friday',
              moodAvg: 7.8,
              energyAvg: 6.5,
              stressAvg: 3.2,
              date: '2024-01-19',
            ),
            DailyAverage(
              day: 'Saturday',
              moodAvg: 8.1,
              energyAvg: 6.8,
              stressAvg: 2.8,
              date: '2024-01-20',
            ),
            DailyAverage(
              day: 'Sunday',
              moodAvg: 7.9,
              energyAvg: 6.6,
              stressAvg: 3.0,
              date: '2024-01-21',
            ),
          ],
          weeklySummary: WeeklySummary(
            moodWeeklyAvg: 7.4,
            energyWeeklyAvg: 6.3,
            stressWeeklyAvg: 3.5,
            daysWithData: 7,
            dataCompleteness: 100.0,
          ),
        );
      },
      showLoader: false,
    );
  }

  String getWellnessWeekTenure() {
    final now = DateTime.now();

    // find Monday of this week
    final int daysToSubtract = now.weekday - DateTime.monday;
    final startOfWeek = now.subtract(Duration(days: daysToSubtract));

    // find Sunday of this week
    final int daysToAdd = DateTime.sunday - now.weekday;
    final endOfWeek = now.add(Duration(days: daysToAdd));

    // format: Aug 26 - Sep 1
    final formatter = DateFormat('MMM d');
    final startStr = formatter.format(startOfWeek);
    final endStr = formatter.format(endOfWeek);

    return '$startStr - $endStr';
  }
}
