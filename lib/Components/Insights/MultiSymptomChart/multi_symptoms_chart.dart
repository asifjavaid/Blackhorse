import 'package:ekvi/Components/Insights/MultiSymptomChart/multi_symptom_time_selection.dart';
import 'package:ekvi/Models/Insights/insights_graph_model.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Providers/Insights/multi_symptoms_chart_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

import '../../../generated/assets.dart';

class MultiSymptomsChart extends StatefulWidget {
  const MultiSymptomsChart({
    super.key,
  });

  @override
  MultiSymptomsChartChartState createState() => MultiSymptomsChartChartState();
}

class MultiSymptomsChartChartState extends State<MultiSymptomsChart> {
  var provider = Provider.of<MultiSymptomsChartProvider>(AppNavigation.currentContext!, listen: false);
  @override
  void initState() {
    provider.initialize();
    super.initState();
  }

  @override
  void dispose() {
    provider.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MultiSymptomsChartProvider>(
        builder: (context, value, child) => Scaffold(
              body: SafeArea(
                  child: RotatedBox(
                quarterTurns: 1,
                child: Container(
                  padding: const EdgeInsets.all(16.23),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.23),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 16),
                      const MultiSymptomTimeSelection(),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Stack(
                          children: [
                            ChartArea(series: value.series, selectionType: value.selectionType),
                            if (value.isLoading)
                              BackdropFilter(
                                filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: Container(
                                  color: Colors.white.withOpacity(0.8),
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      value.compareSymptoms.isNotEmpty
                          ? ComparedSymptoms(
                              onEditTap: () => AppNavigation.navigateTo(AppRoutes.multisymptomselection),
                              onSymptomTap: value.onSymptomRemove,
                              compareSymptoms: value.compareSymptoms,
                            )
                          : CompareSymptomsButton(
                              onTap: () => AppNavigation.navigateTo(AppRoutes.multisymptomselection),
                            )
                    ],
                  ),
                ),
              )),
            ));
  }
}

class ChartArea extends StatelessWidget {
  final List<CartesianSeries<GraphData, DateTime>> series;
  final TimeFrameSelection selectionType;

  const ChartArea({super.key, required this.series, required this.selectionType});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SfCartesianChart(
      margin: EdgeInsets.zero,
      plotAreaBorderWidth: 0,
      enableAxisAnimation: false,
      zoomPanBehavior: ZoomPanBehavior(enablePinching: false, enablePanning: true, zoomMode: ZoomMode.x, enableDoubleTapZooming: false),
      primaryXAxis: DateTimeCategoryAxis(
        autoScrollingDelta: selectionType == TimeFrameSelection.oneMonth ? 15 : 4,
        autoScrollingMode: AutoScrollingMode.start,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelAlignment: LabelAlignment.center,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        interval: 1,
        majorGridLines: const MajorGridLines(width: 0),
        labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 10),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        interval: 1,
        minimum: 0,
        maximum: 10,
        labelStyle: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor400, fontSize: 10),
        majorGridLines: const MajorGridLines(width: 1, color: AppColors.neutralColor200),
        majorTickLines: const MajorTickLines(width: 0),
      ),
      series: series,
    );
  }
}

class CompareSymptomsButton extends StatelessWidget {
  final VoidCallback onTap;
  const CompareSymptomsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            child: Ink(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: AppColors.actionColor600),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SvgPicture.asset(
                    Assets.customiconsFilters,
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Compare Symptoms",
                    style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SvgPicture.asset(
                    Assets.customiconsArrowDown,
                    height: 16,
                    width: 16,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ComparedSymptoms extends StatelessWidget {
  final VoidCallback onEditTap;
  final Function(InisghtsSymptom) onSymptomTap;
  final List<InisghtsSymptom> compareSymptoms;
  const ComparedSymptoms({super.key, required this.onEditTap, required this.onSymptomTap, required this.compareSymptoms});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              color: Colors.white,
              child: InkWell(
                onTap: onEditTap,
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: AppColors.actionColor600),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        "Edit symptoms to compare",
                        style: textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset(
                        Assets.customiconsPen,
                        height: 16,
                        width: 16,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            ...compareSymptoms.map(
              (symptom) => Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(30), border: Border.all(width: 2, color: symptom.color ?? AppColors.actionColor600)),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      symptom.icon ?? "",
                      height: 16,
                      width: 16,
                      color: AppColors.neutralColor600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      symptom.name,
                      style: textTheme.titleSmall!.copyWith(
                        color: AppColors.neutralColor600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => onSymptomTap(symptom),
                      child: SvgPicture.asset(
                        Assets.customiconsDelete,
                        height: 16,
                        width: 16,
                        color: symptom.color ?? AppColors.neutralColor600,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
