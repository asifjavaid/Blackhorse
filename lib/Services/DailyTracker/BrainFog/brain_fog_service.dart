import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/BrainFog/brain_fog_model.dart';
import 'package:ekvi/Models/DailyTracker/BrainFog/brain_fog_tag_list.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class BrainFogService {
  static Future<Either<dynamic, void>> saveBrainFogAnswers(
    BrainFogResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.saveBrainFog, jsonEncode([data.toJson()]));
      AmplitudeBrainFogDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, SymptomFeedback>> getBrainFogFeedbackStatus() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getSymptomFeedback(userId!, "brainfog"),
      );
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, SymptomFeedback>> updateBrainFogFeedbackStatus(String id, bool answer) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpPatchRequest(ApiLinks.updateSymptomFeedback(id), jsonEncode({"userId": userId, "answer": answer}));
      SymptomFeedback responseModel = SymptomFeedback.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, BrainFogResponseModel>> getBrainFogDataFromApi(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getBrainFogData(userId!, date, timeOfDay),
      );
      BrainFogResponseModel responseModel = BrainFogResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteBrainFogData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteBrainFog, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsAverageBrainFogGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/brainfog/graphs/average-max/tenure/$tenure/average", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsMaximumBrainFogGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/brainfog/graphs/average-max/tenure/$tenure/max", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, BrainFogTagList>> fetchInsightsBrainFogTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/brainfog/tenure/$tenure", queryParams: queryParams);
      final BrainFogTagList responseModel = BrainFogTagList.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
