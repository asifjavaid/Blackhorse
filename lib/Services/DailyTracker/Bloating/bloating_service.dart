import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/Bloating/bloating_model.dart';
import 'package:ekvi/Models/DailyTracker/Bloating/bloating_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class BloatingService {
  static Future<Either<dynamic, void>> saveBloatingAnswers(
    BloatingResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.saveBloating, jsonEncode([data.toJson()]));
      AmplitudeBloatingDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, SymptomFeedback>> getBloatingFeedbackStatus() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getSymptomFeedback(userId!, "bloating"),
      );
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, SymptomFeedback>> updateBloatingFeedbackStatus(String id, bool answer) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpPatchRequest(ApiLinks.updateSymptomFeedback(id), jsonEncode({"userId": userId, "answer": answer}));
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, BloatingResponseModel>> getBloatingDataFromApi(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getBloatingData(userId!, date, timeOfDay),
      );
      BloatingResponseModel responseModel = BloatingResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteBloatingData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteBloating, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsAverageBloatingGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/bloating/graphs/average-max/tenure/$tenure/average", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsMaximumBloatingGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/bloating/graphs/average-max/tenure/$tenure/max", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, BloatingTagList>> fetchInsightsBloatingTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/bloating/tenure/$tenure", queryParams: queryParams);
      final BloatingTagList responseModel = BloatingTagList.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
