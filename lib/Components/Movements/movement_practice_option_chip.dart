import 'package:ekvi/Models/DailyTracker/Movement/user_movements_model.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovementPracticeOptionChip extends StatelessWidget {
  final UserMovementsResponseModel practice;
  const MovementPracticeOptionChip({super.key, required this.practice});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovementProvider>();
    final isSelected = provider.categoryMovements.practices.contains(practice.id);

    return GestureDetector(
      onTap: () => provider.handleMovementPractice(practice.id!),
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
