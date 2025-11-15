import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscribeBillingIssueBanner extends StatelessWidget {
  const SubscribeBillingIssueBanner({super.key, s});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<SubscriptionProvider>(
      builder: (context, value, child) => value.showBillingIssueBanner
          ? Container(
              width: double.infinity,
              color: AppColors.actionColor600,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "We couldn't process your subscription payment. To continue enjoying premium features, please update your payment information.",
                          style: textTheme.bodyMedium!.copyWith(color: AppColors.neutralColor50),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
