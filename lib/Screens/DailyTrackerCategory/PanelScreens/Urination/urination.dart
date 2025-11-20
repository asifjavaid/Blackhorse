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

import '../../../../Components/UrinationUrgencyLevel/urination_urgency_color_panel.dart';
import '../../../../Components/UrinationUrgencyLevel/urination_urgency_level_help_text_widget.dart';
import '../../../../Components/UrinationUrgencyLevel/urination_urgency_smell_help_panel.dart';
import '../../../../Components/UrinationUrgencyLevel/urination_urgency_volume_help_panel.dart';
import '../../../../Models/DailyTracker/options_model.dart';
import '../../../../Providers/DailyTracker/Urination/urination_provider.dart';
import '../../../../Utils/constants/app_enums.dart';
import '../../../../Widgets/CustomWidgets/grid_radio_selection.dart';

class UrinationScreen extends StatefulWidget {
  const UrinationScreen({super.key});

  @override
  State<UrinationScreen> createState() => _UrinationScreenState();
}

class _UrinationScreenState extends State<UrinationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UrinationProvider>(context, listen: false).fetchUrinationFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<UrinationProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.symptomFeedback,
            callback: provider.updateBowelMovFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.urinationUrgencyData.urinationUrgencyTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was the urgency?",
            selectedPainLevel: provider.urinationUrgencyData.urinationUrgencyLevel,
            levels: AppStrings.urinationLevels,
            activeTrackColorList: provider.activeTrackColors,
            onChanged: provider.handleUrinationUrgencyLevelSelection,
            enableHelp: true,
            helpWidget: UrinationUrgencyLevelHelpWidget(),
          ),
          const SizedBox(
            height: 16,
          ),
          FrequencyDropdown(
            title: 'Frequency',
            selectedFrequencyLevel: provider.urinationUrgencyData.frequencyLevel,
            onChanged: (value) {
              provider.handleFrequencyLevelSelection(value!);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ListGridOptions(
            title: "Sensations",
            elevated: true,
            options: provider.urinationUrgencyData.sensationOptions,
            width: 100.w,
            height: 100.h,
            enableHelp: false,
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleUrinationUrgencyOptionsSelection,
            subCategoryOptions: [
              GridOptions(
                title: "Complications",
                elevated: false,
                options: provider.urinationUrgencyData.complications,
                width: 100.w,
                height: 100.h,
                enableHelp: false,
                enableHelpCallback: () {
                  HelperFunctions.openCustomBottomSheet(context, content: const ColorWidget(), height: 700);
                },
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleUrinationComplicationSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Diagnoses",
                elevated: false,
                options: provider.urinationUrgencyData.diagnoses,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleDiagnosesSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Colour",
                elevated: false,
                options: provider.urinationUrgencyData.colorOptions,
                width: 100.w,
                height: 100.h,
                enableHelp: true,
                enableHelpCallback: () {
                  HelperFunctions.openCustomBottomSheet(context, content: const UrinationUrgencyColorHelpWidget(), height: 700);
                },
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleBowelMovColorSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Smell",
                elevated: false,
                options: provider.urinationUrgencyData.smellOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleSmellOptionsSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
                enableHelp: true,
                enableHelpCallback: () {
                  HelperFunctions.openCustomBottomSheet(context, content: const UrinationUrgencySmellHelpWidget(), height: 700);
                },
              ),
              GridOptions(
                title: "Volume",
                elevated: false,
                options: provider.urinationUrgencyData.volumeOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: provider.handleVolumeOptionsSelection,
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
                enableHelp: true,
                enableHelpCallback: () {
                  HelperFunctions.openCustomBottomSheet(context, content: const UrinationUrgencyVolumeHelpWidget(), height: 700);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          GridRadioSelection(
              title: "How is the pain affecting your life right now?",
              width: width,
              impactGrid: provider.urinationUrgencyData.bodyPain.headache.impactGrid,
              callback: (OptionModel option, int impactLevel) {
                provider.handleEventOptionSelection(PainEventsCategory.Intimacy, option, 6, impactLevel);
              }),
          const SizedBox(
            height: 16,
          ),
          Notes(
              notesText: provider.urinationUrgencyData.urineUrgencyNotes,
              placeholderText: provider.urinationUrgencyData.notesPlaceholder,
              callback: provider.handleBowelMovNotes),
          const SizedBox(
            height: 48,
          ),

          CustomButton(
            title: "Track urination",
            onPressed: () => provider.patchUrinationUrgencyRequest(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
