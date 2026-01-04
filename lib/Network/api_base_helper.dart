import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ekvi/Network/api_exception.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  static Future<dynamic> httpGetRequest(String endPoint,
      {Map<String, String>? queryParams}) async {
    http.Response response;
    try {

      print("endpoint: ${AppConstant.appBaseURL}$endPoint}");
      print("request: ${queryParams}");

      response = await http.get(
          Uri.parse('${AppConstant.appBaseURL}$endPoint')
              .replace(queryParameters: queryParams),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await HelperFunctions.getAccessToken()}',
          });
    } on SocketException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on FormatException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on TimeoutException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } catch (_) {
      throw FetchDataException(AppConstant.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpPatchRequest(
      String endPoint, dynamic requestBody) async {
    http.Response response;
    try {

      print("endpoint: ${AppConstant.appBaseURL}$endPoint}");
      print("request: ${requestBody}");

      response = await http.patch(
          Uri.parse('${AppConstant.appBaseURL}$endPoint'),
          body: requestBody,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await HelperFunctions.getAccessToken()}',
          });
    } on SocketException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on FormatException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on TimeoutException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } catch (_) {
      throw FetchDataException(AppConstant.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpDeleteRequest(
      String endPoint, dynamic requestBody) async {
    http.Response response;
    try {
      response = await http.delete(
          Uri.parse('${AppConstant.appBaseURL}$endPoint'),
          body: requestBody,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await HelperFunctions.getAccessToken()}',
          });
    } on SocketException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on FormatException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on TimeoutException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } catch (_) {
      throw FetchDataException(AppConstant.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpPostRequest(String endPoint, dynamic requestBody,
      {String? bearerToken}) async {
    http.Response response;
    try {
      print("endpoint: ${AppConstant.appBaseURL}$endPoint}");
      print("request: ${requestBody}");
      response = await http.post(
        Uri.parse('${AppConstant.appBaseURL}$endPoint'),
        headers: {
          'Content-type': 'application/json',
          'Accept': "*/*",
          'Authorization':
              'Bearer ${bearerToken ?? await HelperFunctions.getAccessToken()}',
        },
        body: requestBody,
      );
    } on SocketException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on FormatException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on TimeoutException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } catch (e) {
      throw FetchDataException(AppConstant.exceptionMessage);
    }

    print("respose: ${response.body}");
    return _returnResponse(response);
  }

  static Future<dynamic> httpMultiPartPostRequest(
      http.MultipartRequest request) async {
    http.Response response;
    try {
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } on SocketException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on FormatException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on TimeoutException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } catch (e) {
      throw FetchDataException(AppConstant.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static Future<dynamic> httpPutRequest(
      String endPoint, dynamic requestBody) async {
    http.Response response;
    try {
      response = await http.put(Uri.parse('${AppConstant.appBaseURL}$endPoint'), body: requestBody, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await HelperFunctions.getAccessToken()}',
      });
    } on SocketException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on FormatException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on TimeoutException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } catch (e) {
      throw FetchDataException(AppConstant.exceptionMessage);
    }
    return _returnResponse(response);
  }

  static dynamic _returnResponse(http.Response response) async {
    // ignore: prefer_typing_uninitialized_variables
    var jsonResponse;
    try {
      jsonResponse = jsonDecode(response.body);
    } on FormatException catch (_) {
      jsonResponse = response.body;
    }

    switch (response.statusCode) {
      case 200:
        return jsonResponse;
      case 201:
        return jsonResponse;
      case 400:
        throw BadRequestException(
            jsonResponse['message'] ?? AppConstant.exceptionMessage);
      case 401:
        throw UnauthorisedException(
            "You've been logged out due to session timeout.");
      case 403:
        throw UnauthorisedException(
            jsonResponse['message'] ?? AppConstant.exceptionMessage);
      case 404:
        throw FetchDataException(
            jsonResponse['message'] ?? AppConstant.exceptionMessage);
      case 500:
      default:
        throw FetchDataException(
            jsonResponse['message'] ?? AppConstant.exceptionMessage);
    }
  }
}
