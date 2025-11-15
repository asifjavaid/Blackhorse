import 'package:ekvi/Components/Insights/HeadacheCharts/insights_average_headache_chart.dart';
import 'package:ekvi/Components/Insights/HeadacheCharts/insights_maximum_headache_chart.dart';
import 'package:ekvi/Components/Insights/HeadacheCharts/insights_headache_tags.dart';
import 'package:ekvi/Components/Insights/HeadacheCharts/insights_headache_duration_chart.dart';
import 'package:ekvi/Components/Insights/HeadacheCharts/insights_headache_impact_grid.dart';
import 'package:ekvi/Providers/DailyTracker/Headache/headache_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadacheCharts extends StatelessWidget {
  const HeadacheCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(height: 24),
          value.insightsAverageHeadacheChartData.isDataLoaded
              ? InsightsAverageHeadacheChart(
                  data: value.insightsAverageHeadacheChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 24),
          value.insightsMaximumHeadacheChartData.isDataLoaded
              ? InsightsMaximumHeadacheChart(
                  data: value.insightsMaximumHeadacheChartData,
                )
              : const SizedBox.shrink(),
          value.insightsHeadacheTagsData.isDataLoaded
              ? const InsightsHeadacheTags()
              : const SizedBox.shrink(),
          const SizedBox(height: 24),
          value.insightsHeadacheDurationChartData.isDataLoaded
              ? InsightsHeadacheDurationChart(
                  data: value.insightsHeadacheDurationChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 24),
          value.insightsHeadacheTagsData.isDataLoaded &&
                  value.insightsHeadacheTagsData.graphData?.partOfLifeEffect !=
                      null &&
                  value.insightsHeadacheTagsData.graphData!.partOfLifeEffect!
                      .isNotEmpty
              ? InsightsHeadacheImpactGrid(
                  data: value.insightsHeadacheTagsData,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
