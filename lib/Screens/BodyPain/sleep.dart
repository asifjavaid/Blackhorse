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

class EventSleep extends StatefulWidget {
  const EventSleep({
    super.key,
  });

  @override
  State<EventSleep> createState() => _EventSleepState();
}

class _EventSleepState extends State<EventSleep> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<DailyTrackerProvider>(
        builder: (context, value, child) => Column(
              children: [
                GridOptions(
                    title: "When did it happen?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sleep.painTimeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Sleep, value.categoriesData.bodyPain.sleep.painTimeOptions[index], 0);
                    }),
                const SizedBox(
                  height: 16,
                ),
                PainLevelSelector(
                  title: "How painful was it?",
                  selectedPainLevel: value.categoriesData.bodyPain.sleep.painLevel,
                  onChanged: (level) {
                    value.handleEventOptionSelection(PainEventsCategory.Sleep, OptionModel(text: level.toString()), 2);
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
                    title: "What did you experience",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sleep.conditions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Sleep, value.categoriesData.bodyPain.sleep.conditions[index], 1);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "What does it feel like?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sleep.feelsLikeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Sleep, value.categoriesData.bodyPain.sleep.feelsLikeOptions[index], 3);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridRadioSelection(
                    title: "How is the pain affecting your life right now?",
                    width: width,
                    impactGrid: value.categoriesData.bodyPain.sleep.impactGrid,
                    callback: (OptionModel option, int impactLevel) {
                      value.handleEventOptionSelection(PainEventsCategory.Sleep, option, 4, impactLevel);
                    }),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(
                    title: "Track Pain",
                    onPressed: () => value.handleSaveEventData(
                          PainEventsCategory.Sleep,
                        )
                    // widget.provider.handleSaveCategoryData(SymptomCategory.Bleeding),
                    ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}
