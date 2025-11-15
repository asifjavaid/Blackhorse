import 'package:ekvi/Models/DailyTracker/BodyPain/body_pain_model.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
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
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/daily_tracker_service.dart';
import 'package:ekvi/Services/Insights/insights_service.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsightsProvider with ChangeNotifier {
  InsightsGraphModel insightsAveragePainChartData = InsightsGraphModel();
  InsightsGraphModel insightsMaximumPainChartData = InsightsGraphModel();
  BodyPainTags bodyPainTags = BodyPainTags();

  Future<void> callAllInsightsAPIs() async {
    var provider = Provider.of<InsightsSymptomTimeSelectionProvider>(
        AppNavigation.currentContext!,
        listen: false);
    if (provider.selectedSymptom == "Pain") {
      final insightsAveragePainChartFuture = fetchInsightsAveragePainChart(
          getGraphTenure(provider.selectedMonths),
          provider.selectedMonths,
          provider.selectedYear);
      final insightsMaximumPainChartFuture = fetchInsightsMaximumPainChart(
          getGraphTenure(provider.selectedMonths),
          provider.selectedMonths,
          provider.selectedYear);
      final fetchInsightsPainTagsFuture = fetchInsightsBodyPainTagsCount(
          getGraphTenure(provider.selectedMonths),
          provider.selectedMonths,
          provider.selectedYear);

      await Future.wait([
        insightsAveragePainChartFuture,
        insightsMaximumPainChartFuture,
        fetchInsightsPainTagsFuture
      ]);
    } else if (provider.selectedSymptom == "Bleeding") {
      var bleedingProvider = Provider.of<BleedingProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAverageBleedingChartFuture =
          bleedingProvider.fetchInsightsAverageBleedingChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBleedingInCirclesChartFuture =
          bleedingProvider.fetchInsightsBleedingInCirclesChart(
              provider.selectedMonths, provider.selectedYear);
      final fetchInsightsBleedingTagsCountFuture =
          bleedingProvider.fetchInsightsBleedingTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBleedingPadsChartFuture =
          bleedingProvider.fetchInsightsBleedingPadsChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAverageBleedingChartFuture,
        fetchInsightsBleedingInCirclesChartFuture,
        fetchInsightsBleedingTagsCountFuture,
        fetchInsightsBleedingPadsChartFuture
      ]);
    } else if (provider.selectedSymptom == "Mood") {
      var moodProvider = Provider.of<MoodProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAverageMoodChartFuture =
          moodProvider.fetchInsightsAverageMoodChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMoodInCirclesChartFuture =
          moodProvider.fetchInsightsMaximumMoodChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMoodTagsCountFuture =
          moodProvider.fetchInsightsMoodTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAverageMoodChartFuture,
        fetchInsightsMoodInCirclesChartFuture,
        fetchInsightsMoodTagsCountFuture
      ]);
    } else if (provider.selectedSymptom == "Stress") {
      var moodProvider = Provider.of<StressProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAverageMoodChartFuture =
          moodProvider.fetchInsightsAverageStressChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMoodInCirclesChartFuture =
          moodProvider.fetchInsightsMaximumStressChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMoodTagsCountFuture =
          moodProvider.fetchInsightsStressTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAverageMoodChartFuture,
        fetchInsightsMoodInCirclesChartFuture,
        fetchInsightsMoodTagsCountFuture
      ]);
    } else if (provider.selectedSymptom == "Energy") {
      var energyProvider = Provider.of<EnergyProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAveragEnergyChartFuture =
          energyProvider.fetchInsightsAverageEnergyChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMaximumEnergyChartFuture =
          energyProvider.fetchInsightsMaximumEnergyChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsEnergyTagsCountFuture =
          energyProvider.fetchInsightsEnergyTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAveragEnergyChartFuture,
        fetchInsightsMaximumEnergyChartFuture,
        fetchInsightsEnergyTagsCountFuture
      ]);
    } else if (provider.selectedSymptom == "Nausea") {
      var nauseaProvider = Provider.of<NauseaProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAveragNauseaChartFuture =
          nauseaProvider.fetchInsightsAverageNauseaChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMaximumNauseaChartFuture =
          nauseaProvider.fetchInsightsMaximumNauseaChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsNauseaTagsCountFuture =
          nauseaProvider.fetchInsightsNauseaTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAveragNauseaChartFuture,
        fetchInsightsMaximumNauseaChartFuture,
        fetchInsightsNauseaTagsCountFuture
      ]);
    } else if (provider.selectedSymptom == "Fatigue") {
      var fatigueProvider = Provider.of<FatigueProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAveragFatigueChartFuture =
          fatigueProvider.fetchInsightsAverageFatigueChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMaximumFatigueChartFuture =
          fatigueProvider.fetchInsightsMaximumFatiguChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsFatigueTagsCountFuture =
          fatigueProvider.fetchInsightsFatiguTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAveragFatigueChartFuture,
        fetchInsightsMaximumFatigueChartFuture,
        fetchInsightsFatigueTagsCountFuture
      ]);
    } else if (provider.selectedSymptom == "Headache") {
      var headacheProvider = Provider.of<HeadacheProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchAverageHeadacheChartFuture =
          headacheProvider.fetchInsightsAverageHeadacheChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchMaximumHeadacheChartFuture =
          headacheProvider.fetchInsightsMaximumHeadacheChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchHeadacheTagsAndGridDataFuture =
          headacheProvider.fetchInsightsHeadacheTagsAndGridData(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchHeadacheDurationChartFuture =
          headacheProvider.fetchInsightsHeadacheDurationChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);

      await Future.wait([
        fetchAverageHeadacheChartFuture,
        fetchMaximumHeadacheChartFuture,
        fetchHeadacheDurationChartFuture,
        fetchHeadacheTagsAndGridDataFuture
      ]);
    } else if (provider.selectedSymptom == "Bowel movement") {
      var bowelMovementProvider = Provider.of<BowelMovementProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightBowelMovementConsistencyChartFuture =
          bowelMovementProvider.fetchInsightsAverageBowelMovementChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBowelMovementTimeOfDayChartFuture =
          bowelMovementProvider.fetchInsightsTimeOfDayMovementChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBowelMovementInCirclesChartFuture =
          bowelMovementProvider.fetchInsightsCircleMovementChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBowelMovementTagsFuture =
          bowelMovementProvider.fetchBowelMovTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightBowelMovementConsistencyChartFuture,
        fetchInsightsBowelMovementTimeOfDayChartFuture,
        fetchInsightsBowelMovementInCirclesChartFuture,
        fetchInsightsBowelMovementTagsFuture
      ]);
    } else if (provider.selectedSymptom == "Bloating") {
      var bloatingProvider = Provider.of<BloatingProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAverageBloatingChartFuture =
          bloatingProvider.fetchInsightsAverageBloatingChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMaximumBloatingChartFuture =
          bloatingProvider.fetchInsightsMaximumBloatingChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBloatingTagsCountFuture =
          bloatingProvider.fetchInsightsBloatingTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAverageBloatingChartFuture,
        fetchInsightsMaximumBloatingChartFuture,
        fetchInsightsBloatingTagsCountFuture
      ]);
    } else if (provider.selectedSymptom == "Brain fog") {
      var brainFogProvider = Provider.of<BrainFogProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAveragBrainFogChartFuture =
          brainFogProvider.fetchInsightsAverageBrainFogChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsMaximumBrainFogChartFuture =
          brainFogProvider.fetchInsightsMaximumBrainFogChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBrainFogTagsCountFuture =
          brainFogProvider.fetchInsightsBrainFogTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightsAveragBrainFogChartFuture,
        fetchInsightsMaximumBrainFogChartFuture,
        fetchInsightsBrainFogTagsCountFuture
      ]);
    } else if (provider.selectedSymptom == "Bowel movement") {
      var bowelMovementProvider = Provider.of<BowelMovementProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightBowelMovementConsistencyChartFuture =
          bowelMovementProvider.fetchInsightsAverageBowelMovementChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBowelMovementTimeOfDayChartFuture =
          bowelMovementProvider.fetchInsightsTimeOfDayMovementChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBowelMovementInCirclesChartFuture =
          bowelMovementProvider.fetchInsightsCircleMovementChart(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      final fetchInsightsBowelMovementTagsFuture =
          bowelMovementProvider.fetchBowelMovTagsCount(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear);
      await Future.wait([
        fetchInsightBowelMovementConsistencyChartFuture,
        fetchInsightsBowelMovementTimeOfDayChartFuture,
        fetchInsightsBowelMovementInCirclesChartFuture,
        fetchInsightsBowelMovementTagsFuture
      ]);
    } else if (provider.selectedSymptom == "Painkillers") {
      var painKillersProvider = Provider.of<PainKillersProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final symptomTimeSelectionProvider =
          Provider.of<InsightsSymptomTimeSelectionProvider>(
              AppNavigation.currentContext!,
              listen: false);

      final fetchInsightsPainkillersAverageEffectivessChartFuture =
          painKillersProvider
              .fetchInsightsPainkillersAverageEffectivessChartData(
                  getGraphTenure(provider.selectedMonths),
                  provider.selectedMonths,
                  provider.selectedYear,
                  symptomTimeSelectionProvider.selectedActiveIngredient,
                  loading: false);
      final fetchInsightsPainkillersPillsChartFuture =
          painKillersProvider.fetchInsightsPainkillersPillsChartData(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear,
              symptomTimeSelectionProvider.selectedActiveIngredient,
              loading: false);
      final fetchInsightsPainkillersTagsCountFuture =
          painKillersProvider.fetchInsightsPainkillersTagsCount(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
        symptomTimeSelectionProvider.selectedActiveIngredient,
      );
      final fetchInsightsPainkillersInCirclesChartFuture =
          painKillersProvider.fetchPainkillersInCirclesData(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
        symptomTimeSelectionProvider.selectedActiveIngredient,
      );
      final fetchUserActiveIngredientsFuture =
          symptomTimeSelectionProvider.loadUserIngredients();

      await Future.wait([
        fetchInsightsPainkillersAverageEffectivessChartFuture,
        fetchInsightsPainkillersPillsChartFuture,
        fetchInsightsPainkillersTagsCountFuture,
        fetchInsightsPainkillersInCirclesChartFuture,
        fetchUserActiveIngredientsFuture
      ]);
    } else if (provider.selectedSymptom == "Movement") {
      var movementProvider = Provider.of<MovementProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAverageIntensityChartFuture =
          movementProvider.fetchInsightsAverageIntensityChartData(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear,
              loading: false);
      final fetchInsightsAverageEnjoymentChartFuture =
          movementProvider.fetchInsightsAverageEnjoymentChartData(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear,
              loading: false);
      final fetchInsightsMovementTagsCount =
          movementProvider.fetchInsightsMovementTagsCount(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
      );
      final fetchInsightsMovementDurationChart =
          movementProvider.fetchInsightsMovementDurationChartData(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear,
              loading: false);
      final fetchInsightsPainkillersInCirclesChartFuture =
          movementProvider.fetchMovementInCirclesData(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
      );

      await Future.wait([
        fetchInsightsAverageIntensityChartFuture,
        fetchInsightsAverageEnjoymentChartFuture,
        fetchInsightsMovementDurationChart,
        fetchInsightsMovementTagsCount,
        fetchInsightsPainkillersInCirclesChartFuture,
      ]);
    } else if (provider.selectedSymptom == "Self-care") {
      var selfcareProvider = Provider.of<SelfcareProvider>(
          AppNavigation.currentContext!,
          listen: false);
      final fetchInsightsAverageEnjoymentChartFuture =
          selfcareProvider.fetchInsightsAverageEnjoymentChartData(
              getGraphTenure(provider.selectedMonths),
              provider.selectedMonths,
              provider.selectedYear,
              loading: false);
      final fetchInsightsMovementTagsCount =
          selfcareProvider.fetchInsightsSelfcareTagsCount(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
      );
      final fetchInsightsPainkillersInCirclesChartFuture =
          selfcareProvider.fetchSelfcareInCirclesData(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
      );

      await Future.wait([
        fetchInsightsAverageEnjoymentChartFuture,
        fetchInsightsMovementTagsCount,
        fetchInsightsPainkillersInCirclesChartFuture,
      ]);
    } else if (provider.selectedSymptom == "Pain relief") {
      var painReliefProvider = Provider.of<PainReliefProvider>(
          AppNavigation.currentContext!,
          listen: false);

      final fetchInsightsAverageEnjoymentChartFuture =
          painReliefProvider.fetchInsightsAverageEnjoymentChartData(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
        loading: false,
      );

      final fetchInsightsPainReliefTagsCount =
          painReliefProvider.fetchInsightsPainReliefTagsCount(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
      );

      final fetchInsightsPainReliefInCirclesChartFuture =
          painReliefProvider.fetchPainReliefInCirclesData(
        getGraphTenure(provider.selectedMonths),
        provider.selectedMonths,
        provider.selectedYear,
      );

      await Future.wait([
        fetchInsightsAverageEnjoymentChartFuture,
        fetchInsightsPainReliefTagsCount,
        fetchInsightsPainReliefInCirclesChartFuture,
      ]);
    }
  }

  Future<InsightsGraphModel> fetchInsightsAveragePainChart(
      String tenure, List<DateTime> selectedMonths, int selectedYear,
      {bool loading = true, bool notify = true}) async {
    insightsAveragePainChartData.isDataLoaded = false;
    if (notify) notifyListeners();
    if (loading) CustomLoading.showLoadingIndicator();

    var result = await InsightsService.fetchInsightsAveragePainGraphFromApi(
        tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        if (loading) CustomLoading.hideLoadingIndicator();
        return InsightsGraphModel();
      },
      (r) {
        insightsAveragePainChartData = r;
        if (notify) notifyListeners();
        if (loading) CustomLoading.hideLoadingIndicator();
        return r;
      },
    );
  }

  Future<InsightsGraphModel> fetchInsightsMaximumPainChart(
      String tenure, List<DateTime> selectedMonths, int selectedYear,
      {bool notify = true}) async {
    insightsMaximumPainChartData.isDataLoaded = false;
    if (notify) notifyListeners();

    var result = await InsightsService.fetchInsightsMaximumPainGraphFromApi(
        tenure, selectedMonths, selectedYear);
    return result.fold(
      (l) {
        return InsightsGraphModel();
      },
      (r) {
        insightsMaximumPainChartData = r;
        if (notify) notifyListeners();
        return r;
      },
    );
  }

  Future<void> fetchInsightsBodyPainTagsCount(
      String tenure, List<DateTime> selectedMonths, int selectedYear) async {
    bodyPainTags.isDataLoaded = false;
    notifyListeners();
    var result =
        await DailyTrackerService.fetchInsightsBodyPainTagsCountFromApi(
            tenure, selectedMonths, selectedYear);
    result.fold(
      (l) {
        bodyPainTags = BodyPainTags();
      },
      (r) {
        bodyPainTags = r;
        notifyListeners();
      },
    );
  }

  String getGraphTenure(
    List<DateTime> selectedMonths,
  ) {
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
}
