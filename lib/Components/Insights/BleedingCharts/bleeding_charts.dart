import 'package:ekvi/Components/Insights/BleedingCharts/bleeding_tags.dart';
import 'package:ekvi/Components/Insights/BleedingCharts/insights_average_bleeding_chart.dart';
import 'package:ekvi/Components/Insights/BleedingCharts/insights_average_pads_chart.dart';
import 'package:ekvi/Components/Insights/BleedingCharts/insights_bleeding_in_circles.dart';
import 'package:ekvi/Providers/DailyTracker/Bleeding/bleeding_provider.dart';
// import 'package:ekvi/Components/Insights/BleedingCharts/insights_average_pads_chart.dart';
// import 'package:ekvi/Components/Insights/BleedingCharts/insights_bleeding_in_circles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BleedingCharts extends StatelessWidget {
  const BleedingCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BleedingProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageBleedingChartData.isDataLoaded
              ? InsightsAverageBleedingChart(
                  data: value.insightsAverageBleedingChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsBleedingPadsChartData.isDataLoaded
              ? InsightsPadsChart(
                  data: value.insightsBleedingPadsChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsBleedingTags(),
          value.insightsBlleedingInCircleData.isDataLoaded != null && value.insightsBlleedingInCircleData.isDataLoaded!
              ? InsightsBleedingInCircles(
                  data: value.insightsBlleedingInCircleData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
