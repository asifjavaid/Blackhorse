import 'package:ekvi/Components/DailyTracker/Headache/headache_pain_help_text.dart';
import 'package:ekvi/Components/DailyTracker/Headache/headache_type_help_text.dart';
import 'package:ekvi/Components/DailyTracker/feedback_pop_up.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/Headache/headache_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_list_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/grid_radio_selection.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HeadacheScreen extends StatefulWidget {
  const HeadacheScreen({super.key});

  @override
  State<HeadacheScreen> createState() => _HeadacheScreenState();
}

class _HeadacheScreenState extends State<HeadacheScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HeadacheProvider>(context, listen: false)
          .fetchHeadacheFeedbackStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<HeadacheProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          FeatureFeedback(
            feedback: provider.headacheSymptomFeedback,
            callback: provider.updateHeadacheFeedbackStatus,
          ),
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options:
                  provider.categoriesData.bodyPain.headache.painTimeOptions,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: (index) {
                provider.handleEventOptionSelection(
                    PainEventsCategory.Headache,
                    provider.categoriesData.bodyPain.headache
                        .painTimeOptions[index],
                    0);
              }),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How painful was it?",
            selectedPainLevel:
                provider.categoriesData.bodyPain.headache.painLevel,
            onChanged: (level) {
              provider.handleEventOptionSelection(PainEventsCategory.Headache,
                  OptionModel(text: level.toString()), 1);
            },
            helpWidget: const HeadachePainHelpWidget(),
          ),
          const SizedBox(
            height: 16,
          ),
          ListGridOptions(
            title: "What did it feel like?",
            elevated: true,
            options: provider.categoriesData.bodyPain.headache.feltLikeOptions,
            width: 100.w,
            height: 100.h,
            backgroundColor: AppColors.whiteColor,
            callback: (index) {
              provider.handleEventOptionSelection(
                  PainEventsCategory.Headache,
                  provider
                      .categoriesData.bodyPain.headache.feltLikeOptions[index],
                  2);
            },
            subCategoryOptions: [
              GridOptions(
                title: "Location",
                elevated: false,
                options:
                    provider.categoriesData.bodyPain.headache.locationOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: (index) {
                  provider.handleEventOptionSelection(
                      PainEventsCategory.Headache,
                      provider.categoriesData.bodyPain.headache
                          .locationOptions[index],
                      3);
                },
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Type",
                elevated: true,
                options: provider.categoriesData.bodyPain.headache.typeOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: (index) {
                  provider.handleEventOptionSelection(
                      PainEventsCategory.Headache,
                      provider
                          .categoriesData.bodyPain.headache.typeOptions[index],
                      4);
                },
                enableHelp: true,
                enableHelpCallback: () {
                  HelperFunctions.openCustomBottomSheet(context,
                      content: const HeadacheTypeHelpWidget());
                },
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
              GridOptions(
                title: "Onset",
                elevated: false,
                options: provider.categoriesData.bodyPain.headache.onsetOptions,
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: (index) {
                  provider.handleEventOptionSelection(
                      PainEventsCategory.Headache,
                      provider
                          .categoriesData.bodyPain.headache.onsetOptions[index],
                      5);
                },
                padding: const EdgeInsets.only(top: 16),
                margin: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19F89D87),
                  blurRadius: 6,
                  offset: Offset(2, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How long did it last?',
                  style: textTheme.headlineSmall?.copyWith(
                    color: AppColors.neutralColor600,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 212,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFFFDBCE),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: TimePickerSpinner(
                    key: ValueKey(
                        provider.categoriesData.bodyPain.headache.durationTime),
                    time:
                        provider.categoriesData.bodyPain.headache.durationTime,
                    is24HourMode: true,
                    minutesInterval: 5,
                    normalTextStyle: textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF9D9D9D),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    highlightedTextStyle: textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF1B1B1B),
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),
                    spacing: 25,
                    itemHeight: 50,
                    isForce2Digits: true,
                    isShowSeconds: false,
                    onTimeChange: (time) {
                      provider.setDateTime(time);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GridRadioSelection(
            title: "How did the headache impact your life?",
            impactGrid: provider.categoriesData.bodyPain.headache.impactGrid,
            callback: (OptionModel option, int impactLevel) {
              provider.handleEventOptionSelection(
                  PainEventsCategory.Headache, option, 6, impactLevel);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Notes(
              notesText:
                  provider.categoriesData.bodyPain.headache.headacheNotes,
              placeholderText:
                  provider.categoriesData.bodyPain.headache.notesPlaceholder,
                  placeHolderFontStyle: FontStyle.normal,
              callback: provider.handleHeadacheNotes),
          const SizedBox(
            height: 48,
          ),
          Consumer<HeadacheProvider>(
            builder: (context, provider, child) {
              bool isTimeSelected = provider
                  .categoriesData.bodyPain.headache.painTimeOptions
                  .any((option) => option.isSelected);
              bool isPainLevelSelected =
                  provider.categoriesData.bodyPain.headache.painLevel != null &&
                      provider.categoriesData.bodyPain.headache.painLevel! > 0;

              bool isFormValid = isTimeSelected && isPainLevelSelected;

              return CustomButton(
                title: "Track Headache",
                onPressed: isFormValid
                    ? () => provider.saveHeadacheData(context)
                    : null,
              );
            },
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
