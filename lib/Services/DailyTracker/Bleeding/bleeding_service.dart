import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/Bleeding/bleeding_tag_count_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/Bleeding/insights_bleeding_in_circles_chart_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class BleedingService {
  static Future<Either<dynamic, DailyTrackerAnswers>> getBleedingAnswers(String selectedDate, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      var userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(HelperFunctions.generateLinkByUserIdDateAndTime(
        ApiLinks.getBleedingCategory,
        userId!,
        selectedDate,
        timeOfDay,
      ));
      return response.isEmpty ? DailyTrackerAnswers.from({"answer": []}) : DailyTrackerAnswers.from(response[0]);
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> saveBleedingAnswers(DailyTrackerAnswers data) async {
    return await ApiManager.safeApiCall(() async {
      AmplitudeBleedingDetails(data: data).log();
      await ApiBaseHelper.httpPatchRequest(ApiLinks.saveBleeding, jsonEncode([await data.to()]));
      SymptomTrackingCompleted(symptomCategory: "Bleeding", completionStatus: true).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsAverageBleedingGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/bleeding/graphs/average-max/tenure/$tenure/average", queryParams: queryParams);

      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InisghtsBleedingInCircleModel>> fetchInsightsBleedingInCirclesGraphFromApi(List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      queryParams['symptoms'] = 'bleeding';
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/circle", queryParams: queryParams);

      final InisghtsBleedingInCircleModel responseModel = InisghtsBleedingInCircleModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, BleedingTagCount>> fetchInsightsBleedingTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/bleeding/tenure/$tenure", queryParams: queryParams);
      final BleedingTagCount responseModel = BleedingTagCount.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsBleedingPadsChartFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/bleeding/graphs/average-max/tenure/$tenure/pads", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteBatchBleeding(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteBleeding, jsonEncode(ids));

      return Right(response);
    }, showLoader: false);
  }
}
