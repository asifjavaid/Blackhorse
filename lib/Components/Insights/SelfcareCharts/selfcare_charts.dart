import 'package:ekvi/Components/Insights/SelfcareCharts/insight_selfcare_average_enjoyment_chart.dart';
import 'package:ekvi/Components/Insights/SelfcareCharts/insight_selfcare_enjoyment_by_practice_chart.dart';
import 'package:ekvi/Components/Insights/SelfcareCharts/insight_selfcare_in_circles_chart.dart';
import 'package:ekvi/Components/Insights/SelfcareCharts/insights_selfcare_practices_tags.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelfcareCharts extends StatelessWidget {
  const SelfcareCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelfcareProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          if (value.insightsAverageEnjoymentChartData.isDataLoaded) ...{
            InsightsSelfcareAverageEnjoymentChart(
              data: value.insightsAverageEnjoymentChartData,
            ),
            const SizedBox(
              height: 24,
            ),
          },
          if (value.selfCareTagsCounts.isDataLoaded) ...{
            const InsightsSelfcarePracticesTags(),
            const SizedBox(
              height: 24,
            ),
          },
          if (value.selfCareTagsCounts.isDataLoaded) ...{
            const EnjoymentByPracticeCard(),
            const SizedBox(
              height: 24,
            ),
          },
          if (value.selfCareInCircleModel.isDataLoaded ?? false) ...{
            InsightsSelfcareCircles(
              data: value.selfCareInCircleModel,
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
