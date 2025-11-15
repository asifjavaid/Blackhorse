import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_model.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/bowel_mov_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/BowelMovement/insight_bowel_movement_circle_chart_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Models/Insights/insights_time_of_day_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class BowelMovementService {
  static UserManager userManager = UserManager();

  static Future<Either<dynamic, SymptomFeedback>> getBowelMovFeedbackStatus() async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getSymptomFeedback(userManager.userId!, "bowelmovement"),
      );
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, SymptomFeedback>> patchFeedbackRequest(String id, bool answer) async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpPatchRequest(ApiLinks.updateSymptomFeedback(id), jsonEncode({"userId": userManager.userId!, "answer": answer}));
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> patchBowelMovRequest(
    BowelMovResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.saveBowelMovement, jsonEncode([data.toJson()]));
      AmplitudeBowelMovementDetails(data: data, userId: userManager.userId!).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, BowelMovResponseModel>> getBowelMovRequest(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getBowelMoveData(userManager.userId!, date, timeOfDay),
      );
      BowelMovResponseModel movResponseModel = BowelMovResponseModel.fromJson(response[0]);
      return movResponseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, BowelMovTagList>> getBowelMovTags(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/${userManager.userId}/symptoms/bowelmovement/tenure/$tenure", queryParams: queryParams);
      final BowelMovTagList responseModel = BowelMovTagList.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsBowelMovAverageGraphFromApi(
    String tenure,
    List<DateTime> selectedMonths,
    int selectedYear,
  ) async {
    return ApiManager.safeApiCall(() async {
      final userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }

      final response = await ApiBaseHelper.httpGetRequest(
        "${ApiLinks.getInsights}/$userId/symptoms/bowelmovement/graphs/average-max/tenure/$tenure/average",
        queryParams: queryParams,
      );

      return InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsTimeOfDayGraphModel>> fetchInsightsBowelMovTimeOfDayGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/bowel-movement/graphs/time-of-day/tenure/$tenure", queryParams: queryParams);
      final InsightsTimeOfDayGraphModel responseModel = InsightsTimeOfDayGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsBowelMovementCircleModel>> fetchInsightsBowelMovCircleGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      queryParams['symptoms'] = 'bowelmovement';
      /*Map<String, String> queryParams = {
        'year': selectedYear.toString(),
        if (selectedMonths.isNotEmpty) 'months': selectedMonths.map((date) => DateFormat('MMMM').format(date)).join(','),
        'symptoms': 'bowelmovement'
      };*/
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/circle", queryParams: queryParams);
      final InsightsBowelMovementCircleModel responseModel = InsightsBowelMovementCircleModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteBowelMovData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteBowelMovement, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }
}
