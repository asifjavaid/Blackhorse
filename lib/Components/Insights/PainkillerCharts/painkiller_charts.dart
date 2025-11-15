import 'package:ekvi/Components/Insights/PainkillerCharts/insights_painkiller_average_effectivenes_chart.dart';
import 'package:ekvi/Components/Insights/PainkillerCharts/insights_painkiller_pills_chart.dart';
import 'package:ekvi/Components/Insights/PainkillerCharts/insights_painkillers_in_circles.dart';
import 'package:ekvi/Components/Insights/PainkillerCharts/insights_painkillers_tags.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PainkillerCharts extends StatelessWidget {
  const PainkillerCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PainKillersProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsPainkillersAverageEffectivessChartData.isDataLoaded
              ? InsightsPainkillerAverageEffectivenessChart(
                  data: value.insightsPainkillersAverageEffectivessChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsPainkillersPillsChartData.isDataLoaded
              ? InsightsPainkillerPillsChart(
                  data: value.insightsPainkillersPillsChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsPainkillerTags(),
          const SizedBox(
            height: 24,
          ),
          InsightsPainkillersInCircles(
            data: value.painkillerInCirclesModel,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
