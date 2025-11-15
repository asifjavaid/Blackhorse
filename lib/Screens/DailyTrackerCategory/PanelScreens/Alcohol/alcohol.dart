import 'package:ekvi/Providers/DailyTracker/Alcohol/alcohol_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Buttons/custom_field_dropdown.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Alcohol extends StatelessWidget {
  const Alcohol({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlcoholProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          GridOptions(
              title: "When did it happen?",
              elevated: true,
              options: provider.alcoholData.alcoholTime,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTimeSelection),
          const SizedBox(
            height: 16,
          ),
          GridOptions(
              title: "Type of alcohol?",
              elevated: true,
              options: provider.alcoholData.typeOfAlcohol,
              width: 100.w,
              height: 100.h,
              backgroundColor: AppColors.whiteColor,
              callback: provider.handleTypeOfAlcoholSelection),
          const SizedBox(
            height: 16,
          ),
          ContentBox(listView: false, showShadow: true, contentHorizontalAlignment: CrossAxisAlignment.start, children: [
            Text("Units", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(
              height: 16,
            ),
            CustomFieldDropdown(options: provider.lengthOptions, value: provider.alcoholData.units, getLabel: (String value) => value, onChanged: provider.handleAlcoholUnitSelection),
          ]),
          const SizedBox(
            height: 16,
          ),
          Notes(notesText: provider.alcoholData.notes, placeholderText: provider.alcoholData.notesPlaceholder, callback: provider.handleAlcoholNotes),
          const SizedBox(
            height: 48,
          ),
          CustomButton(
            title: "Track Alcohol",
            onPressed: () => provider.saveAlcoholData(context),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
