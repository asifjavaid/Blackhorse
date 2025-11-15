import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';

import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscribeButtonWidget extends StatelessWidget {
  final VoidCallback? navigationCallback;
  const SubscribeButtonWidget({super.key, this.navigationCallback});

  @override
  Widget build(BuildContext context) {
    var subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    return CustomButton(
      title: subscriptionProvider.isFreeTrialUI
          ? 'Start 7-day free trial'
          : 'Start your subscription',
      onPressed: () {
        subscriptionProvider.purchasePackage(navigationCallback);
      },
    );
  }
}
