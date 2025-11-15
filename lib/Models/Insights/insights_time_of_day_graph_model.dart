class InsightsTimeOfDayGraphModel {
  String? userId;
  String? symptomType;
  String? graphType;
  List<TimeDayGraphData>? graphData;
  bool isDataLoaded = false;

  InsightsTimeOfDayGraphModel({this.userId, this.symptomType, this.graphType, this.graphData});

  InsightsTimeOfDayGraphModel.fromJson(Map<String, dynamic> json, List<DateTime> selectedMonths, int selectedYear) {
    userId = json['userId'];
    symptomType = json['symptomType'];
    graphType = json['graphType'];
    if (json['graphData'] != null) {
      graphData = <TimeDayGraphData>[];
      json['graphData'].forEach((v) {
        graphData!.add(TimeDayGraphData.fromJson(v));
      });
    }
    isDataLoaded = true;
  }

  int getMaxValue() {
    if (graphData == null || graphData!.isEmpty) {
      return 0;
    }
    double maxValue = graphData!.map((data) => data.count ?? 0.0).reduce((a, b) => a > b ? a : b);

    return maxValue.toInt();
  }
}

class TimeDayGraphData {
  String? timeOfDay;
  double? count;

  TimeDayGraphData({this.timeOfDay, this.count});

  TimeDayGraphData.fromJson(Map<String, dynamic> json) {
    timeOfDay = json['timeOfDay'];
    count = json['count'] != null ? (json['count'] is int ? (json['count'] as int).toDouble() : json['count'] as double) : null;
  }
}
