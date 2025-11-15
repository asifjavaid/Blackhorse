import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsMoodTags extends StatelessWidget {
  InsightsMoodTags({super.key});

  final List<String> descriptors = [
    "Minimal: I can notice a faint pain, but it's not slowing me down.",
    "Mild: I'm aware of the pain. It's like a persistent hum in the background.",
    "Uncomfortable: There's a nagging pain that's hard to ignore. It's uncomfortable but manageable.",
    "Moderate: I am constantly aware of the pain but I can continue most activities.",
    "Distracting: My pain is persistent enough that it's distracting me from my tasks.",
    "Distressing: It's difficult to maintain my routine because the pain demands attention.",
    "Unmanageable: I am in constant pain. It’s restricting my enjoyment and participation in daily activities.",
    "Severe: Pain dominates my existence. It's difficult to engage in conversation or even think clearly.",
    "Debilitating: The pain consumes all my attention. It's a challenge to express thoughts or needs.",
    "Excruciating: I'm completely overwhelmed by pain. Can’t move, can’t think, can’t bear it."
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
        builder: (context, value, child) => value.moodTagCounts.isDataLoaded
            ? GridOptions(
                title: "You have been feeling",
                subtitle: "Your most tracked tags",
                elevated: true,
                options: value.moodTagCounts.moodTags?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
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
