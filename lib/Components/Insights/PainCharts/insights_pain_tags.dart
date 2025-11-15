import 'package:ekvi/Models/DailyTracker/BodyPain/body_pain_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/Insights/insights_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_info_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsPainTags extends StatefulWidget {
  final BodyPainTags data;
  const InsightsPainTags({super.key, required this.data});

  @override
  State<InsightsPainTags> createState() => _InsightsPainTagsState();
}

class _InsightsPainTagsState extends State<InsightsPainTags> {
  String title = 'Effect on your quality of life';
  String subtitle =
      "This overview shows the number of times your pain has impacted your life in the following categories:";
  String trailing =
      "Tracking this information is useful for both you and your healthcare provider. It helps in understanding the extent of the impact and in making informed decisions about your "
      "treatment and care.";
  List<String> description = [
    "• Work: The effect of pain on your job or daily work activities.",
    "• Social Life: How pain influences your interactions and social activities.",
    "• Sleep: The impact of pain on your sleep quality.",
    "• Quality of life: The overall effect of pain on your daily well-being.",
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<InsightsProvider>(builder: (context, value, child) {
      return (value.bodyPainTags.isDataLoaded)
          ? Column(
              children: [
                GridOptions(
                  title: "Activities",
                  subtitle: 'Your pain was related to these activities',
                  elevated: true,
                  options: value.bodyPainTags.graphData?.activities
                          ?.map((data) => OptionModel(
                              text: data.tag ?? "Unkown", value: data.count))
                          .toList() ??
                      [],
                  width: 100.w,
                  height: 100.h,
                  margin: EdgeInsets.zero,
                  backgroundColor: AppColors.whiteColor,
                  callback: () {},
                ),
                const SizedBox(
                  height: 24,
                ),
                GridOptions(
                  title: "Your pain felt like",
                  subtitle: 'Your most tracked tags',
                  elevated: true,
                  options: value.bodyPainTags.graphData?.painFeltLike
                          ?.map((data) => OptionModel(
                              text: data.tag ?? "Unkown", value: data.count))
                          .toList() ??
                      [],
                  width: 100.w,
                  height: 100.h,
                  margin: EdgeInsets.zero,
                  backgroundColor: AppColors.whiteColor,
                  callback: () {},
                ),
                const SizedBox(
                  height: 24,
                ),
                if (value.bodyPainTags.graphData?.partOfLifeEffect != null &&
                    value.bodyPainTags.graphData?.partOfLifeEffect != [])
                  CustomInfoTable(
                    title: title,
                    partOfLifeEffects:
                        value.bodyPainTags.graphData?.partOfLifeEffect,
                    elevated: true,
                    width: 100.w,
                    height: 100.h,
                    margin: EdgeInsets.zero,
                    backgroundColor: AppColors.whiteColor,
                    enableHelp: true,
                    enableHelpCallback: () =>
                        HelperFunctions.openCustomBottomSheet(
                            context,
                            content: _helpPanel(
                                title, subtitle, description, trailing)),
                  ),
                const SizedBox(
                  height: 24,
                ),
              ],
            )
          : const SizedBox.shrink();
    });
  }
}

Widget _helpPanel(title, subTitle, List<String> descriptors, trailing) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style:
              Theme.of(AppNavigation.currentContext!).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          subTitle,
          textAlign: TextAlign.start,
          style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 24,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: descriptors.map((level) {
            final parts = level.split("•")[1].split(":");
            final title = parts[0].trim(); // Extract the title (e.g., "Work")
            final description = parts[1]
                .trim(); // Extract the description (e.g., "The effect of pain on your job...")

            return Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align bullet and text properly
              children: [
                Text(
                  "•",
                  style: Theme.of(AppNavigation.currentContext!)
                      .textTheme
                      .bodySmall!
                      .copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: 4), // Add space between bullet and text
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "$title: ",
                      style: Theme.of(AppNavigation.currentContext!)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      children: [
                        TextSpan(
                          text: "$description\n",
                          style: Theme.of(AppNavigation.currentContext!)
                              .textTheme
                              .bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        Text(
          trailing,
          textAlign: TextAlign.start,
          style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 24,
        )
      ],
    ),
  );
}
