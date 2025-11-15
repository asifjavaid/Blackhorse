import 'package:ekvi/Components/Insights/PainReliefCharts/insight_pain_relief_average_effectiveness_chart.dart';
import 'package:ekvi/Components/Insights/PainReliefCharts/insight_pain_relief_enjoyment_by_practice_chart.dart';
import 'package:ekvi/Components/Insights/PainReliefCharts/insight_pain_relief_in_circles_chart.dart';
import 'package:ekvi/Components/Insights/PainReliefCharts/insights_pain_relief_practices_tags.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PainReliefCharts extends StatelessWidget {
  const PainReliefCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PainReliefProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(height: 24),
          if (value.insightsAverageEffectivenessChartData.isDataLoaded) ...{
            InsightsPainReliefAverageEffectivenessChart(
              data: value.insightsAverageEffectivenessChartData,
            ),
            const SizedBox(height: 24),
          },
          if (value.painReliefTagsCounts.isDataLoaded) ...{
            const InsightsPainReliefPracticesTags(),
            const SizedBox(height: 24),
          },
          if (value.painReliefTagsCounts.isDataLoaded) ...{
            const EnjoymentByPainReliefPracticeCard(),
            const SizedBox(height: 24),
          },
          if (value.painReliefInCircleModel.isDataLoaded ?? false) ...{
            InsightsPainReliefCircles(
              data: value.painReliefInCircleModel,
            ),
          },
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
