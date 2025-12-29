import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/horizontal_category_list.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DailyTrackerEdit extends StatefulWidget {
  const DailyTrackerEdit({super.key});

  @override
  State<DailyTrackerEdit> createState() => _DailyTrackerEditState();
}

class _DailyTrackerEditState extends State<DailyTrackerEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DailyTrackerProvider>(builder: (context, value, child) {
      return Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          const DailyTrackerCards(),
          Notes(
            notesText: value.categoriestNotes.text ?? "",
            callback: value.setCategoriesNotes,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              CustomButton(
                title: "Done",
                onPressed: () {
                  value.setDailyTrackerViewMode = true;
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ],
      );
    });
  }
}

class DailyTrackerCards extends StatefulWidget {
  const DailyTrackerCards({super.key});

  @override
  State<DailyTrackerCards> createState() => _DailyTrackerCardsState();
}

class _DailyTrackerCardsState extends State<DailyTrackerCards> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DailyTrackerProvider>(builder: (context, value, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: value.painAndBleedingCategories.isNotEmpty,
            child: HorizontalCategoryList(
                title: "Things I experience",
                options: value.painAndBleedingCategories,
                callback: (String title) async {
                  value.handleSelectedCategory(title);
                }),
          ),
          Visibility(
            visible: value.symptomsCategories.isNotEmpty,
            child: HorizontalCategoryList(
                title: "Symptoms",
                options: value.symptomsCategories,
                callback: (String title) async {
                  value.handleSelectedCategory(title);
                }),
          ),
          Visibility(
            visible: value.thingsPutinBody.isNotEmpty,
            child: HorizontalCategoryList(
                title: "Things that I put in my body",
                options: value.thingsPutinBody,
                callback: (String title) {
                  value.handleSelectedCategory(title);
                }),
          ),
          Visibility(
            visible: value.bathroomHabits.isNotEmpty,
            child: HorizontalCategoryList(
                title: "Bathroom habits",
                options: value.bathroomHabits,
                callback: (String title) {
                  value.handleSelectedCategory(title);
                }),
          ),
          Visibility(
            visible: value.wellbeing.isNotEmpty,
            child: HorizontalCategoryList(
                title: "Wellbeing",
                options: value.wellbeing,
                callback: (String title) {
                  value.handleSelectedCategory(title);
                }),
          ),
          Visibility(
            visible: value.fertilityAndPregnancy.isNotEmpty,
            child: HorizontalCategoryList(
                title: "Fertility and pregnancy",
                options: value.fertilityAndPregnancy,
                callback: (String title) {
                  value.handleSelectedCategory(title);
                }),
          ),
        ],
      );
    });
  }
}
