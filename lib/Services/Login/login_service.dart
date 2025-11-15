import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Authentication/store_fcm_token.dart';
import 'package:ekvi/Models/Authentication/create_signicat_session_model.dart';
import 'package:ekvi/Models/Authentication/create_signicat_token_model.dart';
import 'package:ekvi/Models/Authentication/login_user_response_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';

class LoginService {
  static Future<Either<String, CreateSignicatEkviTokenResponse>> createSignicatEkviTokenApi({required String email}) async {
    try {
      var response = await ApiBaseHelper.httpPostRequest(ApiLinks.createSignicatEkviToken, jsonEncode({"email": email}));

      final CreateSignicatEkviTokenResponse responseModel = CreateSignicatEkviTokenResponse.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, CreateSignicatEkviSessionResponse>> createSignicatEkviSessionApi({required String token, required String email}) async {
    try {
      var response = await ApiBaseHelper.httpPostRequest(ApiLinks.createSignicatEkviSession, jsonEncode(ekviSessionRequestBody(email)), bearerToken: token);

      final CreateSignicatEkviSessionResponse responseModel = CreateSignicatEkviSessionResponse.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, dynamic>> handleStoreFCMToken({required StoreFCMTokenModel payload}) async {
    try {
      var response = await ApiBaseHelper.httpPostRequest(
        ApiLinks.storeFCMToken,
        jsonEncode(payload.toJson()),
      );

      return Right(response);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, EkviLoginUserResponse>> loginEkviUser({
    required String sessionID,
    required String token,
  }) async {
    try {
      var response = await ApiBaseHelper.httpPostRequest(ApiLinks.loginEkviUser.replaceAll("sessionID", sessionID), jsonEncode({}), bearerToken: token);

      final EkviLoginUserResponse responseModel = EkviLoginUserResponse.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }
}

ekviSessionRequestBody(String email) => {
      "prefilledInput": {"nin": "07128312345", "mobile": "+4799716935", "email": "bruce@wayneenterprice.com", "userName": "brucewayne", "dateOfBirth": "1973-12-07"},
      "callbackUrls": {"success": "https://api.ekvi.io/session/success", "abort": "https://api.ekvi.io/session/success/abort", "error": "https://api.ekvi.io/session/success/error"},
      "allowedProviders": ["nbid"],
      "language": "en",
      "flow": "redirect",
      "themeId": "agkaa12",
      "requestedAttributes": [email],
      "externalReference": "my-reference-12345",
      "sessionLifetime": 360,
      "requestDomain": "string"
    };
