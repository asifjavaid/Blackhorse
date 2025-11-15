import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ActiveIngredientInfoSheet extends StatelessWidget {
  const ActiveIngredientInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Understanding active ingredients', style: textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600)),
          const SizedBox(height: 24),
          Text(
            'When you take a painkiller, the “active ingredient” is what actually relieves your pain (when it’s effective).',
            style: textTheme.bodySmall?.copyWith(color: AppColors.neutralColor600, height: 1.6),
          ),
          const SizedBox(height: 16),
          Text('How to find the active ingredient', style: textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            'Look for a section labeled “Active Ingredient” or “Drug Facts” on your painkiller package. It’s usually near the top or on the back.',
            style: textTheme.bodySmall?.copyWith(color: AppColors.neutralColor600, height: 1.6),
          ),
          const SizedBox(height: 16),
          Text('Why track active ingredients?', style: textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            'We ask you to track the active ingredient instead of the brand name because different brands can have the same active ingredient. Tracking painkillers this way helps your doctor understand your painkiller use better and make safer recommendations for you.',
            style: textTheme.bodySmall?.copyWith(color: AppColors.neutralColor600, height: 1.6),
          ),
        ],
      ),
    );
  }
}
