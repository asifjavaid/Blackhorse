import 'package:ekvi/Components/Insights/MoodCharts/insights_average_mood_chart.dart';
import 'package:ekvi/Components/Insights/MoodCharts/insights_maximum_mood_chart.dart';
import 'package:ekvi/Components/Insights/MoodCharts/insights_mood_tags.dart';
import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoodCharts extends StatelessWidget {
  const MoodCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageMoodChartData.isDataLoaded
              ? InsightsAverageMoodChart(
                  data: value.insightsAverageMoodChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsMaximumMoodChartData.isDataLoaded
              ? InsightsMaximumMoodChart(
                  data: value.insightsMaximumMoodChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          InsightsMoodTags(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
