import 'package:ekvi/Components/Insights/MovementCharts/insight_movement_circle_chart.dart';
import 'package:ekvi/Components/Insights/MovementCharts/insight_movement_duration_chart.dart';
import 'package:ekvi/Components/Insights/MovementCharts/insights_movement_practices_tags.dart';
import 'package:ekvi/Components/Insights/MovementCharts/insight_movement_average_enjoyment_chart.dart';
import 'package:ekvi/Components/Insights/MovementCharts/insights_movement_average_intensity_chart.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovementChart extends StatelessWidget {
  const MovementChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovementProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          if (value.insightsAverageIntensityChartData.isDataLoaded) ...{
            InsightsAverageIntensityChart(
              data: value.insightsAverageIntensityChartData,
            ),
            const SizedBox(
              height: 24,
            ),
          },
          if (value.insightsAverageEnjoymentChartData.isDataLoaded) ...{
            InsightsAverageEnjoymentChart(
              data: value.insightsAverageEnjoymentChartData,
            ),
            const SizedBox(
              height: 24,
            ),
          },
          if (value.insightMovementDurationChartData.isDataLoaded) ...{
            InsightsMovementDurationChart(
              data: value.insightMovementDurationChartData,
            ),
            const SizedBox(
              height: 24,
            ),
          },
          const InsightsMovementPracticesTags(),
          if (value.movementInCirclesModel.isDataLoaded ?? false) ...{
            const SizedBox(
              height: 24,
            ),
            InsightsMovementCircles(
              data: value.movementInCirclesModel,
            ),
          },
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
