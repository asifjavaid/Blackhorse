import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Providers/DailyTracker/Energy/energy_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EnergyScreen extends StatefulWidget {
  const EnergyScreen({super.key});

  @override
  State<EnergyScreen> createState() => _EnergyScreenState();
}

class _EnergyScreenState extends State<EnergyScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EnergyProvider>(context, listen: false).fetchEnergyFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<EnergyProvider>(
      builder: (context, provider, child) => Column(
        children: [
          FeatureFeedback(
            feedback: provider.energySymptomFeedback,
            callback: provider.updateEnergyFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.energyData.energyTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How was your energy level?",
            selectedPainLevel: provider.energyData.energyLevel,
            onChanged: provider.handleEnergyLevelSelection,
            levels: const ["Awful", "Poor", "Okay", "Good", "Great"],
            enableHelp: false,
            activeTrackColorList: provider.activeTrackColors,
          ),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
              title: "Describe your energy",
              elevated: true,
              options: provider.energyData.energyOptions,
              width: width,
              height: height,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleEnergyOptionsSelection),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.energyData.energyNotes, placeholderText: provider.energyData.notesPlaceholder, callback: provider.handleEnergyNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Energy",
            onPressed: () => provider.saveEnergyData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
