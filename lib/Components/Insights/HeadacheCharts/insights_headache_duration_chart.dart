import 'package:ekvi/Components/Insights/chart_helper.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsHeadacheDurationChart extends StatefulWidget {
  final InsightsGraphModel data;

  const InsightsHeadacheDurationChart({super.key, required this.data});

  @override
  InsightsHeadacheDurationChartState createState() =>
      InsightsHeadacheDurationChartState();
}

class InsightsHeadacheDurationChartState
    extends State<InsightsHeadacheDurationChart> {
  final GlobalKey<SfCartesianChartState> chartKey =
      GlobalKey<SfCartesianChartState>();

  @override
  void initState() {
    super.initState();
  }

  String getHeadacheDurationLabel(TimeFrameSelection selectionType) {
    switch (selectionType) {
      case TimeFrameSelection.oneMonth:
        return 'Total amount of hours with headache per day';
      case TimeFrameSelection.threeMonths:
        return 'Total amount of hours with headache per week';
      case TimeFrameSelection.oneYear:
        return 'Total amount of hours with headache per month';
      default:
        return 'Total amount of hours with headache per week';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<InsightsSymptomTimeSelectionProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16.23),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.23),
          ),
          shadows: const [AppThemes.shadowDown]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Headache duration', style: textTheme.headlineSmall),
          const SizedBox(height: 9),
          Text(
            getHeadacheDurationLabel(provider.selectionType),
            style: textTheme.bodySmall!.copyWith(
              color: AppColors.neutralColor500,
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
          const SizedBox(height: 24),
          ChartArea(
            data: widget.data,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Average duration',
                  style: textTheme.labelSmall!
                      .copyWith(color: AppColors.neutralColor500)),
              const SizedBox(width: 5.07),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: ShapeDecoration(
                  color: AppColors.errorColor400,
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
        primaryXAxis: CategoryAxis(
            labelPosition: ChartDataLabelPosition.outside,
            labelAlignment: LabelAlignment.center,
            placeLabelsNearAxisLine: false,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
            interval: isDailyInterval ? 2 : 1,
            axisLabelFormatter: (axisLabelRenderArgs) =>
                ChartHelper.axisLabelFormatter(
                    axisLabelRenderArgs, isDailyInterval, firstDatesOfMonth),
            majorGridLines: const MajorGridLines(width: 0),
            labelStyle: textTheme.labelSmall!
                .copyWith(color: AppColors.neutralColor400, fontSize: 8)),
        primaryYAxis: NumericAxis(
          plotOffset: 0,
          axisLine: const AxisLine(width: 0),
          labelStyle: textTheme.labelSmall!.copyWith(
            color: AppColors.neutralColor400,
            fontSize: 8,
          ),
          majorGridLines:
              const MajorGridLines(width: 1, color: AppColors.neutralColor200),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: ChartHelper.getHeadacheDurationBarSeries(widget.data),
      ),
    );
  }
}
