// import 'package:collection/collection.dart';
import 'package:ekvi/Components/Insights/insights_expand_graph.dart';
import 'package:ekvi/Components/Insights/chart_helper.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsAverageMoodChart extends StatefulWidget {
  final InsightsGraphModel data;
  const InsightsAverageMoodChart({super.key, required this.data});

  @override
  InsightsAverageMoodChartState createState() => InsightsAverageMoodChartState();
}

class InsightsAverageMoodChartState extends State<InsightsAverageMoodChart> {
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
          shadows: const [AppThemes.shadowDown]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const PremiumIconWidget(), Text('Average mood levels', style: textTheme.headlineSmall), const Spacer(), const InsightsExpandGraphWidget()],
          ),
          const SizedBox(height: 24),
          ChartArea(
            data: widget.data,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Average Mood', style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500)),
              const SizedBox(width: 5.07),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: ShapeDecoration(
                  color: AppColors.accentColorFour400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  HelperFunctions.validateNumeric(widget.data.average),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.neutralColor600,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChartArea extends StatefulWidget {
  final InsightsGraphModel data;

  const ChartArea({super.key, required this.data});

  @override
  State<ChartArea> createState() => _ChartAreaState();
}

class _ChartAreaState extends State<ChartArea> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDailyInterval = widget.data.isDailyInterval;
    final allChartData = ChartHelper.getAllChartData(widget.data.graphData);
    final firstDatesOfMonth = ChartHelper.getFirstDatesOfMonth(allChartData);

    return SizedBox(
      height: 25.h,
      child: SfCartesianChart(
        margin: EdgeInsets.zero,
        plotAreaBorderWidth: 0,
        enableAxisAnimation: true,
        primaryXAxis: isDailyInterval
            ? DateTimeAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                labelAlignment: LabelAlignment.center,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                interval: isDailyInterval ? 2 : 1,
                intervalType: isDailyInterval ? DateTimeIntervalType.days : DateTimeIntervalType.months,
                dateFormat: isDailyInterval ? DateFormat.d() : DateFormat('MMM'),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 8))
            : CategoryAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                labelAlignment: LabelAlignment.center,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                interval: isDailyInterval ? 2 : 1,
                axisLabelFormatter: (axisLabelRenderArgs) => ChartHelper.axisLabelFormatter(axisLabelRenderArgs, isDailyInterval, firstDatesOfMonth),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 8)),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          interval: 1,
          minimum: 0,
          maximum: 10,
          labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 8),
          majorGridLines: const MajorGridLines(width: 1, color: AppColors.neutralColor200),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: ChartHelper.getAverageMoodLineSeries(widget.data.graphData!),
      ),
    );
  }
}
