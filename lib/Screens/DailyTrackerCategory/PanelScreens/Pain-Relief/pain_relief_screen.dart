import 'package:ekvi/Components/PainRelief/pain_relief_enjoyment_help_widget.dart';
import 'package:ekvi/Components/PainRelief/pain_relief_my_practices.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PainReliefScreen extends StatefulWidget {
  const PainReliefScreen({super.key});

  @override
  State<PainReliefScreen> createState() => _PainReliefScreenState();
}

class _PainReliefScreenState extends State<PainReliefScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PainReliefProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          GridOptions(
            title: "When did it happen?",
            elevated: true,
            options: provider.categoryPainRelief.painReliefOptionalModel,
            width: 100.w,
            height: 100.h,
            backgroundColor: AppColors.whiteColor,
            callback: provider.handleTimeSelection,
          ),
          const SizedBox(height: 16),
          PainLevelSelector(
            title: "How much did it ease the pain?",
            selectedPainLevel: provider.categoryPainRelief.enjoymentScale,
            activeTrackColorList: provider.activeTrackColors,
            levels: provider.painReliefLevels,
            onChanged: provider.handleEnjoymentSelection,
            enableHelp: true,
            helpWidget: const PainReliefEnjoymentHelpWidget(),
          ),
          const SizedBox(height: 16),
          const PainReliefMyPractices(),
          const SizedBox(height: 16),
          Notes(
            notesText: provider.categoryPainRelief.painReliefNotes,
            placeholderText: provider.categoryPainRelief.notesPlaceholder,
            callback: provider.handlePainReliefNotes,
            placeHolderFontStyle: FontStyle.normal,
          ),
          const SizedBox(height: 48),
          CustomButton(
            title: "Track pain relief",
            onPressed: provider.validatePainReliefData(context, false) ? () => provider.savePainReliefLog(context) : null,
          ),
          const SizedBox(height: 32),
        ],
      );
    });
  }
}
