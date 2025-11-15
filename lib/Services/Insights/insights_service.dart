import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Network/api_base_helper.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Utils/helpers/api_manager.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:intl/intl.dart';

class InsightsService {
  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsAveragePainGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/pain/graphs/average-max/tenure/$tenure/average", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsMaximumPainGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      final queryParams = <String, String>{};

      if (selectedMonths.isNotEmpty) {
        queryParams['months'] = selectedMonths.map((date) => DateFormat('yyyy-MMM').format(date)).join(',');
      } else {
        queryParams['year'] = selectedYear.toString();
      }
      var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/pain/graphs/average-max/tenure/$tenure/max", queryParams: queryParams);
      final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
      return responseModel;
    }, showLoader: false);
  }

  static Future<Either<dynamic, List<String>>> fetchTopSymptoms() async {
    return await ApiManager.safeApiCall(() async {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
      var response = await ApiBaseHelper.httpGetRequest("/insight/$userId/top-symptoms");
      if (response is List && response.isNotEmpty) {
        List<String> responseList = response.cast<String>();
        return responseList.map<String>((symptom) => symptom.isNotEmpty ? symptom[0].toUpperCase() + symptom.substring(1) : symptom).toList();
      }
      return [];
    }, showLoader: false);
  }
}
