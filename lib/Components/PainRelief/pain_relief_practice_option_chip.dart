import 'package:ekvi/Models/DailyTracker/PainRelief/user_pain_relief_model.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PainReliefPracticeOptionChip extends StatelessWidget {
  final UserPainReliefResponseModel practice;
  const PainReliefPracticeOptionChip({super.key, required this.practice});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PainReliefProvider>();

    final isSelected = practice.id != null && provider.categoryPainRelief.practices.contains(practice.id);

    return GestureDetector(
      onTap: () {
        if (practice.id != null) {
          provider.handlePainReliefPractice(practice.id!);
        } else {
          debugPrint("⚠️ PainReliefPracticeOptionChip: Practice ID is null");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isSelected ? AppColors.secondaryColor600 : AppColors.secondaryColor400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          '${practice.emoji} ${practice.name}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: isSelected ? AppColors.whiteColor : AppColors.neutralColor600,
              ),
        ),
      ),
    );
  }
}
