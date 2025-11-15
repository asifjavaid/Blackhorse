import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/BodyPain/body_pain_model.dart';
import 'package:ekvi/Models/DailyTracker/categories_by_date.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_notes.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class DailyTrackerService {
  static Future<Either<dynamic, List<DailyTrackerAnswers>>> getEmotionsAnswers(
      String selectedDate, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      var userId =
          await SharedPreferencesHelper.getStringPrefValue(key: "userId");

      var response = await ApiBaseHelper.httpGetRequest(
        HelperFunctions.generateLinkByUserIdDateAndTime(
            ApiLinks.getEmotionsCategory, userId!, selectedDate, timeOfDay),
      );
      List<DailyTrackerAnswers> data = [];

      if (response.isEmpty) {
        var questions = [
          "Sexual Desire",
          "Motivation & Energy",
          "Emotional Wellbeing",
          "Stress"
        ];
        for (var i = 0; i < 4; i++) {
          data.add(DailyTrackerAnswers.from(
              {"question": questions[i], "answer": []}));
        }
      } else {
        for (var element in response) {
          data.add(DailyTrackerAnswers.from(element));
        }
      }

      return data;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> saveEvent(
      DailyTrackerEvent eventData, PainEventsCategory event) async {
    return await ApiManager.safeApiCall(() async {
      handleEventAmplitudeDetailsLogging(eventData, event);
      var response = await ApiBaseHelper.httpPatchRequest(
          ApiLinks.patchBodyPainEvent, jsonEncode([eventData.toJson()]));
      SymptomTrackingCompleted(
              symptomCategory: "Body Pain - ${eventData.name}",
              completionStatus: true)
          .log();

      return Right(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteEvent(String eventID) async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpDeleteRequest(
          "/events/$eventID", jsonEncode({}));
      return Right(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteBatchEvents(
      List<String?> eventIDs) async {
    return await ApiManager.safeApiCall(() async {
      var response =
          await ApiBaseHelper.httpDeleteRequest("/pain", jsonEncode(eventIDs));

      return Right(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteBatchCategories(
      List<String?> categoryIDs) async {
    return await ApiManager.safeApiCall(() async {
      try {
        var response = await ApiBaseHelper.httpDeleteRequest(
            "/answers", jsonEncode(categoryIDs));

        return Right(response);
      } catch (e) {
        return const Left("Something went wrong!");
      }
    }, showLoader: false);
  }

  static Future<Either<String, DailyTrackerNotes>> saveNotes(
      DailyTrackerNotes notes,
      {String? notesId}) async {
    try {
      dynamic response;
      if (notesId == null) {
        response = await ApiBaseHelper.httpPostRequest(
            ApiLinks.dailyTrackerNotes, jsonEncode(notes.toJson()));
      } else {
        response = await ApiBaseHelper.httpPatchRequest(
            ApiLinks.updateDailyTrackerNotes.replaceAll("id", notesId),
            jsonEncode(notes.toJson()));
      }
      final DailyTrackerNotes responseModel =
          DailyTrackerNotes.fromJson(response is String ? {} : response);
      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<dynamic, CompletedCategoriesByDate>>
      fetchAllCompletedCategoriesByDate(String selectedDate) async {
    return await ApiManager.safeApiCall(() async {
      var userId =
          await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
          HelperFunctions.generateLinkByUserIdDateAndTime(
              ApiLinks.getAllCompletedCategoriesByDate,
              userId!,
              selectedDate,
              null));

      final CompletedCategoriesByDate responseModel =
          CompletedCategoriesByDate.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, BodyPainTags>>
      fetchInsightsBodyPainTagsCountFromApi(String tenure,
          List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId =
          await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths
            .map((date) => DateFormat('yyyy-MMM').format(date))
            .join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest(
          "${ApiLinks.getInsights}/$userId/symptoms/pain/tenure/$tenure",
          queryParams: queryParams);
      final BodyPainTags responseModel = BodyPainTags.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
