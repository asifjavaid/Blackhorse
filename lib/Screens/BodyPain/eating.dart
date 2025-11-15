import 'package:ekvi/Components/BodyPain/body_pain_help_text_widget.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/BodyPain/body_selection.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/grid_radio_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EventEating extends StatefulWidget {
  const EventEating({
    super.key,
  });

  @override
  State<EventEating> createState() => _EventEatingState();
}

class _EventEatingState extends State<EventEating> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DailyTrackerProvider>(
        builder: (context, value, child) => Column(
              children: [
                GridOptions(
                    title: "When did it happen?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.eating.painTimeOptions,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Eating, value.categoriesData.bodyPain.eating.painTimeOptions[index], 0);
                    }),
                const SizedBox(
                  height: 16,
                ),
                PainLevelSelector(
                  title: "How painful was it?",
                  selectedPainLevel: value.categoriesData.bodyPain.eating.painLevel,
                  onChanged: (level) {
                    value.handleEventOptionSelection(PainEventsCategory.Eating, OptionModel(text: level.toString()), 2);
                  },
                  helpWidget: const BodyPainHelpWidget(),
                ),
                const SizedBox(
                  height: 16,
                ),
                value.categoriesData.bodyPain.isEditing
                    ? Column(
                        children: [
                          BodyPartSelection(
                            isEditing: value.categoriesData.bodyPain.isEditing,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                GridOptions(
                    title: "What did you experience ",
                    elevated: true,
                    options: value.categoriesData.bodyPain.eating.conditions,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Eating, value.categoriesData.bodyPain.eating.conditions[index], 1);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "What does it feel like?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.eating.feelsLikeOptions,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Eating, value.categoriesData.bodyPain.eating.feelsLikeOptions[index], 3);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridRadioSelection(
                  title: "How is the pain affecting your life right now?",
                  width: 88.w,
                  impactGrid: value.categoriesData.bodyPain.eating.impactGrid,
                  callback: (OptionModel option, int impactLevel) {
                    value.handleEventOptionSelection(PainEventsCategory.Eating, option, 4, impactLevel);
                  },
                ),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(
                    title: "Track Pain",
                    onPressed: () => value.handleSaveEventData(
                          PainEventsCategory.Eating,
                        )),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}
