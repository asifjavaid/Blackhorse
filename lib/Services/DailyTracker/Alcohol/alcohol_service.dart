import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/Alcohol/alcohol_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class AlcoholService {
  static Future<Either<dynamic, void>> saveAlcoholAnswers(
    AlcoholResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.saveAlcohol, jsonEncode([data.toJson()]));
      AmplitudeAlcoholDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, AlcoholResponseModel>> getAlcoholDataFromApi(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getAlcoholData(userId!, date, timeOfDay),
      );
      AlcoholResponseModel responseModel = AlcoholResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteAlcoholData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteAlcohol, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }
}
