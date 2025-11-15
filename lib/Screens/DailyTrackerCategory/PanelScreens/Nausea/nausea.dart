import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/Nausea/nausea_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NauseaScreen extends StatefulWidget {
  const NauseaScreen({super.key});

  @override
  State<NauseaScreen> createState() => _NauseaScreenState();
}

class _NauseaScreenState extends State<NauseaScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NauseaProvider>(context, listen: false).fetchNauseaFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<NauseaProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.nauseaSymptomFeedback,
            callback: provider.updateNauseaFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.nauseaData.nauseaTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was your nausea level?",
            selectedPainLevel: provider.nauseaData.nauseaLevel,
            levels: provider.nauseaLevels,
            onChanged: provider.handleNauseaLevelSelection,
            enableHelp: false,
          ),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
            title: "Describe your nausea",
            elevated: true,
            options: provider.nauseaData.nauseaOptions,
            width: width,
            height: height,
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleNauseaOptionsSelection,
            subCategoryOptions: GridOptions(
              title: "Duration",
              elevated: false,
              options: provider.nauseaData.durationOptions,
              width: width,
              height: height,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleNauseaDurationSelection,
              padding: const EdgeInsets.only(top: 16),
              margin: EdgeInsets.zero,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.nauseaData.nauseaNotes, placeholderText: provider.nauseaData.notesPlaceholder, callback: provider.handleNauseaNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Nausea",
            onPressed: () => provider.saveNauseaData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
