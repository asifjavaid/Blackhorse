// import 'dart:math';

// import 'package:dartz/dartz.dart';
// import 'package:ekvi/Models/Insights/insights_graph_model.dart';
// // import 'package:ekvi/Network/api_base_helper.dart';
// // import 'package:ekvi/Network/api_links.dart';
// import 'package:ekvi/Utils/helpers/api_manager.dart';
// // import 'package:ekvi/Utils/helpers/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MultiSymptomsChartService {
//   // static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsAveragePainGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
//   //   return await ApiManager.safeApiCall(() async {
//   //     String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
//   //     Map<String, String> queryParams = {'year': selectedYear.toString(), if (selectedMonths.isNotEmpty) 'months': selectedMonths.map((date) => DateFormat('MMMM').format(date)).join(',')};
//   //     var response = await ApiBaseHelper.httpGetRequest("${ApiLinks.getInsights}/$userId/symptoms/pain/graphs/average-pain/tenure/$tenure/average", queryParams: queryParams);
//   //     final InsightsGraphModel responseModel = InsightsGraphModel.fromJson(response, selectedMonths, selectedYear);
//   //     return responseModel;
//   //   }, showLoader: false);
//   // }

//   static Future<Either<dynamic, InsightsGraphModel>> fetchInsightsAveragePainGraphFromApi(String tenure, List<DateTime> selectedMonths, int selectedYear) async {
//     return await ApiManager.safeApiCall(() async {
//       await Future.delayed(const Duration(seconds: 2));
//       InsightsGraphModel responseModel = generateMockData(selectedMonths, selectedYear);

//       return responseModel;
//     }, showLoader: false);
//   }

//   static InsightsGraphModel generateMockData(List<DateTime> selectedMonths, int selectedYear) {
//     // dev.log("loading data for $selectedMonths");

//     String userId = "c16003cf32e34ccc88ac18fe80bcccb8";
//     String symptomType = "pain";
//     String graphType = "average-pain";

//     List<GraphData> graphData = [];
//     for (var month in selectedMonths) {
//       int daysInMonth = DateUtils.getDaysInMonth(selectedYear, month.month);
//       for (int day = 1; day <= daysInMonth; day += 7) {
//         graphData.add(GraphData(
//           date: DateFormat('yyyy-MM-dd').format(DateTime(selectedYear, month.month, day)),
//           month: DateFormat('MMMM').format(DateTime(selectedYear, month.month, day)),
//           value: Random().nextDouble() * 10,
//         ));
//       }
//     }

//     double average = graphData.map((e) => e.value!).reduce((a, b) => a + b) / graphData.length;
//     // dev.log("Incoming graph data has length ${graphData.length}");

//     return InsightsGraphModel(
//       userId: userId,
//       symptomType: symptomType,
//       graphType: graphType,
//       timeFrame: TimeFrame(year: selectedYear.toString(), months: selectedMonths.map((date) => DateFormat('MMMM').format(date)).toList()),
//       graphData: graphData,
//       average: average.toStringAsFixed(1),
//     );
//   }
// }
