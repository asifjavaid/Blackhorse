import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';

import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EkviJourneysModuleCompletionFooter extends StatelessWidget {
  const EkviJourneysModuleCompletionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final courseProvider = context.read<EkviJourneysCourseProvider>();
    final journeysProvider = context.read<EkviJourneysProvider>();
    final moduleCompletion = journeysProvider.moduleCompletionResponse;
    final isJourneyComplete = moduleCompletion?.isJourneyComplete ?? false;
    final hasNextModule = moduleCompletion?.nextModuleInfo != null;

    return Container(
      width: double.infinity,
      height: 135,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: AppColors.neutralColor50,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          AppThemes.shadowUp,
        ],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          isJourneyComplete
              ? 'Congratulations! You have completed this journey!'
              : 'Do you want to continue this journey?',
          style: textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),

        // If journey is complete, show only Exit button
        if (isJourneyComplete)
          CustomButton(
            title: 'Exit',
            onPressed: () async {
              courseProvider.refreshCourseStructure();
              journeysProvider.refreshAllData();
              AppNavigation.goBack();
            },
          )
        else
          // Otherwise show both Exit and Continue buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: 'Exit',
                  buttonType: ButtonType.secondary,
                  onPressed: () async {
                    courseProvider.refreshCourseStructure();
                    journeysProvider.refreshAllData();
                    AppNavigation.goBack();
                  },
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: CustomButton(
                  title: 'Continue',
                  onPressed: hasNextModule
                      ? () async {
                          // Load the first lesson of the next module
                          final nextModuleInfo =
                              moduleCompletion!.nextModuleInfo!;
                          await journeysProvider.fetchLesson(
                              nextModuleInfo.nextModuleId,
                              sequential: false);
                          // No navigation needed - the lesson screen will update automatically
                        }
                      : null,
                ),
              ),
            ],
          ),
      ]),
    );
  }
}
