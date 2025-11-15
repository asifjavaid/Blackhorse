import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class WellnessWeeklyJournalProgressBar extends StatelessWidget {
  final double value;

  const WellnessWeeklyJournalProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 6, // thickness
        backgroundColor: AppColors.primaryColor500,
        valueColor:
            const AlwaysStoppedAnimation<Color>(AppColors.secondaryColor600),
      ),
    );
  }
}
