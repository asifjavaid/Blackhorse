import 'package:ekvi/Providers/Insights/multi_symptoms_chart_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';

class MultiSymptomsSelection extends StatelessWidget {
  const MultiSymptomsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: RotatedBox(
            quarterTurns: 1,
            child: Consumer<MultiSymptomsChartProvider>(
              builder: (context, value, child) => Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => AppNavigation.goBack(),
                            child: SvgPicture.asset(
                              Assets.customiconsArrowLeft,
                              height: 16,
                              width: 16,
                            ),
                        ),
                        const Spacer(),
                        Text("Please select up to 3 symptoms to compare with ${value.currentSymptom}"),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 16,
                            spacing: 16,
                            children: value.symptoms.map((symptom) {
                              return GestureDetector(
                                onTap: () => value.addSymptom(symptom),
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: value.isSelected(symptom) ? AppColors.secondaryColor600 : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        symptom.icon ?? "",
                                        height: 16,
                                        width: 16,
                                        color: value.isSelected(symptom) ? AppColors.whiteColor : AppColors.neutralColor600,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        symptom.name,
                                        style: textTheme.titleSmall!.copyWith(
                                          color: value.isSelected(symptom) ? AppColors.whiteColor : AppColors.neutralColor600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                            title: "Compare Symptoms",
                            maxSize: const Size(343, 48),
                            minSize: const Size(343, 48),
                            onPressed: value.compareSymptoms.isNotEmpty
                                ? () {
                                    AppNavigation.goBack();
                                    value.loadGraphData();
                                  }
                                : null)
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
