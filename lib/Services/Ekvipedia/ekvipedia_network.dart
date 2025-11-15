import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ekvi/Network/api_exception.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EkvipediaNetwork {
  final String _baseUrl = 'https://cdn.contentful.com';

  final String _spaceId = '7dy43ce1qn1r';
  final String _accessToken = 'RufisaS3yhvWg1Erl12bThNbM3YJQdgV0h861UJxX2g';
  final String _environment = AppConstant.contentfulEnvironment;

  Future<dynamic> httpGetRequest(String endpoint, {Map<String, String>? queryParams}) async {
    http.Response response;
    try {
      final uri = Uri.parse('$_baseUrl/spaces/$_spaceId/environments/$_environment/$endpoint').replace(queryParameters: queryParams);
      response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        },
      );
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on TimeoutException {
      throw FetchDataException("Request timed out");
    } catch (_) {
      throw FetchDataException("Unexpected error occurred");
    }
    return _returnResponse(response);
  }

  static Future<dynamic> newhttpGetRequest(String endPoint, {Map<String, String>? queryParams}) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('${AppConstant.appBaseURL}$endPoint').replace(queryParameters: queryParams), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
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

  static Future<dynamic> newhttpPatchRequest(String endPoint, dynamic requestBody) async {
    http.Response response;
    try {
      response = await http.patch(Uri.parse('${AppConstant.appBaseURL}$endPoint'), body: requestBody, headers: {
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

  static Future<dynamic> newhttpDeleteRequest(String endPoint, dynamic requestBody) async {
    http.Response response;
    try {
      final url = '${AppConstant.appBaseURL}$endPoint';
      final token = await HelperFunctions.getAccessToken();

      response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );
    } on SocketException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on FormatException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } on TimeoutException {
      throw FetchDataException(AppConstant.exceptionMessage);
    } catch (e) {
      debugPrint('Unhandled exception: $e');
      throw FetchDataException(AppConstant.exceptionMessage);
    }

    return _returnResponse(response);
  }

  static Future<dynamic> newhttpPostRequest(String endPoint, dynamic requestBody) async {
    http.Response response;
    try {
      response = await http.post(
        Uri.parse('${AppConstant.appBaseURL}$endPoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
        body: jsonEncode(requestBody), // ✅ properly encoded JSON
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

    return _returnResponse(response);
  }

  static Future<dynamic> newhttpMultiPartPostRequest(http.MultipartRequest request) async {
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

  static dynamic _returnResponse(http.Response response) {
    dynamic jsonResponse;
    try {
      jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw FetchDataException("Error parsing response");
    }

    switch (response.statusCode) {
      case 200:
        return jsonResponse;
      case 201:
        return jsonResponse;
      case 404:
        throw FetchDataException("Resource not found");
      case 401:
        throw UnauthorisedException("Unauthorized request");
      case 400:
        throw FetchDataException("Something went wrong");
      default:
        throw FetchDataException("Error occurred while fetching data");
    }
  }
}
