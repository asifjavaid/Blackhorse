import 'package:ekvi/Components/CycleCalendar/select_period_intensity.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class CyclePredictionPanelContent extends StatefulWidget {
  const CyclePredictionPanelContent({super.key});

  @override
  State<CyclePredictionPanelContent> createState() =>
      _CyclePredictionPanelContentState();
}

class _CyclePredictionPanelContentState
    extends State<CyclePredictionPanelContent> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;

    return Consumer<CycleCalendarProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            value.showNotificationText
                ? Column(
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              AppCustomIcons.check_2,
                              color: AppColors.primaryColor600,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              "Days with bleeding saved",
                              style: textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            if (value.isEditMode && !value.showNotificationText)
              const SelectPeriodIntensity(),
            if (!value.isEditMode)
              CustomButton(
                title: localizations.editDaysWithPeriod,
                onPressed: () => value.toggleEditMode(!value.isEditMode),
              ),
          ],
        ),
      ),
    );
  }
}
