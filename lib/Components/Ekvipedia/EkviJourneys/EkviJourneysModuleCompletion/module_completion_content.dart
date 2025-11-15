import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ModuleCompletionContent extends StatelessWidget {
  const ModuleCompletionContent({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // Title
          Text(
            "You  did it!",
            style: textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.neutralColor600,
              fontFamily: 'Zitter',
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            "This module is complete",
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.neutralColor500,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Celebration Icon
          SvgPicture.asset(
            '${AppConstant.assetIcons}congratsIcon.svg',
            width: 55,
            height: 55,
          ),
          const SizedBox(height: 32),

          // First paragraph
          Text(
            "You've just completed this module – take a moment to appreciate the progress you're making.",
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.neutralColor600,
              height: 1.5,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Second paragraph
          Text(
            "Learning about your body, mind, and health is powerful, and every step you take brings you closer to understanding and caring for yourself in new ways.",
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.neutralColor600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
