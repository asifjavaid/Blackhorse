import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Cycle/cycle_predictions.dart';
import 'package:ekvi/Models/Cycle/save_cycle_settings_model.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CycleService {
  static Future<Either<String, SaveCycleTrackingSettingsModel>> saveCycleTrackingSettings({required SaveCycleTrackingSettingsModel data, required bool update}) async {
    try {
      dynamic response;
      if (update) {
        var cycleId = await SharedPreferencesHelper.getStringPrefValue(key: "cycleId");

        response = await ApiBaseHelper.httpPatchRequest("${ApiLinks.saveCycleTrackingSettings}/$cycleId", jsonEncode(data.toJson()));
      } else {
        // Create the cycle settings
        response = await ApiBaseHelper.httpPostRequest(ApiLinks.saveCycleTrackingSettings, jsonEncode(data.toJson()));
      }

      final SaveCycleTrackingSettingsModel responseModel = SaveCycleTrackingSettingsModel.fromJson(response);
      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, SaveCycleTrackingSettingsModel>> getCycleTrackingSettings() async {
    try {
      var cycleId = await SharedPreferencesHelper.getStringPrefValue(key: "cycleId");

      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.saveCycleTrackingSettings}/$cycleId");

      final SaveCycleTrackingSettingsModel responseModel = SaveCycleTrackingSettingsModel.fromJson(response);
      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<dynamic, CycleCalendarAPI>> getCycleCalendarDataFromAPI() async {
    return await ApiManager.safeApiCall(() async {
      var userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getCalendarData.replaceAll("userIdPlaceholder", userId!));
      CycleCalendarAPI cycleCalendarAPI = CycleCalendarAPI.fromJson(response);

      return cycleCalendarAPI;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> addPeriodDates({required List<DailyTrackerAnswers> data}) async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpPatchRequest(ApiLinks.saveBleeding, jsonEncode(await Future.wait(data.map((e) => e.to()))));
      return response;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> removePeriodDates({required List<String> data}) async {
    return await ApiManager.safeApiCall(() async {
      var userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteBleedingAtDates(userId!), jsonEncode(data));
      return Right(response);
    }, showLoader: false);
  }
}
