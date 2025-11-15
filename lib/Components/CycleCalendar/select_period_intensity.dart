import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectPeriodIntensity extends StatefulWidget {
  const SelectPeriodIntensity({super.key});

  @override
  SelectPeriodIntensityState createState() => SelectPeriodIntensityState();
}

class SelectPeriodIntensityState extends State<SelectPeriodIntensity> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<CycleCalendarProvider>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How much did you bleed?",
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            Text(
              value.selectedCycleDay.date != null ? value.selectedCycleDay.date!.toLocal().toShortString() : '',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: value.bleedingIntensityOptions.map((option) {
                  bool isSelected = value.events[value.selectedCycleDay.date]?.isNotEmpty ?? false ? (value.events[value.selectedCycleDay.date]?[0].intensity) == option.text : false;
                  return GestureDetector(
                    onTap: () => value.updateIntensityForSelectedDate(value.selectedCycleDay.date, option.text),
                    child: Container(
                      width: 71,
                      height: 85,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondaryColor400 : AppColors.whiteColor,
                        border: Border.all(
                          color: isSelected ? AppColors.secondaryColor600 : Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Transform.rotate(
                                angle: 2.35619,
                                child: SizedBox(width: 55, height: 21, child: SvgPicture.asset(option.trailingIcon!)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(option.text, textAlign: TextAlign.center, style: textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w500, height: 0, color: AppColors.neutralColor500)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () => value.toggleEditMode(!value.isEditMode, restore: true),
                    title: "Cancel",
                    buttonType: ButtonType.secondary,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: CustomButton(
                    onPressed: () => value.updateCycleCalendarData(),
                    title: "Save",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String toShortString() {
    return DateFormat("MMM d").format(this);
  }
}
