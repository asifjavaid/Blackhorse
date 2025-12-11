import 'package:ekvi/Models/DailyTracker/Headache/headache_insights_models.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_info_table.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Models/DailyTracker/Urination/urination_tag_list.dart';

class InsightsUrinationImpactGrid extends StatefulWidget {
  final UrinaitonTagList data;
  const InsightsUrinationImpactGrid({super.key, required this.data});

  @override
  State<InsightsUrinationImpactGrid> createState() =>
      _InsightsHeadacheImpactGridState();
}

class _InsightsHeadacheImpactGridState
    extends State<InsightsUrinationImpactGrid> {
  String title = 'Effect on your quality of life';
  String subtitle =
      'This overview shows how often your urination has impacted your life in the following categories:';
  String description =
      'Tracking this information is useful for both you and your healthcare provider. It helps in understanding the extent of the impact and in making informed decisions about your treatment and care.';
  String trailing =
      'Understanding these impacts can help you better manage your symptoms.';

  List<Map<String, String>> helpText = [
    {
      "title": "Work: ",
      "desc": "The effect of urination on your job or daily work activities."
    },
    {
      "title": "Social life: ",
      "desc":
      "How urination influences your interactions and social activities."
    },
    {
      "title": "Sleep: ",
      "desc": "The impact of urination on your sleep quality."
    },
    {
      "title": "Quality of life: ",
      "desc": "The overall effect of urination on your daily well-being."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return (widget.data.isDataLoaded &&
        widget.data.graphData?.partOfLifeEffect != null &&
        widget.data.graphData!.partOfLifeEffect!.isNotEmpty)
        ? Column(
      children: [
        CustomInfoTable(
          title: title,
          partOfLifeEffects: widget.data.graphData?.partOfLifeEffect,
          elevated: true,
          width: 100.w,
          height: 100.h,
          margin: EdgeInsets.zero,
          backgroundColor: AppColors.whiteColor,
          enableHelp: true,
          enableHelpCallback: () => HelperFunctions.openCustomBottomSheet(
              context,
              content: _helpPanel(title, subtitle, helpText, description),
              height: 550),
        ),
      ],
    )
        : const SizedBox.shrink();
  }
}

Widget _helpPanel(
    String title,
    String subTitle,
    List<Map<String, String>> descriptors,
    String trailing,
    ) {
  final textTheme = Theme.of(AppNavigation.currentContext!).textTheme;

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.neutralColor600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),

        // Subtitle (kept intact as full paragraph)
        Text(
          subTitle,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),

        // Descriptors (bulleted list with proper indent)
        ...descriptors.map((d) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bullet
              Text(
                " • ",
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              // Title + description (wraps with indent)
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${d["title"]}: ",
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.neutralColor600,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: d["desc"],
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.neutralColor600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),

        const SizedBox(height: 16),

        // Trailing tip
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: trailing,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}
