import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PainReliefTriggerOptionChip extends StatelessWidget {
  final String option;
  const PainReliefTriggerOptionChip({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PainReliefVaultProvider>();
    final isSelected = provider.triggers.contains(option);

    return GestureDetector(
      onTap: () => provider.toggleTrigger(option),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isSelected ? AppColors.secondaryColor600 : AppColors.secondaryColor400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          option,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: isSelected ? AppColors.whiteColor : AppColors.neutralColor600,
              ),
        ),
      ),
    );
  }
}
