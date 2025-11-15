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

class EventWork extends StatefulWidget {
  const EventWork({super.key});

  @override
  State<EventWork> createState() => _EventWorkState();
}

class _EventWorkState extends State<EventWork> {
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
                    options: value.categoriesData.bodyPain.work.painTimeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Work, value.categoriesData.bodyPain.travel.painTimeOptions[index], 0);
                    }),
                const SizedBox(
                  height: 16,
                ),
                PainLevelSelector(
                  title: "How painful was it?",
                  selectedPainLevel: value.categoriesData.bodyPain.work.painLevel,
                  onChanged: (level) {
                    value.handleEventOptionSelection(PainEventsCategory.Work, OptionModel(text: level.toString()), 2);
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
                    title: "What does it feel like?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.work.feelsLikeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Work, value.categoriesData.bodyPain.work.feelsLikeOptions[index], 3);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "Describe your workday",
                    elevated: true,
                    options: value.categoriesData.bodyPain.work.describeWorkDay,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Work, value.categoriesData.bodyPain.work.describeWorkDay[index], 1);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridRadioSelection(
                    title: "How is the pain affecting your life right now?",
                    width: width,
                    impactGrid: value.categoriesData.bodyPain.work.impactGrid,
                    callback: (OptionModel option, int impactLevel) {
                      value.handleEventOptionSelection(PainEventsCategory.Work, option, 4, impactLevel);
                    }),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(title: "Track Pain", onPressed: () => value.handleSaveEventData(PainEventsCategory.Work)),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}
