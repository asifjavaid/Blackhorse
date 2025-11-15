import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/OvulationTest/ovulation_test_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class OvulationTestService {
  static Future<Either<dynamic, void>> saveOvulationTestAnswers(
    OvulationTestResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.saveOvulationTest, jsonEncode([data.toJson()]));
      AmplitudeOvulationTestDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, OvulationTestResponseModel>> getOvulationTestlDataFromApi(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getOvulationTestData(userId!, date, timeOfDay),
      );
      OvulationTestResponseModel responseModel = OvulationTestResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteOvulationTestData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteOvulationTest, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }
}
