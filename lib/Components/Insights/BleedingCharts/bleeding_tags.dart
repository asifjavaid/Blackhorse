import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/Bleeding/bleeding_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsBleedingTags extends StatelessWidget {
  const InsightsBleedingTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BleedingProvider>(
        builder: (context, value, child) => value.bleedingTagCount.isDataLoaded
            ? Column(
                children: [
                  GridOptions(
                    title: "Your period in colours",
                    subtitle: "Your most tracked colour tags.",
                    elevated: true,
                    options: value.bleedingTagCount.graphData?.color?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {},
                    margin: EdgeInsets.zero,
                    enableHelp: true,
                    enableHelpCallback: () => HelperFunctions.openCustomBottomSheet(context, content: _helpPanelColours()),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GridOptions(
                    title: "Your period in consistency",
                    subtitle: "Your most tracked consistency tags.",
                    elevated: true,
                    options: value.bleedingTagCount.graphData?.consistency?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {},
                    margin: EdgeInsets.zero,
                    enableHelp: true,
                    enableHelpCallback: () => HelperFunctions.openCustomBottomSheet(context, content: _helpPanelConsistency()),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              )
            : const SizedBox.shrink());
  }

  Widget _helpPanelColours() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("What does it mean?", textAlign: TextAlign.start, style: Theme.of(AppNavigation.currentContext!).textTheme.headlineMedium!.copyWith(color: AppColors.neutralColor600)),
        const SizedBox(
          height: 24,
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
            children: [
              const TextSpan(
                text:
                    "Understanding the colour of your period blood can give you important insights into your menstrual health. This view shows how often you’ve tracked different colours of your period blood, helping you and your healthcare provider monitor any changes or patterns over time.\n\n",
              ),
              TextSpan(
                text: "What Each Colour Might Indicate\n\n",
                style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: "Bright Red: ",
                style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              const TextSpan(
                text: "Indicates fresh blood and a steady flow.\n\n",
              ),
              TextSpan(text: "Dark Red or Brown: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "Usually old blood that has taken longer to exit the uterus, common at the start or end of your period.\n\n",
              ),
              TextSpan(text: "Pink: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "Could be a sign of light flow or spotting, often mixed with cervical fluid.\n\n",
              ),
              TextSpan(text: "Gray: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "May indicate an infection and should be discussed with a healthcare provider.\n\n",
              ),
              TextSpan(text: "Other Colours: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "If you notice other unusual colours, it’s best to make a note of them and consult with a healthcare provider for advice.\n\n",
              ),
              const TextSpan(
                text:
                    "By consistently tracking the colour of your period blood, you can gain valuable insights into your menstrual health and ensure you’re taking the best care of yourself. If you ever have concerns about the colour of your period blood, don’t hesitate to reach out to your healthcare provider for advice.",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 64,
        ),
      ]),
    );
  }

  Widget _helpPanelConsistency() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("What does it mean?", textAlign: TextAlign.start, style: Theme.of(AppNavigation.currentContext!).textTheme.headlineMedium!.copyWith(color: AppColors.neutralColor600)),
        const SizedBox(
          height: 24,
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
            children: [
              const TextSpan(
                text:
                    "The consistency of your period blood can provide important insights into your menstrual health. This view shows how often you’ve tracked different consistencies of your period blood, helping you and your healthcare provider monitor any changes or patterns over time.\n\n",
              ),
              TextSpan(
                text: "What Each Consistency Might Indicate\n\n",
                style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: "Watery: ",
                style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              const TextSpan(
                text: "Indicates light flow or new blood. It can sometimes be mixed with cervical fluid.\n\n",
              ),
              TextSpan(text: "Thin: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "Lighter flow, often occurring at the beginning or end of your period.\n\n",
              ),
              TextSpan(text: "Thick: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "Can indicate a heavier flow and the presence of blood clots.\n\n",
              ),
              TextSpan(text: "Small Clots: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "Common during a heavier flow, usually not a cause for concern.\n\n",
              ),
              TextSpan(text: "Big Clots: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "Larger clots can indicate a very heavy flow and may be worth discussing with a healthcare provider if frequent.\n\n",
              ),
              TextSpan(text: "Smooth: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "Normal consistency, typically indicating a healthy menstrual flow.\n\n",
              ),
              TextSpan(text: "Mucus-Like: ", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
              const TextSpan(
                text: "May include cervical mucus, which is normal but can vary in appearance.\n\n",
              ),
              const TextSpan(
                text:
                    "By consistently tracking the consistency of your period blood, you can gain valuable insights into your menstrual health and ensure you’re taking the best care of yourself. If you ever have concerns about the consistency of your period blood, don’t hesitate to reach out to your healthcare provider for advice.",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 64,
        ),
      ]),
    );
  }
}
