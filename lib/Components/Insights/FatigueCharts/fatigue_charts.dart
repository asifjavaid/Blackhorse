import 'package:ekvi/Components/Insights/FatigueCharts/insights_average_fatigue_chart.dart';
import 'package:ekvi/Components/Insights/FatigueCharts/insights_fatigue_tags.dart';
import 'package:ekvi/Components/Insights/FatigueCharts/insights_maximum_fatigue_chart.dart';
import 'package:ekvi/Providers/DailyTracker/Fatigue/fatigue_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FatigueCharts extends StatelessWidget {
  const FatigueCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FatigueProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageFatigueChartData.isDataLoaded
              ? InsightsAverageFatigueChart(
                  data: value.insightsAverageFatigueChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsMaximumFatigueChartData.isDataLoaded
              ? InsightsMaximumFatigueChart(
                  data: value.insightsMaximumFatigueChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsFatigueTags(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
