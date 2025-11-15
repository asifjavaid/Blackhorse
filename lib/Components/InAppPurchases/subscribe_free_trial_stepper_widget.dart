import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubscribeFreeTrialStepper extends StatelessWidget {
  const SubscribeFreeTrialStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressStep(
            iconSvg: SvgPicture.asset("${AppConstant.assetIcons}celebration.svg"),
            stepTitle: 'Ekvi Essence',
            stepDescription: 'You successfully started on the free plan.',
            completed: true,
            isTextCross: true,
            isFill: true,
          ),
          const ProgressStep(
            icon: AppCustomIcons.locked,
            stepTitle: 'Today: Unlock Ekvi Empower',
            stepDescription: 'Access your personalized insights and articles in Ekvipedia.',
            completed: true,
            isFill: true,
          ),
          const ProgressStep(
            icon: AppCustomIcons.notification,
            stepTitle: 'Day 5: We’ll send you a reminder',
            stepDescription: 'We’ll send you an email/notification. Cancel anytime in just 15 seconds.',
            completed: true,
            isFill: false,
          ),
          const ProgressStep(
            icon: AppCustomIcons.heart,
            stepTitle: 'Day 7: Trial Ends',
            stepDescription: 'Your free trial will end after 7 days, your subscription starts the day after.',
            completed: false,
            isFill: false,
          ),
        ],
      ),
    );
  }
}

class ProgressStep extends StatelessWidget {
  final IconData? icon;
  final Widget? iconSvg;
  final String stepTitle;
  final String stepDescription;
  final bool completed;
  final bool isTextCross;
  final bool isFill;

  const ProgressStep({super.key, this.icon, this.iconSvg, this.isTextCross = false, required this.stepTitle, required this.stepDescription, required this.completed, required this.isFill});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The icon with the progress line
        Column(
          children: [
            iconSvg ??
                HelperFunctions.giveBackgroundToIcon(
                    width: 36,
                    height: 36,
                    Icon(
                      icon,
                      color: isFill ? AppColors.whiteColor : AppColors.primaryColor600,
                      size: 18,
                    ),
                    bgColor: isFill ? AppColors.primaryColor600 : AppColors.whiteColor),
            if (completed) Container(width: 1, margin: const EdgeInsets.symmetric(vertical: 5), height: 30, color: AppColors.primaryColor600),
          ],
        ),
        const SizedBox(width: 16),
        // The text section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stepTitle, style: textTheme.bodySmall?.copyWith(decoration: isTextCross ? TextDecoration.lineThrough : TextDecoration.none, fontSize: 14, fontWeight: FontWeight.w500)),
              Text(stepDescription, style: textTheme.labelMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }
}
