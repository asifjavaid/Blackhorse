import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TrialAlertDialog extends StatelessWidget {
  const TrialAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<SubscriptionProvider>(AppNavigation.currentContext!, listen: false);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      surfaceTintColor: AppColors.whiteColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(child: const Icon(Icons.close), onTap: () => AppNavigation.goBack()),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 32,
                ),
                Text(
                  provider.isFreeTrialUI ? "Your 7-day trial has started" : "Welcome to Ekvi Empower!",
                  style: textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  provider.isFreeTrialUI
                      ? "Welcome to Ekvi Empower! Get notified when your trial is about to end, cancel whenever you want, in just a few seconds."
                      : "Do you want us to notify you when your subscription renews?",
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  title: 'Send me reminders',
                  onPressed: () => provider.allowSendingPurchaseReminders(),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => provider.disAllowSendingPurchaseReminders(),
                  child: Text('No, thank you',
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.actionColor600,
                        color: AppColors.actionColor600,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 207,
        height: 207,
        padding: const EdgeInsets.all(40.39),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.29),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19F89D87),
              blurRadius: 6,
              offset: Offset(2, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            "${AppConstant.assetIcons}announcement.svg",
            height: 126,
            width: 126,
          ),
        ));
  }
}
