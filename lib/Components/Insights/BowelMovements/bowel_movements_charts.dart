import 'package:ekvi/Components/DailyTracker/BowelMovement/time_of_day_widget.dart';
import 'package:ekvi/Components/Insights/BowelMovements/insights_average_bowel_movements_chart.dart';
import 'package:ekvi/Components/Insights/BowelMovements/insights_bowel_movement_circle_chart.dart';
import 'package:ekvi/Components/Insights/BowelMovements/insights_bowel_movements_tags.dart';
import 'package:ekvi/Components/Insights/BowelMovements/insights_bowel_movements_time_of_day_chart.dart';
import 'package:ekvi/Providers/DailyTracker/BowelMovement/bowel_movement_provider.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BowelMovementsCharts extends StatelessWidget {
  const BowelMovementsCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BowelMovementProvider>(
      builder: (context, value, child) => Column(
        children: [
          if (value.insightsAverageBMChartData.isDataLoaded) ...{
            const SizedBox(
              height: 24,
            ),
            InsightsAverageBowelMovementsChart(
              data: value.insightsAverageBMChartData,
            )
          },
          if (value.insightsTimeDayBMChartData.isDataLoaded) ...{
            const SizedBox(
              height: 24,
            ),
            InsightsTimeOfDayBowelMovementsChart(
              data: value.insightsTimeDayBMChartData,
              enableHelpCallback: () {
                HelperFunctions.openCustomBottomSheet(context, content: const TimeOfDayWidget(), height: 700);
              },
            )
          },
          const InsightsBowelMovementsTags(),
          if (value.insightsBMCircleChartData.isDataLoaded ?? false) ...{
            const SizedBox(
              height: 24,
            ),
            InsightsBowelMovementCircles(
              data: value.insightsBMCircleChartData,
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
