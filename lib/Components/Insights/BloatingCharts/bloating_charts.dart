import 'package:ekvi/Components/Insights/BloatingCharts/insights_average_bloating_chart.dart';
import 'package:ekvi/Components/Insights/BloatingCharts/insights_bloating_tags.dart';
import 'package:ekvi/Components/Insights/BloatingCharts/insights_maximum_bloating_chart.dart';
import 'package:ekvi/Providers/DailyTracker/Bloating/bloating_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloatingCharts extends StatelessWidget {
  const BloatingCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BloatingProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageBloatingChartData.isDataLoaded
              ? InsightsAverageBloatingChart(
                  data: value.insightsAverageBloatingChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsMaximumBloatingChartData.isDataLoaded
              ? InsightsMaximumBloatingChart(
                  data: value.insightsMaximumBloatingChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsBloatingTags(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
