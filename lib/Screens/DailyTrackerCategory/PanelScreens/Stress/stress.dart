import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/Stress/stress_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class StressScreen extends StatefulWidget {
  const StressScreen({super.key});

  @override
  State<StressScreen> createState() => _StressScreenState();
}

class _StressScreenState extends State<StressScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StressProvider>(context, listen: false).fetchStressFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<StressProvider>(
      builder: (context, provider, child) => Column(
        children: [
          FeatureFeedback(
            feedback: provider.stressSymptomFeedback,
            callback: provider.updateStressFeedbackStatus,
          ),
          GridOptions(
            title: "When did it happen?",
            elevated: true,
            options: provider.stressData.stressTime,
            width: 100.w,
            height: 100.h,
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleTimeSelection,
          ),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was your stress level?",
            selectedPainLevel: provider.stressData.stressLevel,
            onChanged: provider.handleStressLevelSelection,
            levels: const ["Great", "Good", "Okay", "Poor", "Awful"],
            enableHelp: false,
          ),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
              title: "Describe your stress",
              elevated: true,
              options: provider.stressData.stressOptions,
              width: width,
              height: height,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleStressOptionsSelection),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.stressData.stressNotes, placeholderText: provider.stressData.notesPlaceholder, callback: provider.handleStressNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Stress",
            onPressed: () => provider.saveStressData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
