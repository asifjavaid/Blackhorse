import 'package:ekvi/Components/BodyPain/body_pain_help_text_widget.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/BodyPain/body_selection.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/constants/app_strings.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/grid_radio_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventIntimacy extends StatefulWidget {
  const EventIntimacy({
    super.key,
  });

  @override
  State<EventIntimacy> createState() => _EventIntimacyState();
}

class _EventIntimacyState extends State<EventIntimacy> {
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
                    options: value.categoriesData.bodyPain.sex.painTimeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, value.categoriesData.bodyPain.sex.painTimeOptions[index], 0);
                    }),
                const SizedBox(
                  height: 16,
                ),
                PainLevelSelector(
                  title: "How painful was it?",
                  selectedPainLevel: value.categoriesData.bodyPain.sex.painLevel,
                  onChanged: (level) {
                    value.handleEventOptionSelection(PainEventsCategory.Intimacy, OptionModel(text: level.toString()), 3);
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
                    title: "When did you experience the pain?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sex.experience,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, value.categoriesData.bodyPain.sex.experience[index], 1);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "Type of intimacy",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sex.intimacyType,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, value.categoriesData.bodyPain.sex.intimacyType[index], 5);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "What does it feel like?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sex.feelsLikeOptions,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, value.categoriesData.bodyPain.sex.feelsLikeOptions[index], 4);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "Activity",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sex.activity,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, value.categoriesData.bodyPain.sex.activity[index], 2);
                    }),
                const SizedBox(
                  height: 16,
                ),

                ///
                /// Added New Fields As Tools
                ///
                GridOptions(
                    title: "Did you use a toy or tool?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sex.toolType,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    enableHelp: true,
                    enableHelpCallback: () {
                      HelperFunctions.openCustomBottomSheet(context, content: _helpPanel(AppStrings.toolTitle, '', AppStrings.toolDescription));
                    },
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, value.categoriesData.bodyPain.sex.toolType[index], 6);
                    }),
                const SizedBox(
                  height: 16,
                ),

                ///
                /// Added New Fields As Orgasm
                ///
                GridOptions(
                    title: "Did you have an orgasm?",
                    elevated: true,
                    options: value.categoriesData.bodyPain.sex.climaxType,
                    width: width,
                    height: height,
                    enableHelp: true,
                    enableHelpCallback: () {
                      HelperFunctions.openCustomBottomSheet(context, content: _helpPanel(AppStrings.climaxTitle, AppStrings.climaxSubTitle, AppStrings.climaxDescription));
                    },
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, value.categoriesData.bodyPain.sex.climaxType[index], 7);
                    }),
                const SizedBox(
                  height: 16,
                ),
                GridRadioSelection(
                    title: "How is the pain affecting your life right now?",
                    width: width,
                    impactGrid: value.categoriesData.bodyPain.sex.impactGrid,
                    callback: (OptionModel option, int impactLevel) {
                      value.handleEventOptionSelection(PainEventsCategory.Intimacy, option, 8, impactLevel);
                    }),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(
                    title: "Track Pain",
                    onPressed: () => value.handleSaveEventData(
                          PainEventsCategory.Intimacy,
                        )),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}

Widget _helpPanel(title, subTitle, List<String> descriptors) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(AppNavigation.currentContext!).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 24,
        ),
        if (subTitle != '') ...{
          Text(
            subTitle,
            textAlign: TextAlign.start,
            style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 24,
          )
        },
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: descriptors
                .map(
                  (level) => RichText(
                    text: TextSpan(text: "${level.split(":")[0]}:", style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600), children: [
                      TextSpan(
                        text: "${level.split(":")[1]}\n",
                        style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
                      )
                    ]),
                  ),
                )
                .toList()),
      ],
    ),
  );
}
