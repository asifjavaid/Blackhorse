import 'package:ekvi/Components/DailyTracker/BowelMovement/time_of_day_widget.dart';
import 'package:ekvi/Components/Insights/UrinationCharts/insights_average_urination_chart.dart';
import 'package:ekvi/Components/Insights/UrinationCharts/insights_urination_circle_chart.dart';
import 'package:ekvi/Components/Insights/UrinationCharts/insights_urination_tags.dart';
import 'package:ekvi/Components/Insights/UrinationCharts/insights_urination_time_of_day_chart.dart';
import 'package:ekvi/Providers/DailyTracker/Urination/urination_provider.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UrinationCharts extends StatelessWidget {
  const UrinationCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UrinationProvider>(
      builder: (context, value, child) => Column(
        children: [
          if (value.insightsAverageBMChartData.isDataLoaded) ...{
            const SizedBox(
              height: 24,
            ),
            InsightsAverageUrinationsChart(
              data: value.insightsAverageBMChartData,
            )
          },
          const InsightsUrinationsTags(),
          if (value.insightsTimeDayBMChartData.isDataLoaded) ...{
            const SizedBox(
              height: 24,
            ),
            InsightsTimeOfDayUrinationsChart(
              data: value.insightsTimeDayBMChartData,
              enableHelpCallback: () {
                HelperFunctions.openCustomBottomSheet(context, content: const TimeOfDayWidget(), height: 700);
              },
            )
          },
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
