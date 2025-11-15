import 'package:ekvi/Providers/DailyTracker/Hormones/hormones_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Hormones extends StatefulWidget {
  const Hormones({super.key});

  @override
  State<Hormones> createState() => _HormonesState();
}

class _HormonesState extends State<Hormones> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HormonesProvider>(
        builder: (context, provider, child) => Column(
              children: [
                GridOptions(
                    title: "When did it happen?",
                    elevated: true,
                    options: provider.hormonesData.hormonesTime,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: provider.handleTimeSelection),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "Combined Pills",
                    elevated: true,
                    options: provider.hormonesData.hormonesCombinedPills,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: provider.handlehormonesCombinedPillsSelection),
                const SizedBox(
                  height: 16,
                ),
                Notes(notesText: provider.hormonesData.notes, placeholderText: provider.hormonesData.notesPlaceholder, callback: provider.handleHormonesNotes),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(
                  title: "Track Hormones",
                  onPressed: () => provider.saveHormonesData(context),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}
