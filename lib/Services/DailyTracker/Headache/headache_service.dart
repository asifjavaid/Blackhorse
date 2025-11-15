import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/Headache/headache_model.dart';
import 'package:ekvi/Models/DailyTracker/Headache/headache_insights_models.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class HeadacheService {
  static Future<Either<dynamic, void>> saveHeadacheAnswers(
    HeadacheRequestModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
          ApiLinks.saveHeadache, jsonEncode(data.toJson()));
      AmplitudeHeadacheDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, SymptomFeedback>>
      getHeadacheFeedbackStatus() async {
    return await ApiManager.safeApiCall(() async {
      String? userId =
          await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getHeadacheFeedback(userId!),
      );
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, SymptomFeedback>> updateHeadacheFeedbackStatus(
      String id, bool answer) async {
    return await ApiManager.safeApiCall(() async {
      String? userId =
          await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpPatchRequest(
          ApiLinks.updateHeadacheFeedback(id),
          jsonEncode({"userId": userId, "answer": answer}));
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, HeadacheResponseModel>> getHeadacheDataFromApi(
      String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId =
          await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getHeadacheData(userId!, date, timeOfDay),
      );
      HeadacheResponseModel responseModel =
          HeadacheResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteHeadacheData(
      List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(
          ApiLinks.deleteHeadache, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }

  // Insights API methods
  static Future<Either<dynamic, InsightsGraphModel>>
      fetchInsightsAverageHeadacheGraphFromApi(String tenure,
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
          "${ApiLinks.getInsights}/$userId/symptoms/headache/graphs/average-max/tenure/$tenure/average",
          queryParams: queryParams);
      final InsightsGraphModel responseModel =
          InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>>
      fetchInsightsMaximumHeadacheGraphFromApi(String tenure,
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
          "${ApiLinks.getInsights}/$userId/symptoms/headache/graphs/average-max/tenure/$tenure/max",
          queryParams: queryParams);
      final InsightsGraphModel responseModel =
          InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, HeadacheTagList>>
      fetchInsightsHeadacheTagsAndGridData(String tenure,
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
          "${ApiLinks.getInsights}/$userId/symptoms/headache/tenure/$tenure",
          queryParams: queryParams);

      final HeadacheTagList responseModel = HeadacheTagList.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>>
      fetchInsightsHeadacheDurationGraphFromApi(String tenure,
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
          "${ApiLinks.getInsights}/$userId/symptoms/headache/graphs/average-max/tenure/$tenure/duration",
          queryParams: queryParams);
      final InsightsGraphModel responseModel =
          InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }
}
