import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/material.dart';

class PremiumIconWidget extends StatelessWidget {
  final double? circleWidth;
  final double? circleHeight;
  final double? iconSize;

  const PremiumIconWidget({
    super.key,
    this.circleWidth,
    this.circleHeight,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return UserManager().isPremium
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(right: 8),
            child: HelperFunctions.giveBackgroundToIcon(
              width: circleWidth ?? 36,
              height: circleHeight ?? 36,
              Icon(
                AppCustomIcons.locked,
                color: AppColors.whiteColor,
                size: iconSize ?? 17,
              ),
              bgColor: AppColors.actionColor600,
            ),
          );
  }
}
