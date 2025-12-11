// ignore_for_file: unused_import

import 'package:dartz/dartz.dart' as dartz;
import 'package:ekvi/Models/DailyTracker/categories_by_date.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/alcohol_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/bleeding_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/bloating_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/bowel_movement_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/brain_fog_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/energy_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/fatigue_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/headache_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/hormones_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/intimacy_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/mood_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/movement_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/nausea_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/ovulation_test_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/pain_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/pain_killers_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/pain_relief_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/pregnancy_test_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/selfcare_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/stress_card.dart';
import 'package:ekvi/Screens/DailyTracker/DailyTrackerView/urination_card.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DailyTrackerView extends StatefulWidget {
  const DailyTrackerView({super.key});

  @override
  State<DailyTrackerView> createState() => _DailyTrackerViewState();
}

class _DailyTrackerViewState extends State<DailyTrackerView> {
  var provider = Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textheme = Theme.of(context).textTheme;
    return Consumer<DailyTrackerProvider>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  HelperFunctions.getFormattedDate(value.selectedDateOfUserForTracking),
                  textAlign: TextAlign.start,
                  style: textheme.displaySmall,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  title: "Add More Symptoms",
                  onPressed: () {
                    value.setDailyTrackerViewMode = false;
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  "Tap on the circles if you want to edit the tracked symptom, give it a long press for a delete option",
                  textAlign: TextAlign.start,
                  style: textheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                ...value.filledCategoryTimes.entries.map((timeData) {
                  Map<SymptomCategory, dynamic> otherCategoriesOfTime = {
                    SymptomCategory.Bleeding: timeData.value?.bleeding,
                    SymptomCategory.Hormones: timeData.value?.harmones,
                    SymptomCategory.Alcohol: timeData.value?.alcohol,
                    SymptomCategory.Ovulation_test: timeData.value?.ovulationTest,
                    SymptomCategory.Pregnancy_test: timeData.value?.pregnancyTest,
                    SymptomCategory.Intimacy: timeData.value?.intimacy,
                    SymptomCategory.Mood: timeData.value?.mood,
                    SymptomCategory.Stress: timeData.value?.stress,
                    SymptomCategory.Energy: timeData.value?.energy,
                    SymptomCategory.Nausea: timeData.value?.nausea,
                    SymptomCategory.Fatigue: timeData.value?.fatigue,
                    SymptomCategory.Bloating: timeData.value?.bloating,
                    SymptomCategory.Brain_Fog: timeData.value?.brainFog,
                    SymptomCategory.Headache: timeData.value?.headache,
                    SymptomCategory.Bowel_movement: timeData.value?.bowelMovement,
                    //SymptomCategory.Urination: timeData.value?.U,
                    SymptomCategory.Body_Pain: timeData.value?.bodyPain,
                    SymptomCategory.Pain_Killers: timeData.value?.painKillers,
                    SymptomCategory.Movement: timeData.value?.movement,
                    SymptomCategory.Self_Care: timeData.value?.selfCare,
                    SymptomCategory.Pain_Relief: timeData.value?.painRelief,
                  };

                  otherCategoriesOfTime.removeWhere((key, value) => value == null);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      timeData.value != null
                          ? Text(
                              timeData.key,
                              style: textheme.headlineSmall,
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 16,
                      ),
                      DailyTrackerViewPainCard(data: timeData.value?.bodyPain ?? []),
                      DailyTrackerViewBleedingCard(data: timeData.value?.bleeding ?? []),
                      DailyTrackerViewMoodCard(data: timeData.value?.mood ?? []),
                      DailyTrackerViewStressCard(data: timeData.value?.stress ?? []),
                      DailyTrackerViewEnergyCard(data: timeData.value?.energy ?? []),
                      DailyTrackerViewNauseaCard(data: timeData.value?.nausea ?? []),
                      DailyTrackerViewFatigueCard(data: timeData.value?.fatigue ?? []),
                      DailyTrackerViewBloatingCard(data: timeData.value?.bloating ?? []),
                      DailyTrackerViewBrainFogCard(data: timeData.value?.brainFog ?? []),
                      DailyTrackerViewHeadacheCard(data: timeData.value?.headache ?? []),
                      DailyTrackerViewBowlMovementCard(data: timeData.value?.bowelMovement ?? []),
                      DailyTrackerViewUrinationCard(data: timeData.value?.urination ?? []),
                      DailyTrackerViewAlcoholCard(data: timeData.value?.alcohol ?? []),
                      DailyTrackerViewHormonesCard(data: timeData.value?.harmones ?? []),
                      DailyTrackerViewIntimacyCard(data: timeData.value?.intimacy ?? []),
                      DailyTrackerViewOvulationTestCard(data: timeData.value?.ovulationTest ?? []),
                      DailyTrackerViewPregnancyTestCard(data: timeData.value?.pregnancyTest ?? []),
                      DailyTrackerViewPainKillersCard(data: timeData.value?.painKillers ?? []),
                      DailyTrackerViewMovementCard(
                        data: timeData.value?.movement ?? [],
                      ),
                      DailyTrackerViewSelfcareCard(
                        data: timeData.value?.selfCare ?? [],
                      ),
                      DailyTrackerViewPainReliefCard(
                        data: timeData.value?.painRelief ?? [],
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Notes(
            notesText: value.categoriestNotes.text ?? "",
            callback: value.setCategoriesNotes,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
