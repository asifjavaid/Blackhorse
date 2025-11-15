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

class DailyTrackerViewBleedingCard extends StatelessWidget {
  final List<Answers> data;
  const DailyTrackerViewBleedingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Center(
            child: CircleCard(
              title: "Bleeding",
              subtitle: "Flow",
              data: DailyTrackerUIHelper.sortAnswersByTimeOfDay(data),
            ),
          )
        : const SizedBox.shrink();
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
                    const Icon(
                      AppCustomIcons.drip,
                      color: AppColors.primaryColor600,
                      size: 24,
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
                      return index == data?.length ? const PlusCircle() : NumberCircle(bleeding: data![index]);
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
  final Answers bleeding;

  const NumberCircle({super.key, required this.bleeding});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<DailyTrackerProvider>(builder: (context, value, child) {
      bool isSelected = value.toBeDeletedCategory[SymptomCategory.Bleeding]?.contains(bleeding.id) ?? false;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              !isSelected
                  ? Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: GestureDetector(
                        onTap: !value.isDeleteMode
                            ? () => value.handleSelectedCategory(bleeding.type!, mode: CategoryPanelMode.edit, timeOfDay: bleeding.timeOfDay)
                            : () => value.handleCategoryDelete(categoryIDs: [bleeding.id], categoryType: SymptomCategory.Bleeding),
                        onLongPress: !value.isDeleteMode ? () => value.switchToDeleteMode(true, categoryIDs: [bleeding.id], categoryType: SymptomCategory.Bleeding) : null,
                        onDoubleTap: null,
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Transform.rotate(
                                angle: 2.35619,
                                child: SvgPicture.asset(DailyTrackerUIHelper.getBleedingIcon((bleeding.answer != null && bleeding.answer!.isNotEmpty) ? bleeding.answer![0] : "No bleeding")))),
                      ),
                    )
                  : SelectedState(
                      callback: () => value.handleCategoryDelete(categoryIDs: [bleeding.id], categoryType: SymptomCategory.Bleeding),
                    ),
              const SizedBox(height: 4),
              Text(
                HelperFunctions.formatTimeOfDay(bleeding.timeOfDay) ?? "",
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
                  onTap: () => value.handleSelectedCategory("Bleeding"),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFEF5FF),
                      shape: OvalBorder(),
                    ),
                    child: const Center(
                      child: Icon(
                        AppCustomIcons.plus,
                        color: AppColors.actionColor600,
                        size: 24,
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
        child: const Center(
          child: Icon(
            AppCustomIcons.check_2,
            color: AppColors.secondaryColor600,
            size: 24,
          ),
        ),
      ),
    );
  }
}
