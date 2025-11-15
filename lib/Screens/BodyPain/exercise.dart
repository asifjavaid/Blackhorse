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

class EventExercise extends StatefulWidget {
  const EventExercise({
    super.key,
  });

  @override
  State<EventExercise> createState() => _EventExerciseState();
}

class _EventExerciseState extends State<EventExercise> {
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
                    options: value.categoriesData.bodyPain.exercise.painTimeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Exercise, value.categoriesData.bodyPain.exercise.painTimeOptions[index], 0);
                    }),
                const SizedBox(
                  height: 16,
                ),
                PainLevelSelector(
                  title: "How painful was it?",
                  selectedPainLevel: value.categoriesData.bodyPain.exercise.painLevel,
                  onChanged: (level) {
                    value.handleEventOptionSelection(PainEventsCategory.Exercise, OptionModel(text: level.toString()), 1);
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
                  title: "Cardio",
                  elevated: true,
                  options: value.categoriesData.bodyPain.exercise.cardio,
                  width: width,
                  height: height,
                  backgroundColor: AppColors.whiteColor,
                  callback: (index) {
                    value.handleEventOptionSelection(PainEventsCategory.Exercise, value.categoriesData.bodyPain.exercise.cardio[index], 2);
                  },
                  subCategoryOptions: GridOptions(
                      title: "Strength Training",
                      elevated: false,
                      options: value.categoriesData.bodyPain.exercise.strengthTraining,
                      width: width,
                      height: height,
                      backgroundColor: AppColors.whiteColor,
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                      callback: (index) {
                        value.handleEventOptionSelection(PainEventsCategory.Exercise, value.categoriesData.bodyPain.exercise.strengthTraining[index], 3);
                      },
                      subCategoryOptions: GridOptions(
                        title: "Flexibility & Balance",
                        elevated: false,
                        options: value.categoriesData.bodyPain.exercise.flexibilityAndBalance,
                        width: width,
                        height: height,
                        backgroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.only(top: 16),
                        margin: EdgeInsets.zero,
                        callback: (index) {
                          value.handleEventOptionSelection(PainEventsCategory.Exercise, value.categoriesData.bodyPain.exercise.flexibilityAndBalance[index], 4);
                        },
                        subCategoryOptions: GridOptions(
                          title: "Sports",
                          elevated: false,
                          options: value.categoriesData.bodyPain.exercise.sports,
                          width: width,
                          height: height,
                          backgroundColor: AppColors.whiteColor,
                          padding: const EdgeInsets.only(top: 16),
                          margin: EdgeInsets.zero,
                          callback: (index) {
                            value.handleEventOptionSelection(PainEventsCategory.Exercise, value.categoriesData.bodyPain.exercise.sports[index], 5);
                          },
                          subCategoryOptions: GridOptions(
                            title: "Other",
                            elevated: false,
                            options: value.categoriesData.bodyPain.exercise.others,
                            width: width,
                            height: height,
                            backgroundColor: AppColors.whiteColor,
                            padding: const EdgeInsets.only(top: 16),
                            margin: EdgeInsets.zero,
                            callback: (index) {
                              value.handleEventOptionSelection(PainEventsCategory.Exercise, value.categoriesData.bodyPain.exercise.others[index], 6);
                            },
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "What does it feel like?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.exercise.feelsLikeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Exercise, value.categoriesData.bodyPain.exercise.feelsLikeOptions[index], 7);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridRadioSelection(
                    title: "How is the pain affecting your life right now?",
                    width: width,
                    impactGrid: value.categoriesData.bodyPain.exercise.impactGrid,
                    callback: (OptionModel option, int impactLevel) {
                      value.handleEventOptionSelection(PainEventsCategory.Exercise, option, 8, impactLevel);
                    }),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(
                    title: "Track Pain",
                    onPressed: () => value.handleSaveEventData(
                          PainEventsCategory.Exercise,
                        )),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}
