import 'package:ekvi/Providers/Insights/insights_provider.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';

class YearMonthSelection extends StatefulWidget {
  final VoidCallback toggleYearTimeSelection;

  const YearMonthSelection({super.key, required this.toggleYearTimeSelection});

  @override
  // ignore: library_private_types_in_public_api
  _YearMonthSelectionState createState() => _YearMonthSelectionState();
}

class _YearMonthSelectionState extends State<YearMonthSelection> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<InsightsSymptomTimeSelectionProvider>(context);
    var insightsProvider = Provider.of<InsightsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Container(
              height: 32,
              padding: const EdgeInsets.only(left: 2),
              decoration: ShapeDecoration(
                color: AppColors.neutralColor200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: TimeFrameSelection.values.map((type) {
                    bool isCurrent = provider.selectionType == type;
                    return InkWell(
                      onTap: () => provider.setSelectionType(type),
                      child: Container(
                        width: 93,
                        height: 28,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: isCurrent
                            ? ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              )
                            : null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              provider.getMonthString(type),
                              style: textTheme.labelMedium!.copyWith(color: isCurrent ? AppColors.neutralColor600 : AppColors.neutralColor500),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          provider.selectionType != TimeFrameSelection.oneYear
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          Assets.customiconsArrowLeft,
                          height: 14,
                          width: 14,
                        ),
                        onPressed: provider.greaterThanMinYear ? () => provider.selectYear(provider.selectedYear - 1) : null,
                      ),
                      Text(
                        '${provider.selectedYear}',
                        style: textTheme.headlineSmall,
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          Assets.customiconsArrowRight,
                          height: 14,
                          width: 14,
                        ),
                        onPressed: provider.lessThanCurrentYear ? () => provider.selectYear(provider.selectedYear + 1) : null,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),

          // Grid of months or years
          provider.selectionType == TimeFrameSelection.oneYear
              ? GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  childAspectRatio: 2.24,
                  mainAxisSpacing: 0,
                  shrinkWrap: true,
                  children: List.generate(provider.currentYear - provider.minYear + 1, (index) {
                    int year = provider.minYear + index;
                    bool isSelectable = year <= provider.currentYear;
                    bool isSelected = provider.selectedYear == year;
                    return Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: isSelectable ? 1.0 : 0.5,
                        child: GestureDetector(
                          onTap: isSelectable ? () => provider.selectYear(year) : null,
                          child: Container(
                            width: 46,
                            height: 26,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: ShapeDecoration(
                              color: isSelected ? AppColors.secondaryColor600 : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  year.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : AppColors.neutralColor600,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 2.24,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  children: List.generate(12, (index) {
                    DateTime monthDate = DateTime(provider.selectedYear, index + 1);
                    bool isSelectable = provider.isMonthSelectable(monthDate.month);
                    bool isSelected = provider.selectedMonths.any((selectedDate) => selectedDate.year == monthDate.year && selectedDate.month == monthDate.month);

                    return Align(
                      alignment: Alignment.center,
                      child: MonthButton(
                        date: monthDate,
                        isSelected: isSelected,
                        isSelectable: isSelectable,
                        onMonthSelected: isSelectable
                            ? (DateTime date) {
                                provider.selectMonth(monthDate.month);
                              }
                            : null,
                      ),
                    );
                  }),
                ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: CustomButton(
              title: "Set Period",
              buttonType: ButtonType.primary,
              onPressed: () {
                provider.setSelectedMonthString();
                insightsProvider.callAllInsightsAPIs();
                widget.toggleYearTimeSelection();
              },
            ),
          )
        ],
      ),
    );
  }
}

class MonthButton extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isSelectable;
  final Function(DateTime)? onMonthSelected;

  const MonthButton({
    super.key,
    required this.date,
    required this.isSelected,
    required this.isSelectable,
    this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat.MMM().format(date);
    return Opacity(
      opacity: isSelectable ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: () => isSelectable ? onMonthSelected?.call(date) : null,
        child: Container(
          width: 43,
          height: 26,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: ShapeDecoration(
            color: isSelected ? AppColors.secondaryColor600 : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                monthName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.neutralColor600,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
