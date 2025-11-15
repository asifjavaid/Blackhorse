import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/Intimacy/intimacy_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class IntimacyService {
  static Future<Either<dynamic, void>> saveIntimacyAnswers(
    IntimacyResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.saveIntimacy, jsonEncode([data.toJson()]));
      AmplitudeIntimacyDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, IntimacyResponseModel>> getIntimacyDataFromApi(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getIntimacyData(userId!, date, timeOfDay),
      );
      IntimacyResponseModel responseModel = IntimacyResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteIntimacyData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteIntimacy, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }
}
