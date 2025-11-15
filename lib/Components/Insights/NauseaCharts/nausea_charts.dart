import 'package:ekvi/Components/Insights/NauseaCharts/insights_average_nausea_chart.dart';
import 'package:ekvi/Components/Insights/NauseaCharts/insights_maximum_nausea_chart.dart';
import 'package:ekvi/Components/Insights/NauseaCharts/insights_nausea_tags.dart';
import 'package:ekvi/Providers/DailyTracker/Nausea/nausea_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NauseaCharts extends StatelessWidget {
  const NauseaCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NauseaProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageNauseaChartData.isDataLoaded
              ? InsightsAverageNauseaChart(
                  data: value.insightsAverageNauseaChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsMaximumNauseaChartData.isDataLoaded
              ? InsightsMaximumNauseaChart(
                  data: value.insightsMaximumNauseaChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsNauseaTags(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
