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

class EventExisting extends StatefulWidget {
  const EventExisting({super.key});

  @override
  State<EventExisting> createState() => _EventExistingState();
}

class _EventExistingState extends State<EventExisting> {
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
                    options: value.categoriesData.bodyPain.justExisting.painTimeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Existing, value.categoriesData.bodyPain.justExisting.painTimeOptions[index], 0);
                    }),
                const SizedBox(
                  height: 16,
                ),
                PainLevelSelector(
                  title: "How painful was it?",
                  selectedPainLevel: value.categoriesData.bodyPain.justExisting.painLevel,
                  onChanged: (level) {
                    value.handleEventOptionSelection(PainEventsCategory.Existing, OptionModel(text: level.toString()), 1);
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
                    options: value.categoriesData.bodyPain.justExisting.feelsLikeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Existing, value.categoriesData.bodyPain.justExisting.feelsLikeOptions[index], 2);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridRadioSelection(
                  title: "How is the pain affecting your life right now?",
                  width: 0.88 * width,
                  impactGrid: value.categoriesData.bodyPain.justExisting.impactGrid,
                  callback: (OptionModel option, int impactLevel) {
                    value.handleEventOptionSelection(PainEventsCategory.Existing, option, 3, impactLevel);
                  },
                ),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(title: "Track Pain", onPressed: () => value.handleSaveEventData(PainEventsCategory.Existing)),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}
