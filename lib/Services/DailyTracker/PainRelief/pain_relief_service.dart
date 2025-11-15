import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_response_model.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/user_pain_relief_model.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_tags_count.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_in_circle_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class PainReliefService {
  static Future<Either<dynamic, void>> savePainReliefLog(PainReliefResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.painReliefLog,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, PainReliefResponseModel>> getPainReliefTrackingData(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getPainReliefTrackingData(userId!, date, timeOfDay),
      );
      return PainReliefResponseModel.fromJson(response[0] ?? {});
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> savePracticeRecord(UserPainReliefResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.createPainReliefPractice,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, List<UserPainReliefResponseModel>>> getPractices() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(ApiLinks.getPainReliefPractices(userId!));
      List<UserPainReliefResponseModel> practices = [];

      if (response is List) {
        practices = response.map((j) => UserPainReliefResponseModel.fromJson(j)).toList();
      }
      return practices;
    }, showLoader: false);
  }

  static Future<Either<dynamic, UserPainReliefResponseModel>> updatePracticeRecord(String id, UserPainReliefResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      final payload = jsonEncode(data.toJson());
      final response = await ApiBaseHelper.httpPatchRequest(
        ApiLinks.updatePainReliefPractice(id),
        payload,
      );
      return UserPainReliefResponseModel.fromJson(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> deletePracticeRecord(String id) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest("${ApiLinks.deletePainReliefPractice}/$id", jsonEncode({}));
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deletePainReliefTrackingData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deletePainReliefTrackingRecord, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchAverageEnjoymentGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }

      final response = await ApiBaseHelper.httpGetRequest(
        "${ApiLinks.getInsights}/$userId/symptoms/painrelief/graphs/average-max/tenure/$tenure/enjoyment",
        queryParams: queryParams,
      );

      return InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
    }, showLoader: false);
  }

  static Future<Either<dynamic, PainReliefTagsCount>> fetchInsightTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }

      final response = await ApiBaseHelper.httpGetRequest(
        "${ApiLinks.getInsights}/$userId/symptoms/painrelief/tenure/$tenure",
        queryParams: queryParams,
      );

      return PainReliefTagsCount.fromJson(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsPainReliefInCircleModel>> getInCirclesData(String? tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }

      queryParams['symptoms'] = "painrelief";

      final response = await ApiBaseHelper.httpGetRequest(
        "${ApiLinks.getInsights}/$userId/circle",
        queryParams: queryParams,
      );

      return InsightsPainReliefInCircleModel.fromJson(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, PainReliefTagsCount>> fetchInsightPainReliefTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }

      var response = await ApiBaseHelper.httpGetRequest(
        "${ApiLinks.getInsights}/$userId/symptoms/painrelief/tenure/$tenure",
        queryParams: queryParams,
      );

      final PainReliefTagsCount responseModel = PainReliefTagsCount.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
