import 'package:ekvi/Models/DailyTracker/Bleeding/insights_bleeding_in_circles_chart_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InsightsBleedingInCircles extends StatefulWidget {
  final InisghtsBleedingInCircleModel data;

  const InsightsBleedingInCircles({super.key, required this.data});

  @override
  InsightsBleedingInCirclesState createState() => InsightsBleedingInCirclesState();
}

class InsightsBleedingInCirclesState extends State<InsightsBleedingInCircles> {
  final GlobalKey<SfCartesianChartState> chartKey = GlobalKey<SfCartesianChartState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.23),
          ),
          shadows: const [AppThemes.shadowDown]),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your bleeding in circles', style: textTheme.headlineSmall),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Days with tracked bleeding', style: textTheme.bodySmall!.copyWith(color: AppColors.neutralColor500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          BleedingCirclesGrid(trackingData: widget.data.trackingData!),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const ShapeDecoration(
                      color: AppColors.errorColor500,
                      shape: OvalBorder(),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Bleeding tracked",
                    style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500),
                  )
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const ShapeDecoration(
                      color: AppColors.neutralColor300,
                      shape: OvalBorder(),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "No bleeding tracked",
                    style: textTheme.labelSmall!.copyWith(
                      color: AppColors.neutralColor500,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class BleedingCirclesGrid extends StatelessWidget {
  final Map<String, List<BleedingCircle>> trackingData;

  const BleedingCirclesGrid({super.key, required this.trackingData});

  String formatMonth(String monthKey) {
    DateTime parsedDate = DateFormat('yyyy-MM').parse(monthKey);
    return DateFormat('MMM').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // Calculate the maximum number of days in any month
    int maxDays = trackingData.values.map((days) => days.length).reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1",
                style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500, fontSize: 8),
              ),
              Text(
                "15",
                style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500, fontSize: 8),
              ),
              Text(
                "31",
                style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500, fontSize: 8),
              )
            ],
          ),
        ),
        ...trackingData.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 26,
                  child: Text(
                    formatMonth(entry.key),
                    style: textTheme.labelSmall!.copyWith(color: AppColors.neutralColor500, fontSize: 8),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double availableWidth = constraints.maxWidth;
                      double totalCircleWidth = maxDays * 6;
                      double totalSpacingWidth = availableWidth - totalCircleWidth;
                      double spacing = totalSpacingWidth / (maxDays - 1);

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Row(
                          children: entry.value.map((dayTracking) {
                            return Padding(
                              padding: EdgeInsets.only(right: spacing),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: dayTracking.hasBleeding ? AppColors.errorColor500 : AppColors.neutralColor300,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
