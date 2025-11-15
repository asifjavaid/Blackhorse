import 'package:ekvi/Components/Insights/chart_helper.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsPainkillerPillsChart extends StatefulWidget {
  final InsightsGraphModel data;

  const InsightsPainkillerPillsChart({super.key, required this.data});

  @override
  InsightsPainkillerPillsChartState createState() =>
      InsightsPainkillerPillsChartState();
}

class InsightsPainkillerPillsChartState
    extends State<InsightsPainkillerPillsChart> {
  final GlobalKey<SfCartesianChartState> chartKey =
      GlobalKey<SfCartesianChartState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<InsightsSymptomTimeSelectionProvider>(context);
    bool isAmountTaken = (provider.selectedActiveIngredient.isNotEmpty &&
        provider.selectedActiveIngredient != 'All active ingredients');
    var timeFrame = provider.selectionType == TimeFrameSelection.oneMonth
        ? 'per day'
        : provider.selectionType == TimeFrameSelection.threeMonths
            ? 'per week'
            : 'per month';
    return Container(
      padding: const EdgeInsets.all(16.23),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.23)),
          shadows: const [AppThemes.shadowDown]),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PremiumIconWidget(),
                        Text(isAmountTaken ? 'Amount taken' : 'Pills taken',
                            style: textTheme.headlineSmall),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => HelperFunctions.openCustomBottomSheet(
                              context,
                              content: const PillsTakenDialog(),
                              height: isAmountTaken ? 580 : 640),
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
                    Text(
                        isAmountTaken
                            ? 'Total amount of ${provider.selectedActiveIngredient} taken'
                            : 'Total amount of painkiller units taken',
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColors.neutralColor500)),
                  ],
                ),
              ),
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
              Text(
                  isAmountTaken
                      ? 'Average amount taken'
                      : 'Average pills taken $timeFrame',
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
          minimum: 0,
          labelStyle: textTheme.labelSmall!.copyWith(
            color: AppColors.neutralColor400,
            fontSize: 8,
          ),
          interval: getYAxisInterval(widget.data.getMaxValue()),
          majorGridLines:
              const MajorGridLines(width: 1, color: AppColors.neutralColor200),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: ChartHelper.getPadUsageSeries(widget.data),
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

class PillsTakenDialog extends StatelessWidget {
  const PillsTakenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InsightsSymptomTimeSelectionProvider>(context);
    bool isAmountTaken = (provider.selectedActiveIngredient.isNotEmpty &&
        provider.selectedActiveIngredient != 'All active ingredients');
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What does it mean?',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(TextSpan(
            children: [
              isAmountTaken
                  ? _SubtitleText(
                      "This graph shows how much of each active ingredient/painkiller you’ve taken over time, helping you spot patterns and figure out what’s working best for your body.\n",
                      textTheme)
                  : _SubtitleText(
                      "This graph adds up all the painkiller “units” you’ve tracked over a chosen time period. For example, if you take two tablets of Paracetamol in the morning and one Ibuprofen pill in the afternoon, that day would show up as three units total.\n",
                      textTheme),
            ],
          )),
          isAmountTaken
              ? Text(
                  "To keep things accurate, each active ingredient is shown in just one type of unit (like mg).\n",
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.neutralColor600,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : Text(
                  'Why is this helpful?',
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.neutralColor600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          isAmountTaken
              ? Text.rich(TextSpan(children: [
                  _SubtitleText(
                      "If you switch between different forms – like pills in mg and creams in mg/g – the graph can’t combine them (for now).\n\nSticking to one unit type per ingredient makes it easier "
                      "for you and your healthcare provider to get a clear view of your intake. This clarity helps guide better conversations and decisions about your pain management, whether it’s "
                      "fine-tuning a current regimen or exploring new options.\n",
                      textTheme),
                ]))
              : Text.rich(TextSpan(children: [
                  _SubtitleText(
                      "It gives you a clear, at-a-glance idea of how often you rely on pain relief. Over days, weeks, or months, these numbers can help you spot patterns – maybe you tend to need more "
                      "painkillers before your period, or on days when your schedule is extra busy.\n\nIt’s also a great way for your healthcare provider to understand your typical painkiller use. By "
                      "seeing your total “units” at a glance, they can better gauge how your treatment plan is working and consider if any adjustments might help you manage your symptoms more effectively.\n",
                      textTheme),
                ])),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SubtitleText extends TextSpan {
  _SubtitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            height: 1.60,
          ),
        );
}
