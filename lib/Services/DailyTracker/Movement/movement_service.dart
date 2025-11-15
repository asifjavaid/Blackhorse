import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/Movement/movement_in_circle_model.dart';
import 'package:ekvi/Models/DailyTracker/Movement/movement_model.dart';
import 'package:ekvi/Models/DailyTracker/Movement/movement_tags.dart';
import 'package:ekvi/Models/DailyTracker/Movement/user_movements_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class MovementService {
  static Future<Either<dynamic, void>> saveMovementsLog(MovementResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.movementLog,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, MovementResponseModel>> getMovementTrackingData(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getMovementTrackingData(userId!, date, timeOfDay),
      );
      return MovementResponseModel.fromJson(response[0] ?? {});
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> savePracticeRecord(UserMovementsResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.createNewPractice,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, List<UserMovementsResponseModel>>> getPractices() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(ApiLinks.getMovementPractices(userId!));
      List<UserMovementsResponseModel> practices = [];

      if (response is List) {
        practices = response.map((j) => UserMovementsResponseModel.fromJson(j)).toList();
      }
      return practices;
    }, showLoader: false);
  }

  static Future<Either<dynamic, UserMovementsResponseModel>> updatePracticeRecord(String id, UserMovementsResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      final payload = jsonEncode(data.toJson());
      final response = await ApiBaseHelper.httpPatchRequest(
        ApiLinks.updateMovementPractice(id),
        payload,
      );
      return UserMovementsResponseModel.fromJson(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> deletePracticeRecord(String id) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest("${ApiLinks.deleteMovementPractice}/$id", jsonEncode({}));
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteMovementTrackingData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteMovementTrackingRecord, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchAverageIntensityGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/movement/graphs/average-max/tenure/$tenure/intensity", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
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
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/movement/graphs/average-max/tenure/$tenure/enjoyment", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchMovementDurationGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/movement/graphs/average-max/tenure/$tenure/duration", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, MovementTagsCount>> fetchInsightsMovementTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/movement/tenure/$tenure", queryParams: queryParams);
      final MovementTagsCount responseModel = MovementTagsCount.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsMovementCircleModel>> getMovementInCirclesData(String? tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      queryParams['symptoms'] = "movement";

      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/circle", queryParams: queryParams);
      final InsightsMovementCircleModel responseModel = InsightsMovementCircleModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
