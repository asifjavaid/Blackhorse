import 'package:ekvi/Models/DailyTracker/SelfCare/user_selfcare_model.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelfcarePracticeOptionChip extends StatelessWidget {
  final UserSelfCareResponseModel practice;
  const SelfcarePracticeOptionChip({super.key, required this.practice});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelfcareProvider>();
    final isSelected = provider.categorySelfCare.practices.contains(practice.id);

    return GestureDetector(
      onTap: () => provider.handleSelfCarePractice(practice.id!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isSelected ? AppColors.secondaryColor600 : AppColors.secondaryColor400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          '${practice.emoji} ${practice.name}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: isSelected ? AppColors.whiteColor : AppColors.neutralColor600),
        ),
      ),
    );
  }
}
