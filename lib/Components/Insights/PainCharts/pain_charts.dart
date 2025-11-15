import 'package:ekvi/Components/Insights/PainCharts/insights_average_pain_chart.dart';
import 'package:ekvi/Components/Insights/PainCharts/insights_maximum_pain_chart.dart';
import 'package:ekvi/Components/Insights/PainCharts/insights_pain_tags.dart';
import 'package:ekvi/Providers/Insights/insights_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PainCharts extends StatelessWidget {
  const PainCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InsightsProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          if (value.insightsAveragePainChartData.isDataLoaded) ...{
            InsightsAveragePainChart(
              data: value.insightsAveragePainChartData,
            ),
            const SizedBox(
              height: 24,
            ),
          },
          if (value.insightsMaximumPainChartData.isDataLoaded) ...{
            InsightsMaximumPainChart(
              data: value.insightsMaximumPainChartData,
            ),
            const SizedBox(
              height: 24,
            ),
          },
          if (value.bodyPainTags.isDataLoaded) ...{
            InsightsPainTags(
              data: value.bodyPainTags,
            ),
            const SizedBox(
              height: 24,
            ),
          },
        ],
      ),
    );
  }
}
