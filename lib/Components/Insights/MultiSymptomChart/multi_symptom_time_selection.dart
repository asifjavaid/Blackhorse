import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultiSymptomTimeSelection extends StatelessWidget {
  const MultiSymptomTimeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InsightsSymptomTimeSelectionProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    // final provider2 = Provider.of<PainKillersVaultProvider>(context);

    return Row(
      children: [
        GestureDetector(
            onTap: () => AppNavigation.goBack(),
            child: Container(
              color: Colors.transparent,
              child: const Padding(
                padding: EdgeInsets.only(right: 24),
                child: Icon(
                  AppCustomIcons.arrow_left__property_2_ic,
                  size: 16,
                ),
              ),
            )),
        const Spacer(),
        SizedBox(
          width: 343,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30.0),
                    child: Ink(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0), border: Border.all(width: 2, color: AppColors.actionColor600)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              provider.symptoms.firstWhere((element) => element.name == provider.selectedSymptom).icon,
                              color: AppColors.actionColor600,
                              size: 16,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                provider.getSelectedItemForMultiSymptomChart(),
                                style: textTheme.titleSmall!.copyWith(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30.0),
                    child: Ink(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0), border: Border.all(width: 2, color: AppColors.actionColor600)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  AppCustomIcons.calendar,
                                  color: AppColors.actionColor600,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(provider.selectedMonthString, style: textTheme.titleSmall!.copyWith(fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
