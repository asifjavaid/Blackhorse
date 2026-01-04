import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/EditProfle/user_profile_model.dart';
import 'package:ekvi/Models/Notifications/ekvipedia_notification_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';

class NotificationsService {
  static Future<Either<dynamic, UserProfileModel>> fetchNotificationApi(String userId) async {
    return await ApiManager.safeApiCall(() async {
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getUser}/$userId");
      print("response: $response");
      final UserProfileModel responseModel = UserProfileModel.fromJson((response as List).first);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<String, UserProfileModel>> updateNotificationApi(UserNotificationPreferences data, String userId) async {
    try {
      var response = await ApiBaseHelper.httpPatchRequest(
        "${ApiLinks.updateUser}/$userId",
        jsonEncode(data.toJson()),
      );
      final UserProfileModel responseModel = UserProfileModel.fromJson(response);
      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }
}
