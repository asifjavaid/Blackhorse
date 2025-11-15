import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/PregnancyTest/pregnancy_test_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class PregnancyTestService {
  static Future<Either<dynamic, void>> savePregnancyTestAnswers(
    PregnancyTestResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.savePregnancyTest, jsonEncode([data.toJson()]));
      AmplitudePregnancyDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, PregnancyTestResponseModel>> getPregnancyTestlDataFromApi(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getPregnancyTestData(userId!, date, timeOfDay),
      );
      PregnancyTestResponseModel responseModel = PregnancyTestResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deletePregnancyTestData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deletePregnancyTest, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }
}
