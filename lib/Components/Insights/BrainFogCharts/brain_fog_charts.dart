import 'package:ekvi/Components/Insights/BrainFogCharts/insights_average_brainfog_chart.dart';
import 'package:ekvi/Components/Insights/BrainFogCharts/insights_brainfog_tags.dart';
import 'package:ekvi/Components/Insights/BrainFogCharts/insights_maximum_brainfog_chart.dart';
import 'package:ekvi/Providers/DailyTracker/BrainFog/brain_fog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrainFogCharts extends StatelessWidget {
  const BrainFogCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrainFogProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageBrainFogChartData.isDataLoaded
              ? InsightsAverageBrainFogChart(
                  data: value.insightsAverageBrainFogChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsMaximumBrainFogChartData.isDataLoaded
              ? InsightsMaximumBrainFogChart(
                  data: value.insightsMaximumBrainFogChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsBrainFogTags(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
