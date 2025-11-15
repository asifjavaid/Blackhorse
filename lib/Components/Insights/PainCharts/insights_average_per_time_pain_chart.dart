import 'package:ekvi/Components/Insights/chart_helper.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsAveragePerTimePainChart extends StatefulWidget {
  const InsightsAveragePerTimePainChart({super.key});

  @override
  InsightsAveragePerTimePainChartState createState() => InsightsAveragePerTimePainChartState();
}

class InsightsAveragePerTimePainChartState extends State<InsightsAveragePerTimePainChart> {
  final GlobalKey<SfCartesianChartState> chartKey = GlobalKey<SfCartesianChartState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.23),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.23),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Timing of the pain', style: textTheme.headlineSmall),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Average pain level during time of the day.', style: textTheme.bodySmall!.copyWith(color: AppColors.neutralColor500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const ChartArea(),
        ],
      ),
    );
  }
}

class ChartArea extends StatefulWidget {
  const ChartArea({super.key});

  @override
  State<ChartArea> createState() => _ChartAreaState();
}

class _ChartAreaState extends State<ChartArea> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 25.h,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 10, fontWeight: FontWeight.w500),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          interval: 1,
          minimum: 0,
          maximum: 10,
          labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 10, fontWeight: FontWeight.w500),
          majorGridLines: const MajorGridLines(width: 1, color: AppColors.neutralColor200),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: ChartHelper.getAveragePainPerTimeSeries(),
      ),
    );
  }
}
