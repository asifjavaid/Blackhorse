import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Alcohol/alcohol.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Bleeding/bleeding.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Bloating/bloating.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/BodyPain/body_selection.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/BowelMovement/bowel_movement.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/BrainFog/brain_fog.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Energy/energy.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Fatigue/fatigue.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Headache/headache.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Hormones/hormones.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Intimacy/intimacy.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Mood/mood.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Movement/movement_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Nausea/nausea.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/OvulationTest/ovulation_test.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Pain-Relief/pain_relief_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/PainKillers/pain_killers_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/PregnancyTest/pregnancy_test.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Selfcare/selfcare_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Stress/stress.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PanelScreens/Urination/urination.dart';

class DailyTrackerCategory extends StatefulWidget {
  const DailyTrackerCategory({super.key});

  @override
  State<DailyTrackerCategory> createState() => _DailyTrackerCategoryState();
}

class _DailyTrackerCategoryState extends State<DailyTrackerCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Consumer<DailyTrackerProvider>(
              builder: (context, value, child) => SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BackNavigation(
                            title: getCategoryTitle(value),
                            callback: () => AppNavigation.goBack()),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (value.selectedCategory == SymptomCategory.Body_Pain) ...[
                              const BodyPartSelection()
                            ] else if (value.selectedCategory ==
                                SymptomCategory.Bleeding) ...[
                              const Bleeding()
                            ] else if (value.selectedCategory ==
                                SymptomCategory.Hormones) ...[
                              const Hormones()
                            ] else if (value.selectedCategory ==
                                SymptomCategory.Alcohol) ...[
                              const Alcohol()
                            ] else if (value.selectedCategory ==
                                SymptomCategory.Ovulation_test) ...[
                              const OvulationTest()
                            ] else if (value.selectedCategory ==
                                SymptomCategory.Pregnancy_test) ...[
                              const PregnancyTest()
                            ] else if (value.selectedCategory ==
                                SymptomCategory.Intimacy) ...[
                              const Intimacy()
                            ] else if (value.selectedCategory ==
                                SymptomCategory.Pain_Killers) ...[
                              const PainKillersScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Mood) ...[
                              const MoodScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Stress) ...[
                              const StressScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Energy) ...[
                              const EnergyScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Nausea) ...[
                              const NauseaScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Fatigue) ...[
                              const FatigueScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Bloating) ...[
                              const BloatingScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Brain_Fog) ...[
                              const BrainFogScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Bowel_movement) ...[
                              const BowelMovementScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Urination) ...[
                              const UrinationScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Movement) ...[
                              const MovementScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Self_Care) ...[
                              const SelfcareScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Pain_Relief) ...[
                              const PainReliefScreen()
                            ] else if (value.selectedCategory == SymptomCategory.Headache) ...[
                              const HeadacheScreen()
                            ]
                          ],
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  String getCategoryTitle(DailyTrackerProvider provider) {
    // Extract and process the category string
    String category = provider.selectedCategory
        .toString()
        .split('.')[1]
        .replaceAll('_', ' ')
        .toLowerCase();

    // Capitalize the first letter of each word
    return category == 'pain killers'
        ? 'Painkillers'
        // ? category.split(' ').map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : word).join('')
        : category
            .split(' ')
            .map((word) => word.isNotEmpty
                ? '${word[0].toUpperCase()}${word.substring(1)}'
                : word)
            .join(' ');
  }
}
