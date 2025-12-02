import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Models/Insights/multi_symptom_graph_model.dart';
import 'package:ekvi/Providers/DailyTracker/Bleeding/bleeding_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Bloating/bloating_provider.dart';
import 'package:ekvi/Providers/DailyTracker/BowelMovement/bowel_movement_provider.dart';
import 'package:ekvi/Providers/DailyTracker/BrainFog/brain_fog_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Energy/energy_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Fatigue/fatigue_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Headache/headache_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Nausea/nausea_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_provider.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Stress/stress_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Urination/urination_provider.dart';
import 'package:ekvi/Providers/Insights/insights_provider.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MultiSymptomsChartProvider extends ChangeNotifier {
  late List<DateTime> selectedMonths;
  late int selectedYear;
  String currentSymptom = "Pain";
  String activePainKillerIngredient = "All active ingredients";
  bool isLoading = false;
  List<InisghtsSymptom> compareSymptoms = [];
  List<InisghtsSymptom> symptoms = [];
  MultiSymptomChartType chartType = MultiSymptomChartType.average;
  List<CartesianSeries<GraphData, DateTime>> series = [];
  TimeFrameSelection _selectionType = TimeFrameSelection.oneMonth;

  TimeFrameSelection get selectionType => _selectionType;

  bool isSelected(InisghtsSymptom symptom) {
    return compareSymptoms.contains(symptom);
  }

  void addSymptom(InisghtsSymptom symptom) {
    if (compareSymptoms.contains(symptom)) {
      compareSymptoms.remove(symptom);
    } else if (compareSymptoms.length < 3) {
      compareSymptoms.add(symptom);
    }
    notifyListeners();
  }

  void initialize() {
    var provider = Provider.of<InsightsSymptomTimeSelectionProvider>(
        AppNavigation.currentContext!);
    currentSymptom = provider.selectedSymptom;
    activePainKillerIngredient = provider.selectedActiveIngredient;
    selectedMonths = provider.selectedMonths;
    selectedYear = provider.selectedYear;
    symptoms = provider.symptoms
        .where((symptom) => symptom.name != currentSymptom)
        .toList();
    _selectionType = provider.selectionType;
    loadGraphData();
  }

  void initializeGraphType(MultiSymptomChartType type) {
    chartType = type;
  }

  Future<void> loadGraphData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      series = [];
      isLoading = true;
      notifyListeners();
    });

    var updateFutures = getFutures();

    var results = await Future.wait(updateFutures.entries.map((entry) async {
      var result = await entry.value;
      return MapEntry(entry.key, result);
    }));

    var resultsMap = Map<String, InsightsGraphModel>.fromEntries(results);

    MultiSymptomGraphModel data = MultiSymptomGraphModel(
      painData: GraphSeriesConfig(
          data: resultsMap['painData']?.graphData,
          color: Colors.red,
          name: "Pain"),
      bleedingData: GraphSeriesConfig(
          data: resultsMap["bleedingData"]?.graphData,
          color: Colors.red,
          name: "Bleeding",
          normalize: true),
      moodData: GraphSeriesConfig(
          data: resultsMap["moodData"]?.graphData,
          color: Colors.red,
          name: "Mood"),
      stressData: GraphSeriesConfig(
          data: resultsMap['stressData']?.graphData,
          color: Colors.red,
          name: "Stress"),
      energyData: GraphSeriesConfig(
          data: resultsMap["energyData"]?.graphData,
          color: Colors.red,
          name: "Energy"),
      nauseaData: GraphSeriesConfig(
          data: resultsMap['nauseaData']?.graphData,
          color: Colors.red,
          name: "Nausea"),
      fatigueData: GraphSeriesConfig(
          data: resultsMap["fatigueData"]?.graphData,
          color: Colors.red,
          name: "Fatigue"),
      bloatingData: GraphSeriesConfig(
          data: resultsMap["bloatingData"]?.graphData,
          color: Colors.red,
          name: "Bloating"),
      brainfogData: GraphSeriesConfig(
          data: resultsMap["brainfogData"]?.graphData,
          color: Colors.red,
          name: "Brain fog"),
      bowelMovementData: GraphSeriesConfig(
          data: resultsMap["bowelMovementData"]?.graphData,
          color: Colors.red,
          name: "Bowel movement"),
      urinationData: GraphSeriesConfig(
          data: resultsMap["urinationData"]?.graphData,
          color: Colors.red,
          name: "Urination"),
      painKillerData: GraphSeriesConfig(
          data: resultsMap["painKillersData"]?.graphData,
          color: Colors.red,
          name: "Painkillers"),
      movementData: GraphSeriesConfig(
          data: resultsMap["movementData"]?.graphData,
          color: Colors.red,
          name: "Movement"),
      selfCareData: GraphSeriesConfig(
          data: resultsMap["selfCareData"]?.graphData,
          color: Colors.red,
          name: "Self-care"),
      painReliefData: GraphSeriesConfig(
        data: resultsMap["painReliefData"]?.graphData,
        color: Colors.red,
        name: "Pain relief",
      ),
      headacheData: GraphSeriesConfig(
        data: resultsMap["headacheData"]?.graphData,
        color: Colors.red,
        name: "Headache",
      ),
    );
    series = data.getAllSeries(currentSymptom);
    compareSymptoms =
        data.mapColorsToCompareSymptoms(currentSymptom, compareSymptoms);
    isLoading = false;
    notifyListeners();
  }

  Map<String, Future<InsightsGraphModel>> getFutures() {
    Map<String, Future<InsightsGraphModel>> updateFutures = {};
    List<InisghtsSymptom> symptomsToFetch =
        [InisghtsSymptom(name: currentSymptom)] + compareSymptoms;
    for (var symptom in symptomsToFetch) {
      switch (symptom.name) {
        case "Pain":
          var provider = Provider.of<InsightsProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['painData'] = chartType == MultiSymptomChartType.average
              ? provider.fetchInsightsAveragePainChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumPainChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;
        case "Bleeding":
          var provider = Provider.of<BleedingProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['bleedingData'] =
              provider.fetchInsightsAverageBleedingChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false);
          break;
        case "Mood":
          var provider = Provider.of<MoodProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['moodData'] = chartType == MultiSymptomChartType.average
              ? provider.fetchInsightsAverageMoodChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumMoodChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;

        case "Stress":
          var provider = Provider.of<StressProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['stressData'] = chartType ==
                  MultiSymptomChartType.average
              ? provider.fetchInsightsAverageStressChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumStressChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;

        case "Energy":
          var provider = Provider.of<EnergyProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['energyData'] = chartType ==
                  MultiSymptomChartType.average
              ? provider.fetchInsightsAverageEnergyChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumEnergyChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;

        case "Nausea":
          var provider = Provider.of<NauseaProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['nauseaData'] = chartType ==
                  MultiSymptomChartType.average
              ? provider.fetchInsightsAverageNauseaChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumNauseaChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;

        case "Fatigue":
          var provider = Provider.of<FatigueProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['fatigueData'] = chartType ==
                  MultiSymptomChartType.average
              ? provider.fetchInsightsAverageFatigueChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumFatiguChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;
        case "Bowel movement":
          var provider = Provider.of<BowelMovementProvider>(
              AppNavigation.currentContext!,
              listen: false);
          if (chartType == MultiSymptomChartType.average) {
            updateFutures['bowelMovementData'] =
                provider.fetchInsightsAverageBowelMovementChart(
                    getGraphTenure(selectedMonths),
                    selectedMonths,
                    selectedYear,
                    loading: false,
                    notify: false);
          }
        case "Urination":
          var provider = Provider.of<UrinationProvider>(
              AppNavigation.currentContext!,
              listen: false);
          if (chartType == MultiSymptomChartType.average) {
            updateFutures['urinationData'] =
                provider.fetchInsightsAverageUrinationChart(
                    getGraphTenure(selectedMonths),
                    selectedMonths,
                    selectedYear,
                    loading: false,
                    notify: false);
          }
          break;
        case "Bloating":
          var provider = Provider.of<BloatingProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['bloatingData'] = chartType ==
                  MultiSymptomChartType.average
              ? provider.fetchInsightsAverageBloatingChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumBloatingChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;

        case "Brain fog":
          var provider = Provider.of<BrainFogProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['brainfogData'] = chartType ==
                  MultiSymptomChartType.average
              ? provider.fetchInsightsAverageBrainFogChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsMaximumBrainFogChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  notify: false);
          break;

        case "Movement":
          var provider = Provider.of<MovementProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['movementData'] = chartType ==
                  MultiSymptomChartType.average
              ? provider.fetchInsightsAverageIntensityChartData(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false)
              : provider.fetchInsightsAverageEnjoymentChartData(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false);
          break;

        case "Painkillers":
          var provider = Provider.of<PainKillersProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['painKillersData'] =
              provider.fetchInsightsPainkillersAverageEffectivessChartData(
                  getGraphTenure(selectedMonths),
                  selectedMonths,
                  selectedYear,
                  activePainKillerIngredient,
                  loading: false,
                  notify: false);
          break;

        case "Self-care":
          var provider = Provider.of<SelfcareProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['selfCareData'] =
              provider.fetchInsightsAverageEnjoymentChartData(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false);
          break;
        case "Pain relief":
          var provider = Provider.of<PainReliefProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['painReliefData'] =
              provider.fetchInsightsAverageEnjoymentChartData(
            getGraphTenure(selectedMonths),
            selectedMonths,
            selectedYear,
            loading: false,
            notify: false,
          );
          break;

        case "Headache":
          var provider = Provider.of<HeadacheProvider>(
              AppNavigation.currentContext!,
              listen: false);
          updateFutures['headacheData'] =
              provider.fetchInsightsAverageHeadacheChart(
                  getGraphTenure(selectedMonths), selectedMonths, selectedYear,
                  loading: false, notify: false);
          break;

        default:
      }
    }

    return updateFutures;
  }

  String getGraphTenure(List<DateTime> selectedMonths) {
    switch (selectedMonths.length) {
      case 0:
        return "yearly";
      case 1:
        return "daily";
      case 3:
        return "weekly";

      default:
        return "weekly";
    }
  }

  void clearData() {
    // data = MultiSymptomGraphModel();
    compareSymptoms.clear();
  }

  void onSymptomRemove(InisghtsSymptom symptom) {
    compareSymptoms.remove(symptom);
    loadGraphData();
    notifyListeners();
  }
}
