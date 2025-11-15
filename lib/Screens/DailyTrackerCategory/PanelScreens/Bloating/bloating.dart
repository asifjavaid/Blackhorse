import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/Bloating/bloating_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BloatingScreen extends StatefulWidget {
  const BloatingScreen({super.key});

  @override
  State<BloatingScreen> createState() => _BloatingScreenState();
}

class _BloatingScreenState extends State<BloatingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BloatingProvider>(context, listen: false).fetchBloatingFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<BloatingProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.bloatingSymptomFeedback,
            callback: provider.updateBloatingFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.bloatingData.bloatingTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was your bloating level?",
            selectedPainLevel: provider.bloatingData.bloatingLevel,
            levels: provider.bloatingLevels,
            onChanged: provider.handleBloatingLevelSelection,
            enableHelp: false,
          ),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
            title: "Describe your bloating",
            elevated: true,
            options: provider.bloatingData.bloatingOptions,
            width: width,
            height: height,
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleBloatingOptionsSelection,
            subCategoryOptions: GridOptions(
              title: "Duration",
              elevated: false,
              options: provider.bloatingData.durationOptions,
              width: width,
              height: height,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleBloatingDurationSelection,
              padding: const EdgeInsets.only(top: 16),
              margin: EdgeInsets.zero,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.bloatingData.bloatingNotes, placeholderText: provider.bloatingData.notesPlaceholder, callback: provider.handleBloatingNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Bloating",
            onPressed: () => provider.saveBloatingData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
