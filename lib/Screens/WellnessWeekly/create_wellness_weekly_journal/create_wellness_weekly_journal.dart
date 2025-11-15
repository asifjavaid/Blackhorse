import 'package:ekvi/Components/WellnessWeekly/create_wellness_weekly_journal_progress_bar.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Buttons/underlined_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/generic_header.dart';
import 'package:ekvi/Widgets/CustomWidgets/selectable_options.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateWellnessWeeklyJournal extends StatefulWidget {
  const CreateWellnessWeeklyJournal({super.key});
  @override
  State<CreateWellnessWeeklyJournal> createState() =>
      _CreateWellnessWeeklyJournalState();
}

class _CreateWellnessWeeklyJournalState
    extends State<CreateWellnessWeeklyJournal> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const GenericScreenHeader(text: "Journal"),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const WellnessWeeklyJournalProgressBar(value: 0.5),
                        SizedBox(height: 3.h),
                        Text(
                          "Wins of the Week",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontFamily: "Zitter",
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          "What were your top three wins this week, no matter how small? What are you proud of accomplishing? Note down any moments of joy or relief.",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(height: 3.h),
                        MultiSelectWidget(
                          options: const ['1', '2', '3'],
                          onSelectionChanged: (selected) {
                            setState(() {
                              selectedOptions = selected;
                            });
                          },
                          multiSelect: false,
                          selectedBackgroundColor: AppColors.actionColor600,
                          unselectedBackgroundColor: Colors.white,
                          selectedTextColor: Colors.white,
                          unselectedTextColor: Colors.black,
                          borderColor: AppColors.actionColor600,
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.5.h),
                        ),
                        // SizedBox(height: 3.h),
                        // const CustomTextFormField(
                        //   hintText: "Enter your win",
                        //   minLines: 8,
                        //   maxLines: 30,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h, left: 4.w, right: 4.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      title: "Next Question",
                      onPressed: () {},
                      buttonType: ButtonType.primary,
                    ),
                    SizedBox(height: 1.5.h),
                    UnderlinedButton(text: "Save Draft", onPressed: () {})
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
