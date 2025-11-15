import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Models/Reminders/MedicationReminder/Request/medicine_reminder_request.dart';
import 'package:ekvi/Models/Reminders/PeriodReminder/period_reminder_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class RemindersService {
  static Future<Either<String, ContraceptionReminderModel>> createOrUpdateContraceptionReminder({bool create = true, required ContraceptionReminderModel request, String? id}) async {
    try {
      dynamic response;
      if (create) {
        response = await ApiBaseHelper.httpPostRequest(ApiLinks.createContraceptionReminder, jsonEncode(request.toJson()));
      } else {
        response = await ApiBaseHelper.httpPatchRequest("${ApiLinks.createContraceptionReminder}/${id!}", jsonEncode(request.toJson()));
      }

      final ContraceptionReminderModel responseModel = ContraceptionReminderModel.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, PeriodReminderModel>> createOrUpdatePeriodReminder({bool create = true, required PeriodReminderModel request, String? id}) async {
    try {
      dynamic response;
      if (create) {
        response = await ApiBaseHelper.httpPostRequest(ApiLinks.createPeriodReminder, jsonEncode(request.toJson()));
      } else {
        response = await ApiBaseHelper.httpPatchRequest("${ApiLinks.createPeriodReminder}/${id!}", jsonEncode(request.toJson()));
      }

      final PeriodReminderModel responseModel = PeriodReminderModel.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, PeriodReminderModel>> getAllPeriodReminders() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    try {
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getAllPeriodReminders.replaceAll("userIdPlaceholder", userId!));

      final PeriodReminderModel responseModel = PeriodReminderModel.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, PeriodReminderModel>> getPeriodReminder(String id) async {
    try {
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getPeriodReminder.replaceAll("id", id));

      final PeriodReminderModel responseModel = PeriodReminderModel.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, MedicineReminderRequest>> createOrUpdateMedicineReminder({bool create = true, required MedicineReminderRequest request, String? id}) async {
    try {
      dynamic response;
      if (create) {
        response = await ApiBaseHelper.httpPostRequest(ApiLinks.createMedicineReminder, jsonEncode(request.toJson()));
      } else {
        response = await ApiBaseHelper.httpPatchRequest(ApiLinks.updateMedicationReminder.replaceAll("id", id!), jsonEncode(request.toJson()));
      }

      final MedicineReminderRequest responseModel = MedicineReminderRequest.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, List<MedicineReminderRequest>>> getAllMedicinesRemindersFromApi() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");

    try {
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getAllMedicinesReminders.replaceAll("userIdPlaceholder", userId!));

      final List<MedicineReminderRequest> responseModel = (response as List)
          .map(
            (e) => MedicineReminderRequest.fromJson(e),
          )
          .toList();

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, ContraceptionReminderModel>> getContraceptionReminder(String? id) async {
    try {
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getContraceptionReminder.replaceAll("id", id!));

      final ContraceptionReminderModel responseModel = ContraceptionReminderModel.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<String, MedicineReminderRequest>> getMedicationReminder(String? id) async {
    try {
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getMedicationReminder.replaceAll("id", id!));

      final MedicineReminderRequest responseModel = MedicineReminderRequest.fromJson(response);

      return Right(responseModel);
    } catch (e) {
      return Left("$e");
    }
  }

  static Future<Either<dynamic, List<ContraceptionReminderModel>>> getAllContraceptionReminders() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getAllContraceptionReminders.replaceAll("userIdPlaceholder", userId!));
      final List<ContraceptionReminderModel> responseModel = (response as List).map((reminder) => ContraceptionReminderModel.fromJson(reminder)).toList();
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<String, dynamic>> deteleBatchContraceptionReminders(List<String?> ids) async {
    try {
      var response = await ApiBaseHelper.httpDeleteRequest("/contraception", jsonEncode(ids));

      return Right(response);
    } catch (e) {
      return const Left("Something went wrong!");
    }
  }

  static Future<Either<String, dynamic>> deleteBatchMedicationReminders(List<String?> ids) async {
    try {
      var response = await ApiBaseHelper.httpDeleteRequest("/medication", jsonEncode(ids));

      return Right(response);
    } catch (e) {
      return const Left("Something went wrong!");
    }
  }

  static Future<Either<String, dynamic>> deleteBatchPeriodReminder(List<String?> ids) async {
    try {
      var response = await ApiBaseHelper.httpDeleteRequest("/period", jsonEncode(ids));

      return Right(response);
    } catch (e) {
      return const Left("Something went wrong!");
    }
  }
}
