import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MultiSymptomGraphModel {
  String? userId;
  String? graphType;
  GraphSeriesConfig? painData;
  GraphSeriesConfig? bleedingData;
  GraphSeriesConfig? moodData;
  GraphSeriesConfig? stressData;
  GraphSeriesConfig? energyData;
  GraphSeriesConfig? nauseaData;
  GraphSeriesConfig? fatigueData;
  GraphSeriesConfig? bloatingData;
  GraphSeriesConfig? brainfogData;
  GraphSeriesConfig? bowelMovementData;
  GraphSeriesConfig? urinationData;
  GraphSeriesConfig? painKillerData;
  GraphSeriesConfig? movementData;
  GraphSeriesConfig? selfCareData;
  GraphSeriesConfig? painReliefData;
  GraphSeriesConfig? headacheData;

  bool isDataLoaded = false;

  MultiSymptomGraphModel(
      {this.userId,
      this.graphType,
      this.painData,
      this.bleedingData,
      this.bloatingData,
      this.brainfogData,
      this.energyData,
      this.fatigueData,
      this.moodData,
      this.nauseaData,
      this.stressData,
      this.bowelMovementData,
        this.urinationData,
      this.painKillerData,
      this.movementData,
      this.selfCareData,
      this.painReliefData,
      this.headacheData});

  List<InisghtsSymptom> mapColorsToCompareSymptoms(
      String currentSymptom, List<InisghtsSymptom> compareSymptoms) {
    List<GraphSeriesConfig> nonCurrentSeries =
        getNonCurrentNonNullSeries(currentSymptom);

    for (var symptom in compareSymptoms) {
      for (var series in nonCurrentSeries) {
        if (symptom.name == series.name) {
          symptom.color = series.color;
          break;
        }
      }
    }

    return compareSymptoms;
  }

  List<GraphSeriesConfig> getNonCurrentNonNullSeries(String currentSymptom) {
    List<GraphSeriesConfig> nonCurrentSeries = [];

    void addNonCurrentSeries(GraphSeriesConfig? config) {
      if (config != null &&
          config.data != null &&
          !config.isCurrent(currentSymptom)) {
        nonCurrentSeries.add(config);
      }
    }

    addNonCurrentSeries(painData);
    addNonCurrentSeries(bleedingData);
    addNonCurrentSeries(moodData);
    addNonCurrentSeries(stressData);
    addNonCurrentSeries(energyData);
    addNonCurrentSeries(nauseaData);
    addNonCurrentSeries(fatigueData);
    addNonCurrentSeries(bloatingData);
    addNonCurrentSeries(brainfogData);
    addNonCurrentSeries(bowelMovementData);
    addNonCurrentSeries(urinationData);
    addNonCurrentSeries(movementData);
    addNonCurrentSeries(selfCareData);
    addNonCurrentSeries(painReliefData);
    addNonCurrentSeries(headacheData);

    return nonCurrentSeries;
  }

  List<CartesianSeries<GraphData, DateTime>> getAllSeries(
      String currentSymptom) {
    List<CartesianSeries<GraphData, DateTime>> seriesList = [];
    List<Color> colors = [
      AppColors.accentColorFour500,
      AppColors.successColor500,
      AppColors.primaryColor600
    ];
    int colorIndex = 0;

    void addSeries(GraphSeriesConfig? config) {
      if (config != null && config.data != null) {
        if (config.isCurrent(currentSymptom)) {
          config.color = AppColors.accentColorFour400;
        } else {
          config.color = colors[colorIndex];
          colorIndex = (colorIndex + 1) % colors.length;
        }
        seriesList.add(config.createSeries(currentSymptom));
      }
    }

    List<GraphSeriesConfig?> allConfigs = [
      painData,
      bleedingData,
      moodData,
      stressData,
      energyData,
      nauseaData,
      fatigueData,
      bloatingData,
      brainfogData,
      bowelMovementData,
      urinationData,
      painKillerData,
      movementData,
      selfCareData,
      painReliefData,
      headacheData,
    ];

    allConfigs
        .where((config) => config?.isCurrent(currentSymptom) == true)
        .forEach(addSeries);
    allConfigs
        .where((config) => config?.isCurrent(currentSymptom) != true)
        .forEach(addSeries);

    return seriesList;
  }
}

enum SeriesType { area, line }

class GraphSeriesConfig {
  final String name;
  final bool normalize;
  List<GraphData>? data;
  Color color;

  GraphSeriesConfig(
      {required this.data,
      required this.color,
      required this.name,
      this.normalize = false});

  CartesianSeries<GraphData, DateTime> createSeries(String currentSymptom) {
    SeriesType seriesType =
        isCurrent(currentSymptom) ? SeriesType.area : SeriesType.line;
    data = normalize ? preProcessData(data) : data;

    switch (seriesType) {
      case SeriesType.area:
        return AreaSeries<GraphData, DateTime>(
          dataSource: data,
          xValueMapper: (GraphData data, _) => DateTime.parse(data.date!),
          yValueMapper: (GraphData data, _) =>
              data.value! > 0 ? data.value : null,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
          color: color,
          markerSettings: MarkerSettings(
              isVisible: false,
              shape: DataMarkerType.circle,
              color: color,
              height: 3.95,
              width: 3.95),
          emptyPointSettings:
              const EmptyPointSettings(mode: EmptyPointMode.drop),
        );
      case SeriesType.line:
      default:
        return LineSeries<GraphData, DateTime>(
          dataSource: data,
          xValueMapper: (GraphData data, _) => DateTime.parse(data.date!),
          yValueMapper: (GraphData data, _) =>
              data.value! > 0 ? data.value : null,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
          color: color,
          width: 0.49,
          markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              color: color,
              height: 3.95,
              width: 3.95),
          emptyPointSettings: EmptyPointSettings(
              mode: EmptyPointMode.zero,
              color: color,
              borderColor: Colors.black,
              borderWidth: 1),
        );
    }
  }

  bool isCurrent(String currentSymptom) {
    if (currentSymptom == name) {
      return true;
    }

    return false;
  }

  double normalizeValue(double? value) {
    if (value == null || value == 0) return 0.0;
    double clampedValue = value.clamp(2.0, 6.0);
    return ((clampedValue - 2) / (6 - 2)) * (10 - 1) + 1;
  }

  List<GraphData>? preProcessData(List<GraphData>? data) {
    return data?.map((item) {
      return GraphData(
        date: item.date,
        month: item.month,
        value: normalizeValue(item.value),
      );
    }).toList();
  }
}
