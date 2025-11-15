import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestorePurchaseWidget extends StatefulWidget {
  const RestorePurchaseWidget({
    super.key,
  });

  @override
  State<RestorePurchaseWidget> createState() => RestorePurchaseWidgetState();
}

class RestorePurchaseWidgetState extends State<RestorePurchaseWidget> {
  final TapGestureRecognizer restorePurchaseRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    restorePurchaseRecognizer.onTap = () => context.read<SubscriptionProvider>().restorePurchases();
  }

  @override
  void dispose() {
    restorePurchaseRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Restore Purchase',
            recognizer: restorePurchaseRecognizer,
            style: textTheme.labelMedium?.copyWith(
              fontSize: 14,
              color: AppColors.actionColor600,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.actionColor600,
            ),
          ),
        ],
      ),
    );
  }
}
