import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/pain_killers_model.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/painkillers_in_circles.model.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/painkillers_tags.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/user_pain_killer_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class PainkillerService {
  static Future<Either<dynamic, void>> savePainKillerTrackingData(PainKillersResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.trackPainKiller,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, PainKillersResponseModel>> getPainkillerTrackingData(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getPainKillerData(userId!, date, timeOfDay),
      );
      return PainKillersResponseModel.fromJson(response[0]);
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> savePainkillerRecord(UserPainKillerResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(
        ApiLinks.createPainkiller,
        jsonEncode(data.toJson()),
      );
    }, showLoader: false);
  }

  static Future<Either<dynamic, List<UserPainKillerResponseModel>>> getPainkillers() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final response = await ApiBaseHelper.httpGetRequest(ApiLinks.getPainkillers(userId!));
      List<UserPainKillerResponseModel> painkillers = [];
      if (response is List) {
        painkillers = response.map((j) => UserPainKillerResponseModel.fromJson(j)).toList();
      }

      return painkillers;
    }, showLoader: false);
  }

  static Future<Either<dynamic, UserPainKillerResponseModel>> updatePainkillerVisibility(String id, bool newVisibility) async {
    return await ApiManager.safeApiCall(() async {
      final payload = jsonEncode({"isVisibleInTracker": newVisibility});
      final response = await ApiBaseHelper.httpPatchRequest(
        ApiLinks.updatePainkiller(id),
        payload,
      );
      return UserPainKillerResponseModel.fromJson(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, UserPainKillerResponseModel>> updatePainkillerRecord(String id, UserPainKillerResponseModel data) async {
    return await ApiManager.safeApiCall(() async {
      final payload = jsonEncode(data.toJson());
      final response = await ApiBaseHelper.httpPatchRequest(
        ApiLinks.updatePainkiller(id),
        payload,
      );
      return UserPainKillerResponseModel.fromJson(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, void>> deletePainkillerRecord(String id) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest("${ApiLinks.deletePainkiller}/$id", jsonEncode({}));
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deletePainKillerTrackingData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deletePainkillerTrackingRecord, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchPainkillersAverageEffectivessGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear, String ingredient) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/painkiller/graphs/$ingredient/tenure/$tenure/average", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchPainkillersPillsGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear, String ingredient) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/painkiller/graphs/$ingredient/tenure/$tenure/pills", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, PainkillersTagsCount>> fetchInsightsPainkillersTagsCountFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear, String ingredient) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      queryParams['ingredient'] = ingredient;
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/painkiller/tenure/$tenure", queryParams: queryParams);
      final PainkillersTagsCount responseModel = PainkillersTagsCount.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, PainkillerInCirclesModel>> getPainkillersInCirclesData(String? tenure, List<DateTime> selectedMonths, int selectedYear, String ingredient) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      queryParams['symptoms'] = "painkiller";
      queryParams['ingredient'] = ingredient;

      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/circle", queryParams: queryParams);
      final PainkillerInCirclesModel responseModel = PainkillerInCirclesModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, List<String>>> fetchUserActiveIngredients() async {
    return await ApiManager.safeApiCall(() async {
      final String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final dynamic response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getUserPainkillerIngredients(userId!),
      );

      if (response is List) {
        return response.cast<String>();
      }
      return <String>[];
    }, showLoader: false);
  }
}
