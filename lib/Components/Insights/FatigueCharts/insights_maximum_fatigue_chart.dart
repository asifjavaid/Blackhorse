import 'package:ekvi/Components/Insights/chart_helper.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsMaximumFatigueChart extends StatefulWidget {
  final InsightsGraphModel data;

  const InsightsMaximumFatigueChart({super.key, required this.data});

  @override
  InsightsMaximumFatigueChartState createState() => InsightsMaximumFatigueChartState();
}

class InsightsMaximumFatigueChartState extends State<InsightsMaximumFatigueChart> {
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
            children: [
              const PremiumIconWidget(),
              Text('Maximum fatigue levels', style: textTheme.headlineSmall),
              const Spacer(),
              // GestureDetector(
              //     onTap: () {
              //       Provider.of<MultiSymptomsChartProvider>(context, listen: false).initializeGraphType(MultiSymptomChartType.max);
              //       AppNavigation.navigateTo(
              //         AppRoutes.multisymptomschart,
              //       );
              //     },
              //     child: Container(
              //       width: 36,
              //       height: 36,
              //       decoration: const ShapeDecoration(
              //         color: AppColors.actionColor400,
              //         shape: OvalBorder(),
              //       ),
              //       child: Center(
              //         child: SizedBox(
              //           height: 16,
              //           width: 16,
              //           child: SvgPicture.asset(
              //             "${AppConstant.assetIcons}expand.svg",
              //           ),
              //         ),
              //       ),
              //     ))
            ],
          ),
          const SizedBox(height: 24),
          ChartArea(
            data: widget.data,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Maximum Fatigue', style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500)),
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
            axisLabelFormatter: (axisLabelRenderArgs) => ChartHelper.axisLabelFormatter(axisLabelRenderArgs, isDailyInterval, firstDatesOfMonth),
            majorGridLines: const MajorGridLines(width: 0),
            labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 8)),
        primaryYAxis: NumericAxis(
          plotOffset: 0,
          axisLine: const AxisLine(width: 0),
          interval: 1,
          minimum: 0,
          maximum: 10,
          labelStyle: textTheme.labelSmall!.copyWith(
            color: AppColors.neutralColor400,
            fontSize: 8,
          ),
          majorGridLines: const MajorGridLines(width: 1, color: AppColors.neutralColor200),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: ChartHelper.getMaximumFatigueBarSeries(widget.data),
      ),
    );
  }
}
