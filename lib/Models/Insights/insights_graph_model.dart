import 'package:intl/intl.dart';

class InsightsGraphModel {
  String? userId;
  String? symptomType;
  String? graphType;
  String? average;
  List<TimeFrame>? timeFrame;
  List<GraphData>? graphData;
  bool isDataLoaded = false;

  InsightsGraphModel({
    this.userId,
    this.symptomType,
    this.graphType,
    this.timeFrame,
    this.graphData,
    this.average,
  });

  InsightsGraphModel.fromJson(
    Map<String, dynamic> json,
    List<DateTime> selectedMonths,
    int selectedYear,
  ) {
    userId = json['userId'];
    symptomType = json['symptomType'];
    graphType = json['graphType'];
    average = json['average'];

    if (json['timeFrame'] != null) {
      timeFrame = [];
      json['timeFrame'].forEach((v) {
        timeFrame!.add(TimeFrame.fromJson(v));
      });
    }

    if (json['graphData'] != null) {
      graphData = <GraphData>[];
      json['graphData'].forEach((v) {
        graphData!.add(GraphData.fromJson(v));
      });
    }

    if (selectedMonths.length == 1) {
      final DateTime selectedMonth = selectedMonths[0];
      final int year = selectedYear;
      final int month = selectedMonth.month;
      final List<String> allDates = _getAllDatesOfMonth(year, month);

      for (final String date in allDates) {
        if (!graphData!.any((element) => element.date == date)) {
          graphData!.add(
            GraphData(
              date: date,
              month: DateFormat('MMMM').format(selectedMonth),
              value: 0.0,
            ),
          );
        }
      }
      graphData!.sort((a, b) => a.date!.compareTo(b.date!));
    } else if (selectedMonths.isEmpty) {
      final int year = selectedYear;
      for (int month = 1; month <= 12; month++) {
        final String firstDateOfMonth = _getFirstDateOfMonth(year, month);
        if (!graphData!.any((element) => element.date == firstDateOfMonth)) {
          graphData!.add(
            GraphData(
              date: firstDateOfMonth,
              month: DateFormat('MMMM').format(DateTime(year, month, 1)),
              value: 0.0,
            ),
          );
        }
      }
    }

    // Sort final graphData by date
    graphData!.sort(
      (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)),
    );

    isDataLoaded = true;
  }

  /// **Getter** that returns `true` if exactly one month is selected
  bool get isDailyInterval {
    if (timeFrame == null) return false;
    int totalMonths = 0;
    for (final frame in timeFrame!) {
      totalMonths += frame.months?.length ?? 0;
    }
    return totalMonths == 1;
  }

  int get totalMonthsSelected {
    if (timeFrame == null) return 0;
    int total = 0;
    for (final frame in timeFrame!) {
      total += (frame.months?.length ?? 0);
    }
    return total;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['symptomType'] = symptomType;
    data['graphType'] = graphType;
    data['average'] = average;

    if (timeFrame != null) {
      data['timeFrame'] = timeFrame!.map((t) => t.toJson()).toList();
    }
    if (graphData != null) {
      data['graphData'] = graphData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String _getFirstDateOfMonth(int year, int month) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(DateTime(year, month, 1));
  }

  List<String> _getAllDatesOfMonth(int year, int month) {
    final List<String> dates = [];
    final DateTime firstDay = DateTime(year, month, 1);
    final DateTime lastDay = DateTime(year, month + 1, 0);
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    for (int i = 0; i < lastDay.day; i++) {
      dates.add(dateFormat.format(firstDay.add(Duration(days: i))));
    }

    return dates;
  }

  int getMaxValue() {
    if (graphData == null || graphData!.isEmpty) {
      return 0;
    }
    final double maxValue = graphData!.map((data) => data.value ?? 0.0).reduce((a, b) => a > b ? a : b);
    return maxValue.toInt();
  }
}

class TimeFrame {
  String? year;
  List<String>? months;

  TimeFrame({this.year, this.months});

  TimeFrame.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    months = json['months']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['months'] = months;
    return data;
  }
}

class GraphData {
  String? date;
  String? month;
  double? value;

  GraphData({this.date, this.month, this.value});

  GraphData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    month = json['month'];
    if (json['value'] != null) {
      value = (json['value'] is int) ? (json['value'] as int).toDouble() : (json['value'] as num).toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['month'] = month;
    data['value'] = value;
    return data;
  }
}
