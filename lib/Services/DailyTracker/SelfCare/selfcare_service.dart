import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_in_circle_model.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_model.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_tags.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/user_selfcare_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class SelfcareService {
  static Future<Either<dynamic, void>> saveSelfcareLog(SelfCareResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.selfcareLog,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, SelfCareResponseModel>> getSelfcareTrackingData(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getSelfcareTrackingData(userId!, date, timeOfDay),
      );
      return SelfCareResponseModel.fromJson(response[0] ?? {});
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> savePracticeRecord(UserSelfCareResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.createSelfCarePractice,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, List<UserSelfCareResponseModel>>> getPractices() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(ApiLinks.getSelfCarePractices(userId!));
      List<UserSelfCareResponseModel> practices = [];

      if (response is List) {
        practices = response.map((j) => UserSelfCareResponseModel.fromJson(j)).toList();
      }
      return practices;
    }, showLoader: false);
  }

  static Future<Either<dynamic, UserSelfCareResponseModel>> updatePracticeRecord(String id, UserSelfCareResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      final payload = jsonEncode(data.toJson());
      final response = await ApiBaseHelper.httpPatchRequest(
        ApiLinks.updateSelfCarePractice(id),
        payload,
      );
      return UserSelfCareResponseModel.fromJson(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> deletePracticeRecord(String id) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest("${ApiLinks.deleteSelfCarePractice}/$id", jsonEncode({}));
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteSelfCareTrackingData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteSelfCareTrackingRecord, jsonEncode(ids));
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
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/selfcare/graphs/average-max/tenure/$tenure/enjoyment", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, SelfCareTagsCount>> fetchInsightSelfcareTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/selfcare/tenure/$tenure", queryParams: queryParams);
      final SelfCareTagsCount responseModel = SelfCareTagsCount.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsSelfCareInCircleModel>> getSelfcareInCirclesData(String? tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      queryParams['symptoms'] = "selfcare";

      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/circle", queryParams: queryParams);
      final InsightsSelfCareInCircleModel responseModel = InsightsSelfCareInCircleModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
