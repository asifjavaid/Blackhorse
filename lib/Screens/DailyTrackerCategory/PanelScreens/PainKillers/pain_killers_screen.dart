import 'package:ekvi/Components/PainKillers/my_pain_killers.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PainKillersScreen extends StatefulWidget {
  const PainKillersScreen({super.key});

  @override
  State<PainKillersScreen> createState() => _PainKillersScreenState();
}

class _PainKillersScreenState extends State<PainKillersScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PainKillersProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          GridOptions(
              title: "When did you take the painkiller?",
              elevated: true,
              options: provider.painKillerData.painKillersTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How well did it ease the pain?",
            selectedPainLevel: provider.painKillerData.effectiveScale,
            activeTrackColorList: provider.activeTrackColors,
            levels: provider.painKillerLevels,
            onChanged: provider.handlePainKillerLevelSelection,
            enableHelp: true,
          ),
          const SizedBox(
            height: 16,
          ),
          const MyPainkillers(),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.painKillerData.painKillerNotes, placeholderText: provider.painKillerData.notesPlaceholder, callback: provider.handlePainKillerNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track painkillers",
            buttonType: provider.validatePainKillersData(context, false) ? ButtonType.primary : ButtonType.secondary,
            onPressed: provider.validatePainKillersData(context, false) ? () => provider.savePainKillerData(context) : null,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
