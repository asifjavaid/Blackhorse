import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Authentication/login_user_response_model.dart';
import 'package:ekvi/Models/Registration/user_data_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

class RegistrationService {
  static Future<Either<String, EkviLoginUserResponse>> communicateSocialLoginToServerFromApi(String endpoint, String token) async {
    try {
      var response = await ApiBaseHelper.httpPostRequest(endpoint, jsonEncode({"token": token}));

      EkviLoginUserResponse responseModel = EkviLoginUserResponse.fromJson(response);
      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  // static Future<Either<String, PictureUploadResponse>> uploadProfilePictureApi(String email, File imageFile) async {
  //   try {
  //     var stream = http.ByteStream(imageFile.openRead());
  //     stream.cast();
  //     var request = http.MultipartRequest("POST", Uri.parse('${AppConstant.appBaseURL}${ApiLinks.uploadPic}'));
  //     request.fields['email'] = email;
  //     MediaType contentType;

  //     if (imageFile.path.endsWith('.png')) {
  //       contentType = MediaType('image', 'png');
  //     } else if (imageFile.path.endsWith('.jpg') || imageFile.path.endsWith('.jpeg')) {
  //       contentType = MediaType('image', 'jpeg');
  //     }
  //     request.files.add(
  //       await http.MultipartFile.fromPath('file', imageFile.path, contentType: contentType, filename: imageFile.path.split("/").last),
  //     );

  //     var response = await ApiBaseHelper.httpMultiPartPostRequest(request);
  //     PictureUploadResponse responseModel = PictureUploadResponse.fromJson(response);

  //     return Right(responseModel);
  //   } catch (e) {
  //     return Left("$e");
  //   }
  // }

  static Future<Either<String, UserData>> sendUserDataApi(String gender, String dob, String height, String weight) async {
    try {
      var userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");

      String requestBody = jsonEncode({"gender": gender, "dob": dob, "height": height, "weight": weight});

      var response = await ApiBaseHelper.httpPatchRequest("${ApiLinks.updateUser}/$userId", requestBody);

      UserData responseModel = UserData.fromJson(response);
      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, String>> generateOtpForEmail(String email) async {
    try {
      var response = await ApiBaseHelper.httpPostRequest("${ApiLinks.createOtp}$email", jsonEncode({}));

      return Right(response);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, String>> verifyOtpForEmail(String email, String otp) async {
    try {
      var response = await ApiBaseHelper.httpPostRequest("${ApiLinks.verifyOtp}$email&otp=$otp", jsonEncode({}));

      if (response == "wrong Otp") {
        return Left(response);
      } else {
        return Right(response);
      }
    } catch (e) {
      return Left("$e");
    }
  }
}
