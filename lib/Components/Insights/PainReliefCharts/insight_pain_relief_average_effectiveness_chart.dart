import 'package:ekvi/Components/Insights/insights_expand_graph.dart';
import 'package:ekvi/Components/Insights/chart_helper.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Providers/Insights/multi_symptoms_chart_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsPainReliefAverageEffectivenessChart extends StatefulWidget {
  final InsightsGraphModel data;

  const InsightsPainReliefAverageEffectivenessChart({super.key, required this.data});

  @override
  State<InsightsPainReliefAverageEffectivenessChart> createState() => _InsightsPainReliefAverageEffectivenessChartState();
}

class _InsightsPainReliefAverageEffectivenessChartState extends State<InsightsPainReliefAverageEffectivenessChart> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<InsightsSymptomTimeSelectionProvider>(context);
    final timeFrame = provider.selectionType == TimeFrameSelection.oneMonth
        ? '1 month'
        : provider.selectionType == TimeFrameSelection.threeMonths
            ? '3 months'
            : '1 year';

    return Container(
      padding: const EdgeInsets.all(16.23),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.23),
        ),
        shadows: const [AppThemes.shadowDown],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Average effectiveness', style: textTheme.headlineSmall),
              const Spacer(),
              InsightsExpandGraphWidget(
                onTap: () {
                  Provider.of<MultiSymptomsChartProvider>(context, listen: false).initializeGraphType(MultiSymptomChartType.max);
                  AppNavigation.navigateTo(AppRoutes.multisymptomschart);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _ChartArea(data: widget.data),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Average effectiveness over $timeFrame',
                style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500),
              ),
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

class _ChartArea extends StatelessWidget {
  final InsightsGraphModel data;

  const _ChartArea({required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDailyInterval = data.isDailyInterval;
    final allChartData = ChartHelper.getAllChartData(data.graphData);
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
                interval: 2,
                intervalType: DateTimeIntervalType.days,
                dateFormat: DateFormat.d(),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 8),
              )
            : CategoryAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                labelAlignment: LabelAlignment.center,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                interval: 1,
                axisLabelFormatter: (args) => ChartHelper.axisLabelFormatter(args, isDailyInterval, firstDatesOfMonth),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 8),
              ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          interval: 1,
          minimum: 0,
          maximum: 10,
          labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 8),
          majorGridLines: const MajorGridLines(width: 1, color: AppColors.neutralColor200),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: ChartHelper.getAveragePainLineSeries(data.graphData!),
      ),
    );
  }
}
