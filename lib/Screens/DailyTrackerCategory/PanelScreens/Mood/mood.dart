import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MoodProvider>(context, listen: false).fetchMoodFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<MoodProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.moodSymptomFeedback,
            callback: provider.updateMoodFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.moodData.moodTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was your mood?",
            selectedPainLevel: provider.moodData.moodLevel,
            levels: provider.moodLevels,
            onChanged: provider.handleMoodLevelSelection,
            enableHelp: false,
            activeTrackColorList: provider.activeTrackColors,
          ),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
              title: "Describe your mood",
              elevated: true,
              options: provider.moodData.moodOptions,
              width: width,
              height: height,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleMoodOptionsSelection),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.moodData.moodNotes, placeholderText: provider.moodData.notesPlaceholder, callback: provider.handleMoodNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Mood",
            onPressed: () => provider.saveMoodData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
