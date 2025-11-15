import 'package:ekvi/Components/WellnessWeekly/average_wellbeing_levels.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Services/WellnessWeekly/wellness_weekly_service.dart';
import 'package:ekvi/Widgets/Texts/header_and_subtitle.dart';
import 'package:ekvi/Widgets/CustomWidgets/generic_header.dart';
import 'package:ekvi/Components/WellnessWeekly/wins_of_the_week.dart';
import 'package:ekvi/Components/WellnessWeekly/symptom_shifts.dart';
import 'package:ekvi/Components/WellnessWeekly/affirmations.dart';
import 'package:ekvi/Components/WellnessWeekly/your_wellbeing.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WellnessWeeklyScreen extends StatelessWidget {
  const WellnessWeeklyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GenericScreenHeader(
                  text: WellnessWeeklyService().getWellnessWeekTenure(),
                ),
                SizedBox(height: 2.h),
                const WinsOfTheWeek(),
                const SymptomShifts(),
                SizedBox(height: 3.h),
                const Affirmations(),
                SizedBox(height: 3.h),
                const YourWellbeing(),
                SizedBox(height: 3.h),
                const AverageWellbeingLevels(),
                SizedBox(height: 1.h),
                const HeaderAndSubtitle(
                  text: "Celebrate Your Progress",
                  subtitle:
                      "This journal is your go-to space to track your health journey, one week at a time. Celebrate your wins, reflect on your experiences, and set small goals that can make a big difference.",
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  title: "Write wellness journal",
                  onPressed: () {
                    AppNavigation.navigateTo(
                        AppRoutes.createWellnessWeeklyJournal);
                  },
                  buttonType: ButtonType.primary,
                ),
                SizedBox(height: 3.h),
                const HeaderAndSubtitle(
                  text: "Seeking  deeper insights?",
                  subtitle:
                      "Dive deeper, compare symptoms, and discover insights that can guide your wellness journey.",
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  title: "Explore your insights",
                  onPressed: () {},
                  buttonType: ButtonType.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
