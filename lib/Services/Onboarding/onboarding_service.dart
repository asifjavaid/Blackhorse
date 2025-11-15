import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Onboarding/cycle_tracking_model.dart';
import 'package:ekvi/Models/Onboarding/onboarding_answer_model.dart';
import 'package:ekvi/Models/Onboarding/onboarding_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class OnboardingService {
  static Future<Either<dynamic, OnboardingModel>> fetchUserProgressFromAPI() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(
        HelperFunctions.generateLinkByUserId(ApiLinks.getUserProgress, userId!),
      );
      OnboardingModel responseModel = OnboardingModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, OnboardingModel>> saveUserAnswerFromAPI(OnboardingAnswer data, bool wasLastQuestion) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpPostRequest(HelperFunctions.generateLinkByUserId(ApiLinks.saveUserAnswer, userId!), jsonEncode(await data.toJson()));
      OnboardingModel responseModel = wasLastQuestion ? OnboardingModel() : OnboardingModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, dynamic>> syncUserCycleInformationFromAPI(CycleTrackingModel data) async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpPostRequest(ApiLinks.syncUserCycleInformation, jsonEncode(await data.toJson()));
      return Right(response);
    }, showLoader: false);
  }

  static Future<Either<dynamic, OnboardingModel>> getBackToPreviousAnswerFromAPI(int order) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpPostRequest(HelperFunctions.generateLinkByUserId("${ApiLinks.goBackToPreviousAnswer}/$order", userId!), jsonEncode({}));
      OnboardingModel responseModel = OnboardingModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
