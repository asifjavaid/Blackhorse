import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/Stress/stress_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsStressTags extends StatelessWidget {
  const InsightsStressTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StressProvider>(
        builder: (context, value, child) => value.stressTagCounts.isDataLoaded
            ? GridOptions(
                title: "You have been feeling",
                subtitle: "Your most tracked tags",
                elevated: true,
                options: value.stressTagCounts.stressTags?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: (index) {},
                margin: EdgeInsets.zero,
                enableHelp: true,
                enableHelpCallback: () => HelperFunctions.openCustomBottomSheet(context, content: _helpPanel()),
              )
            : const SizedBox.shrink());
  }

  Widget _helpPanel() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "What does it mean?",
          textAlign: TextAlign.start,
          style: Theme.of(AppNavigation.currentContext!).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 24,
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
            children: [
              const TextSpan(
                text: "In this section, you'll see descriptions/tags that add details to your main symptoms, with a number in a circle next to each tag.\n\n",
              ),
              TextSpan(
                text: "Tags: ",
                style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              const TextSpan(
                text: "These are the descriptions you have tracked. For example, for stress, you might use tags like “Overwhelmed.”\n\n",
              ),
              TextSpan(text: "Count: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "The number shows how many times you've tracked that tag. For instance, if “Overwhelmed” has a '5' next to it, you’ve tracked feeling overwhelmed five times.\n\n",
              ),
              const TextSpan(
                text: "Tracking these details helps you and your doctor understand your symptoms better and personalize your care. Every entry helps!",
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
