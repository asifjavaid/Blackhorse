import 'package:ekvi/Models/DailyTracker/categories_by_date.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Screens/DailyTracker/daily_tracker_ui_helper.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';

class DailyTrackerViewIntimacyCard extends StatelessWidget {
  final List<Answers> data;

  const DailyTrackerViewIntimacyCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const SizedBox.shrink()
        : Center(
            child: CircleCard(
              title: "Intimacy",
              subtitle: "Tracked",
              data: DailyTrackerUIHelper.sortAnswersByTimeOfDay(data),
            ),
          );
  }
}

class CircleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Answers>? data;

  const CircleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [AppThemes.shadowDown],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                HelperFunctions.giveBackgroundToIcon(
                    SvgPicture.asset(
                        Assets.customiconsHeart,
                        height: 24,
                        width: 24,
                        color: AppColors.actionColor600
                    ),
                    bgColor: AppColors.primaryColor400),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.headlineSmall!.copyWith(color: AppColors.neutralColor600),
                    ),
                    Text(
                      subtitle,
                      style: textTheme.labelMedium!.copyWith(
                        color: AppColors.neutralColor500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            data != null
                ? GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 69,

                      crossAxisCount: 4, // number of circles in the row
                      crossAxisSpacing: 21, // Horizontal spacing between circles
                      mainAxisSpacing: 16.0, // Vertical spacing between rows of circles
                    ),
                    itemCount: (data?.length ?? 0) + 1, // Adding an extra circle for the plus icon
                    itemBuilder: (context, index) {
                      return index == data?.length ? const PlusCircle() : NumberCircle(intimacy: data![index]);
                    },
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class NumberCircle extends StatelessWidget {
  final Answers intimacy;

  const NumberCircle({super.key, required this.intimacy});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<DailyTrackerProvider>(builder: (context, value, child) {
      bool isSelected = value.toBeDeletedCategory[SymptomCategory.Intimacy]?.contains(intimacy.id) ?? false;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              !isSelected
                  ? Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: !value.isDeleteMode
                            ? () => value.handleSelectedCategory(intimacy.type!, mode: CategoryPanelMode.edit, timeOfDay: intimacy.timeOfDay)
                            : () => value.handleCategoryDelete(categoryIDs: [intimacy.id], categoryType: SymptomCategory.Intimacy),
                        onLongPress: !value.isDeleteMode ? () => value.switchToDeleteMode(true, categoryIDs: [intimacy.id], categoryType: SymptomCategory.Intimacy) : null,
                        onDoubleTap: null,
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 2, color: AppColors.primaryColor500),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          width: 50,
                          height: 50,
                          child: Center(
                            child: SvgPicture.asset(
                                Assets.customiconsCheckmark,
                                color: AppColors.actionColor600
                            ),
                          ),
                        ),
                      ),
                    )
                  : SelectedState(
                      callback: () => value.handleCategoryDelete(categoryIDs: [intimacy.id], categoryType: SymptomCategory.Intimacy),
                    ),
              const SizedBox(height: 4),
              Text(
                HelperFunctions.formatTimeOfDay(intimacy.timeOfDay) ?? "",
                style: textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class PlusCircle extends StatelessWidget {
  const PlusCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyTrackerProvider>(
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => value.handleSelectedCategory("Intimacy"),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFEF5FF),
                      shape: OvalBorder(),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                          Assets.customiconsPlus,
                          height: 24,
                          width: 24,
                          color: AppColors.actionColor600
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}

class SelectedState extends StatelessWidget {
  final VoidCallback callback;

  const SelectedState({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 50,
        height: 50,
        decoration: const ShapeDecoration(
          color: AppColors.secondaryColor400,
          shape: OvalBorder(
            side: BorderSide(width: 2, color: AppColors.secondaryColor500),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
              Assets.customiconsCheck2,
              height: 24,
              width: 24,
              color: AppColors.secondaryColor600
          ),
        ),
      ),
    );
  }
}
