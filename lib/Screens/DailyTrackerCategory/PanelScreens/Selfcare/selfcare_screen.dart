import 'package:ekvi/Components/SelfCare/selfcare_enjoyment_help_widget.dart';
import 'package:ekvi/Components/SelfCare/selfcare_my_practices.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SelfcareScreen extends StatefulWidget {
  const SelfcareScreen({super.key});

  @override
  State<SelfcareScreen> createState() => _SelfcareScreenState();
}

class _SelfcareScreenState extends State<SelfcareScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelfcareProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.categorySelfCare.selfCareOptionalModel,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How much did you enjoy it?",
            selectedPainLevel: provider.categorySelfCare.enjoymentScale,
            activeTrackColorList: provider.activeTrackColors,
            levels: provider.enjoymentLevels,
            onChanged: provider.handleEnjoymentSelection,
            enableHelp: true,
            helpWidget: const SelfcareEnjoymentHelpWidget(),
          ),
          const SizedBox(
            height: 16,
          ),
          const SelfcareMyPractices(),
          const SizedBox(
            height: 16,
          ),
          Notes(
            notesText: provider.categorySelfCare.selfCareNotes,
            placeholderText: provider.categorySelfCare.notesPlaceholder,
            callback: provider.handleSelfCareNotes,
            placeHolderFontStyle: FontStyle.normal,
          ),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track self-care",
            onPressed: provider.validateSelfCareData(context, false) ? () => provider.saveSelfCareLog(context) : null,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
