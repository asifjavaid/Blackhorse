import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Dashboard/feature_alert_model.dart';
import 'package:ekvi/Models/Dashboard/my_day_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class DashboardService {
  static Future<Either<dynamic, MyDayModel>> fetchMyDayFromApi() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getMyDay}/${userId!}");
      final MyDayModel responseModel = MyDayModel.fromJson(response);
      responseModel.isDataLoaded = true;
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, FeatureAlertModel>> fetchAlertFromAPI() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest(ApiLinks.getFeatureAlert(userId!));
      final FeatureAlertModel responseModel = FeatureAlertModel.fromJson(response);
      return responseModel;
    }, showLoader: false);
  }
}
