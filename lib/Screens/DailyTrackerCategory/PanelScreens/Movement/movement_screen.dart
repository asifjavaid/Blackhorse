import 'package:ekvi/Components/Movements/movement_enjoyment_help_widget.dart';
import 'package:ekvi/Components/Movements/movement_intensity_help_widget.dart';
import 'package:ekvi/Components/Movements/movement_my_practices.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_pain_level_selector.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class MovementScreen extends StatefulWidget {
  const MovementScreen({super.key});

  @override
  State<MovementScreen> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<MovementProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          GridOptions(
              title: "When did you move?",
              elevated: true,
              options: provider.categoryMovements.movementsOptionalModel,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
            title: "How intense was it?",
            selectedPainLevel: provider.categoryMovements.intensityScale,
            levels: provider.intenseLevels,
            onChanged: provider.handleIntensitySelection,
            enableHelp: true,
            helpWidget: const MovementIntensityHelpWidget(),
          ),
          const SizedBox(
            height: 16,
          ),
          PainLevelSelector(
              title: "How much did you enjoy it?",
              selectedPainLevel: provider.categoryMovements.enjoymentScale,
              activeTrackColorList: provider.activeTrackColors,
              levels: provider.enjoymentLevels,
              onChanged: provider.handleEnjoymentSelection,
              enableHelp: true,
              helpWidget: const MovementEnjoymentHelpWidget()),
          const SizedBox(
            height: 16,
          ),
          const MyPractices(),
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
                  'How long did you move?',
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
                    key: ValueKey(provider.categoryMovements.durationTime),
                    time: provider.categoryMovements.durationTime,
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
          Notes(
            notesText: provider.categoryMovements.movementsNotes,
            placeholderText: provider.categoryMovements.notesPlaceholder,
            callback: provider.handleMovementNotes,
            placeHolderFontStyle: FontStyle.normal,
          ),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track movement",
            onPressed: provider.validateMovementsData(context, false) ? () => provider.saveMovementsLog(context) : null,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
