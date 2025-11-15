import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardMoodTracker extends StatelessWidget {
  const DashboardMoodTracker({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer2<MoodProvider, DashboardProvider>(builder: (context, provider, provider2, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            PainLevelSelector(
              title: "How do you feel today?",
              selectedPainLevel: provider.moodData.moodLevel,
              elevated: false,
              levels: provider.moodLevels,
              onChanged: provider.handleMoodLevelSelection,
              enableHelp: false,
              activeTrackColorList: provider.activeTrackColors,
              margin: EdgeInsets.zero,
            ),
            const SizedBox(
              height: 16,
            ),
            GridOptions(
                title: "Describe your mood",
                elevated: false,
                margin: EdgeInsets.zero,
                options: provider.moodData.moodOptions,
                width: width,
                height: height,
                backgroundColor: AppColors.whiteColor,
                callback: (int index) => provider.handleMoodOptionsSelection(index, showDialog: false)),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: "Track Mood",
              onPressed: () => provider2.handleSaveFeelToday(context),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      );
    });
  }
}
