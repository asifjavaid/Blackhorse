import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/Hormones/hormones_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class HormonesService {
  static Future<Either<dynamic, void>> saveHormonesAnswers(
    HormonesResponseModel data,
  ) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpPostRequest(ApiLinks.saveHormones, jsonEncode([data.toJson()]));
      AmplitudeHormoneDetails(data: data).log();
    }, showLoader: false);
  }

  static Future<Either<dynamic, HormonesResponseModel>> getHormonesDataFromApi(String date, String timeOfDay) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        ApiLinks.getHormonesData(userId!, date, timeOfDay),
      );
      HormonesResponseModel responseModel = HormonesResponseModel.fromJson(response[0]);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> deleteHormonesData(List<String?> ids) async {
    return await ApiManager.safeApiCall(() async {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteHormones, jsonEncode(ids));
      return "";
    }, showLoader: false);
  }
}
