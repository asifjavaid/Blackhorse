import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CycleCalendarIconInformation extends StatelessWidget {
  const CycleCalendarIconInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> iconInfo = {
      'current_day.svg': 'Today',
      'tracked_bleeding.svg': 'Tracked Bleeding',
      'tracked_severe_pain.svg': 'Tracked Severe Pain',
      'tracked_moderate_pain.svg': 'Tracked Moderate Pain',
      'tracked_mild_no_pain.svg': 'Tracked Mild/No Pain',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('What does it mean?', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.neutralColor600)),
          const SizedBox(
            height: 24,
          ),
          ...iconInfo.entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      '${AppConstant.assetIcons}${entry.key}',
                      width: 24,
                      semanticsLabel: entry.value,
                    ),
                    const SizedBox(width: 16.0),
                    Text(entry.value, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.neutralColor600)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
