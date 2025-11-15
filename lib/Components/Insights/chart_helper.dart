import 'dart:math';

import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Models/Insights/insights_time_of_day_graph_model.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartHelper {
  static List<DateTime> getAllChartData(List<GraphData>? graphData) {
    return graphData?.map((item) => DateTime.parse(item.date!)).toList() ?? [];
  }

  static Map<int, DateTime> getFirstDatesOfMonth(List<DateTime> allChartData) {
    final firstDatesOfMonth = <int, DateTime>{};

    for (var date in allChartData) {
      int monthKey = date.year * 100 + date.month;
      if (!firstDatesOfMonth.containsKey(monthKey)) {
        firstDatesOfMonth[monthKey] = date;
      }
    }

    return firstDatesOfMonth;
  }

  static ChartAxisLabel axisLabelFormatter(AxisLabelRenderDetails args,
      bool isDailyInterval, Map<int, DateTime> firstDatesOfMonth) {
    DateTime date = DateTime.parse(args.text);
    String label;

    if (isDailyInterval) {
      label = DateFormat.d().format(date);
    } else {
      int monthKey = date.year * 100 + date.month;
      if (firstDatesOfMonth[monthKey] == date) {
        label = DateFormat('MMM').format(date);
      } else {
        label = "•";
      }
    }

    return ChartAxisLabel(
      label,
      const TextStyle(fontSize: 8),
    );
  }

  //Bleeding charts series
  static List<CartesianSeries> getBleedingIntensitySeries(
      List<GraphData> data) {
    final List<_BleedingData> allChartData = data
        .map((item) =>
            _BleedingData(DateTime.parse(item.date!), item.value!.toInt()))
        .toList();

    return <CartesianSeries<_BleedingData, DateTime>>[
      LineSeries<_BleedingData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_BleedingData data, _) => data.date,
        yValueMapper: (_BleedingData data, _) =>
            data.intensity > 0 ? data.intensity : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.errorColor500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.errorColor500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<ColumnSeries> getPadUsageSeries(InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          return AppColors.primaryColor600;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  // Pain charts series
  static List<CartesianSeries> getAveragePainPerTimeSeries() {
    final List<_TimeOfDayPainData> data = [
      _TimeOfDayPainData("Morning", Random().nextDouble() * 10),
      _TimeOfDayPainData("Afternoon", Random().nextDouble() * 10),
      _TimeOfDayPainData("Evening", Random().nextDouble() * 10),
      _TimeOfDayPainData("Night", Random().nextDouble() * 10),
      _TimeOfDayPainData("All Day", Random().nextDouble() * 10),
    ];

    return <CartesianSeries<_TimeOfDayPainData, String>>[
      ColumnSeries<_TimeOfDayPainData, String>(
        dataSource: data,
        xValueMapper: (_TimeOfDayPainData data, _) => data.timeOfDay,
        yValueMapper: (_TimeOfDayPainData data, _) => data.painLevel,
        width: 0.1,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_TimeOfDayPainData data, _) {
          if (data.painLevel <= 3) return AppColors.successColor500;
          if (data.painLevel <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      ),
    ];
  }

  static List<ColumnSeries> getMaximumPainBarSeries(InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumMoodBarSeries(InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.errorColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.successColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumStressBarSeries(InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumEnergyBarSeries(InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.errorColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.successColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumNauseaBarSeries(InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getTimeOfDayBarSeries(
      InsightsTimeOfDayGraphModel data) {
    // Define all possible time-of-day labels
    final List<String> allTimeOfDays = [
      "Morning",
      "Afternoon",
      "Evening",
      "Night",
      "All day"
    ];

    // Create a map from the data received
    final Map<String, double> timeDataMap = {
      for (var item in data.graphData ?? []) item.timeOfDay!: item.count!
    };

    // Ensure all time-of-day labels are present in the data
    final List<_TimeOfDayPainData> timeData = allTimeOfDays
        .map((time) => _TimeOfDayPainData(
              time,
              timeDataMap.containsKey(time) ? timeDataMap[time]! : 0,
            ))
        .toList();

    return <ColumnSeries<_TimeOfDayPainData, dynamic>>[
      ColumnSeries<_TimeOfDayPainData, dynamic>(
        dataSource: timeData,
        xValueMapper: (_TimeOfDayPainData pain, _) => pain.timeOfDay,
        yValueMapper: (_TimeOfDayPainData pain, _) => pain.painLevel,
        width: 0.1,
        borderRadius: BorderRadius.circular(12),
        pointColorMapper: (_TimeOfDayPainData pain, _) {
          return AppColors.primaryColor600;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumFatigueBarSeries(
      InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumBowelMovementsBarSeries(
      InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumBloatingBarSeries(
      InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumBrainFogBarSeries(
      InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getMaximumHeadacheBarSeries(
      InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          if (pain.level <= 3) return AppColors.successColor500;
          if (pain.level <= 7) return AppColors.secondaryColor500;
          return AppColors.errorColor500;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<CartesianSeries> getAveragePainLineSeries(List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageMoodLineSeries(List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageStressLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageEnergyLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageNauseaLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageFatigueLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageBowelMovementsLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();
    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageBloatingLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageBrainFogLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<CartesianSeries> getAverageHeadacheLineSeries(
      List<GraphData> data) {
    final List<_PainData> allChartData = data
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <CartesianSeries<_PainData, DateTime>>[
      LineSeries<_PainData, DateTime>(
        dataSource: allChartData,
        xValueMapper: (_PainData data, _) => data.date,
        yValueMapper: (_PainData data, _) => data.level > 0 ? data.level : null,
        dataLabelSettings: const DataLabelSettings(isVisible: false),
        color: AppColors.accentColorFour500,
        width: 0.49,
        markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: AppColors.accentColorFour500,
            height: 3.95,
            width: 3.95),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.drop),
      ),
    ];
  }

  static List<ColumnSeries> getMovementDurationBarSeries(
      InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          return AppColors.primaryColor600;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }

  static List<ColumnSeries> getHeadacheDurationBarSeries(
      InsightsGraphModel data) {
    final int totalSelected = data.totalMonthsSelected;

    TimeFrameSelection timeFrameSelection;
    if (totalSelected == 1) {
      timeFrameSelection = TimeFrameSelection.oneMonth;
    } else if (totalSelected == 3) {
      timeFrameSelection = TimeFrameSelection.threeMonths;
    } else {
      timeFrameSelection = TimeFrameSelection.oneYear;
    }
    List<_PainData> chartData = data.graphData!
        .map((item) => _PainData(DateTime.parse(item.date!), item.value!))
        .toList();

    return <ColumnSeries<_PainData, dynamic>>[
      ColumnSeries<_PainData, dynamic>(
        dataSource: chartData,
        xValueMapper: (_PainData pain, _) => pain.date,
        yValueMapper: (_PainData pain, _) => pain.level,
        width: timeFrameSelection == TimeFrameSelection.oneMonth ? 0.49 : 0.2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2), topRight: Radius.circular(2)),
        pointColorMapper: (_PainData pain, _) {
          return AppColors.primaryColor600;
        },
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      )
    ];
  }
}

class _PainData {
  final DateTime date;
  final double level;

  _PainData(this.date, this.level);
}

class _TimeOfDayPainData {
  final String timeOfDay;
  final double painLevel;

  _TimeOfDayPainData(this.timeOfDay, this.painLevel);
}

class _BleedingData {
  final DateTime date;
  final int intensity;

  _BleedingData(this.date, this.intensity);
}

class PadUsageData {
  final String month;
  final int pads;

  PadUsageData(this.month, this.pads);
}
