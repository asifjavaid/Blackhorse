import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/BrainFog/brain_fog_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BrainFogScreen extends StatefulWidget {
  const BrainFogScreen({super.key});

  @override
  State<BrainFogScreen> createState() => _BrainFogScreenState();
}

class _BrainFogScreenState extends State<BrainFogScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BrainFogProvider>(context, listen: false).fetchBrainFogFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<BrainFogProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.brainFogSymptomFeedback,
            callback: provider.updateBrainFogFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.brainFogData.brainFogTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was your brain fog level?",
            selectedPainLevel: provider.brainFogData.brainFogLevel,
            levels: provider.brainFogLevels,
            onChanged: provider.handleBrainFogLevelSelection,
            enableHelp: false,
          ),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
            title: "Describe your brain fog",
            elevated: true,
            options: provider.brainFogData.brainFogOptions,
            width: width,
            height: height,
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleBrainFogOptionsSelection,
            subCategoryOptions: GridOptions(
              title: "Duration",
              elevated: false,
              options: provider.brainFogData.durationOptions,
              width: width,
              height: height,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleBrainFogDurationSelection,
              padding: const EdgeInsets.only(top: 16),
              margin: EdgeInsets.zero,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.brainFogData.brainFogNotes, placeholderText: provider.brainFogData.notesPlaceholder, callback: provider.handleBrainFogNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Brain Fog",
            onPressed: () => provider.saveBrainFogData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
