import 'package:ekvi/Components/Insights/chart_helper.dart';
import 'package:ekvi/Models/Insights/insights_time_of_day_graph_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsTimeOfDayBowelMovementsChart extends StatefulWidget {
  final InsightsTimeOfDayGraphModel data;
  final VoidCallback enableHelpCallback;

  const InsightsTimeOfDayBowelMovementsChart(
      {super.key, required this.data, required this.enableHelpCallback});

  @override
  State<InsightsTimeOfDayBowelMovementsChart> createState() =>
      _InsightsTimeOfDayBowelMovementsChartState();
}

class _InsightsTimeOfDayBowelMovementsChartState
    extends State<InsightsTimeOfDayBowelMovementsChart> {
  final GlobalKey<SfCartesianChartState> chartKey =
      GlobalKey<SfCartesianChartState>();

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
                    Text('Time of day', style: textTheme.headlineSmall),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.enableHelpCallback,
                child: SvgPicture.asset(
                  "${AppConstant.assetIcons}info.svg",
                  semanticsLabel: 'Cycle Calendar Info',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text('See when your bowel movement happened most throughout your day',
              style: textTheme.bodySmall!
                  .copyWith(color: AppColors.neutralColor500)),
          const SizedBox(height: 24),
          BowelMovementsChart(
            data: widget.data,
          ),
        ],
      ),
    );
  }
}

class BowelMovementsChart extends StatefulWidget {
  final InsightsTimeOfDayGraphModel data;

  const BowelMovementsChart({super.key, required this.data});

  @override
  State<BowelMovementsChart> createState() => _BowelMovementsChartState();
}

class _BowelMovementsChartState extends State<BowelMovementsChart> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 25.h,
      child: SfCartesianChart(
        margin: EdgeInsets.zero,
        plotAreaBorderWidth: 0,
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
            labelPosition: ChartDataLabelPosition.outside,
            labelAlignment: LabelAlignment.center,
            placeLabelsNearAxisLine: false,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
            maximumLabels: 5,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            majorGridLines: const MajorGridLines(width: 0),
            labelStyle: textTheme.labelSmall!
                .copyWith(color: AppColors.neutralColor400, fontSize: 8)),
        primaryYAxis: NumericAxis(
          plotOffset: 0,
          interval: getYAxisInterval(widget.data.getMaxValue()),
          axisLine: const AxisLine(width: 0),
          minimum: 0,
          labelStyle: textTheme.labelSmall!.copyWith(
              color: AppColors.neutralColor400,
              fontSize: 8,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            final value = details.value.toInt().toString();
            return ChartAxisLabel(
                value,
                details.textStyle.copyWith(
                    color: AppColors.neutralColor400,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'));
          },
          majorGridLines:
              const MajorGridLines(width: 1, color: AppColors.neutralColor200),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: ChartHelper.getTimeOfDayBarSeries(widget.data),
      ),
    );
  }
}

double getYAxisInterval(int maxValue) {
  if (maxValue < 10) {
    return 1;
  } else if (maxValue <= 30) {
    return 2;
  } else if (maxValue <= 50) {
    return 5;
  } else if (maxValue <= 100) {
    return 10;
  } else if (maxValue <= 200) {
    return 20;
  } else {
    return 50;
  }
}
