import 'package:ekvi/Components/Insights/StressCharts/insights_average_stress_chart.dart';
import 'package:ekvi/Components/Insights/StressCharts/insights_maximum_stress_chart.dart';
import 'package:ekvi/Components/Insights/StressCharts/insights_stress_tags.dart';
import 'package:ekvi/Providers/DailyTracker/Stress/stress_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StressCharts extends StatelessWidget {
  const StressCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StressProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageStressChartData.isDataLoaded
              ? InsightsAverageStressChart(
                  data: value.insightsAverageStressChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsMaximumStressChartData.isDataLoaded
              ? InsightsMaximumStressChart(
                  data: value.insightsMaximumStressChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsStressTags(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
