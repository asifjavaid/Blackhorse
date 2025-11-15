import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class CycleCards extends StatelessWidget {
  final List<CycleData> data;
  final String? description;

  const CycleCards({
    super.key,
    this.description,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            localizedStrings.myCycle,
            style: textTheme.displaySmall,
          ),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 24),
            child: Text(
              description!,
              style: textTheme.bodyMedium!.copyWith(fontSize: 14),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 34.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  buildCycleCard(data[index], index),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCycleCard(CycleData cycleData, int index) {
    TextTheme textTheme = Theme.of(AppNavigation.currentContext!).textTheme;

    return Padding(
      padding: index == 0
          ? EdgeInsets.only(left: 16, right: 4.w)
          : EdgeInsets.only(right: 4.w),
      child: Container(
        height: 126,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: AppColors.whiteColor,
            boxShadow: const [AppThemes.shadowDown]),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50, // You can adjust this to your icon's default size
                child: Center(
                  child: HelperFunctions.giveBackgroundToIcon(cycleData.icon),
                ),
              ),
              SizedBox(height: 1.5.h),
              SizedBox(
                height: 35,
                child: Center(
                  child: Text(
                    cycleData.title,
                    textAlign: TextAlign.center,
                    style: textTheme.labelMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
