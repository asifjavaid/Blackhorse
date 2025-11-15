import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/Fatigue/fatigue_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FatigueScreen extends StatefulWidget {
  const FatigueScreen({super.key});

  @override
  State<FatigueScreen> createState() => _FatigueScreenState();
}

class _FatigueScreenState extends State<FatigueScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FatigueProvider>(context, listen: false).fetchFatigueFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<FatigueProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.fatigueSymptomFeedback,
            callback: provider.updateFatigueFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.fatigueData.fatigueTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was your fatigue level?",
            selectedPainLevel: provider.fatigueData.fatigueLevel,
            levels: provider.fatigueLevels,
            onChanged: provider.handleFatiqueLevelSelection,
            enableHelp: false,
          ),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
            title: "Describe your fatigue",
            elevated: true,
            options: provider.fatigueData.fatigueOptions,
            width: width,
            height: height,
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleFatigueOptionsSelection,
            subCategoryOptions: GridOptions(
              title: "Duration",
              elevated: false,
              options: provider.fatigueData.durationOptions,
              width: width,
              height: height,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleFatigueDurationSelection,
              padding: const EdgeInsets.only(top: 16),
              margin: EdgeInsets.zero,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.fatigueData.fatigueNotes, placeholderText: provider.fatigueData.notesPlaceholder, callback: provider.handleFatigueNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Fatigue",
            onPressed: () => provider.saveFatigueData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
