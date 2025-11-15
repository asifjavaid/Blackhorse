import 'package:ekvi/Components/DailyTracker/BowelMovement/bowl_movement_color_panel.dart';
import 'package:ekvi/Components/DailyTracker/BowelMovement/bowl_movement_dropdown.dart';
import 'package:ekvi/Components/DailyTracker/BowelMovement/bristol_stool_scale_widget.dart';
import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/BowelMovement/bowel_movement_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_strings.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_list_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BowelMovementScreen extends StatefulWidget {
  const BowelMovementScreen({super.key});

  @override
  State<BowelMovementScreen> createState() => _BowelMovementScreenState();
}

class _BowelMovementScreenState extends State<BowelMovementScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BowelMovementProvider>(context, listen: false).fetchBowelMovFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BowelMovementProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.symptomFeedback,
            callback: provider.updateBowelMovFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.bowelMovementData.bowelMovementTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was the consistency?",
            selectedPainLevel: provider.bowelMovementData.bowelMovementLevel,
            levels: AppStrings.bowelMovLevels,
            activeTrackColorList: provider.activeTrackColors,
            onChanged: provider.handleBowelMovLevelSelection,
            enableHelp: false,
          ),
          const SizedBox(
            height: 16,
          ),
          FrequencyDropdown(
            title: 'Frequency',
            selectedFrequencyLevel: provider.bowelMovementData.frequencyLevel,
            onChanged: (value) {
              provider.handleFrequencyLevelSelection(value!);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ListGridOptions(
            title: "Bristol Stool Scale",
            elevated: true,
            options: provider.bowelMovementData.bristolStoolScaleOptions,
            width: 100.w,
            height: 100.h,
            enableHelp: true,
            enableHelpCallback: () {
              HelperFunctions.openCustomBottomSheet(context, content: const BristolStoolScaleWidget(), height: 700);
            },
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleBowelMovOptionsSelection,
            subCategoryOptions: [
              GridOptions(
                title: "Colour",
                elevated: false,
                options: provider.bowelMovementData.colorOptions,
                width: 100.w,
                height: 100.h,
                enableHelp: true,
                enableHelpCallback: () {
                  HelperFunctions.openCustomBottomSheet(context, content: const ColorWidget(), height: 700);
                },
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleBowelMovColorSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Size",
                elevated: false,
                options: provider.bowelMovementData.sizeOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleBowelMovSizeSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Effort",
                elevated: false,
                options: provider.bowelMovementData.effortOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleBowelMovEffortsSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Unusual components",
                elevated: false,
                options: provider.bowelMovementData.unusualComponentsOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleBowelMovUnusualComponentSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Duration",
                elevated: false,
                options: provider.bowelMovementData.durationOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleBowelMovDurationSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.bowelMovementData.bowelMovementNotes, placeholderText: provider.bowelMovementData.notesPlaceholder, callback: provider.handleBowelMovNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track bowel movement",
            onPressed: () => provider.patchBowelMovRequest(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
