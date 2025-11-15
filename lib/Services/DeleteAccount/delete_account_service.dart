import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';

class DeleteAccountService {
  static Future<Either<String, dynamic>> deleteUserProfileFromApi(String userId) async {
    try {
      await ApiBaseHelper.httpDeleteRequest(ApiLinks.deleteUserProfile.replaceAll("userIdPlaceholder", userId), jsonEncode({}));
      return const Right("Deleted");
    } catch (e) {
      return Left("$e");
    }
  }
}
