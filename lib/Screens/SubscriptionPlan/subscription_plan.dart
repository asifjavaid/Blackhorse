import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({super.key});

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BackNavigation(
                title: "Subscription Plan",
                callback: () {
                  AppNavigation.goBack();
                }),
            Consumer<SubscriptionProvider>(builder: (context, value, child) {
              final package = value.currentPackage;
              final storeProduct = package?.storeProduct;
              final entitlement = value.currentEntitlement;
              DateTime? expirationDate = DateTime.tryParse(entitlement?.expirationDate.toString() ?? "");
              String formattedDate = expirationDate != null ? HelperFunctions.getFormattedDateFromDateTime(expirationDate) : "N/A";

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 12, 0, 8),
                      child: Text(
                        'Subscription Plan',
                        style: textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      storeProduct?.title ?? "N/A",
                      style: textTheme.headlineSmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 24, 0, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Plan',
                            style: textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${storeProduct?.priceString ?? "N/A"}/- ${package?.packageType.name ?? "N/A"}",
                      style: textTheme.headlineSmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 24, 0, 8),
                      child: Text(
                        'Next Payment',
                        style: textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "${storeProduct?.priceString ?? "N/A"}/- on $formattedDate",
                      style: textTheme.headlineSmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              );
            })
          ],
        )),
      ),
    );
  }
}

class CancelSubscriptionDialog extends StatelessWidget {
  const CancelSubscriptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Dialog(
      surfaceTintColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: const Icon(Icons.close),
                onTap: () {
                  AppNavigation.goBack();
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Are you sure you want to cancel your subscription?",
              textAlign: TextAlign.center,
              style: textTheme.displayMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "You will no longer have access to your insights and all the stories in Ekvipedia.",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
              title: "Cancel Subscription",
              onPressed: () {
                AppNavigation.goBack();
                confirmCancelDialog(context, textTheme);
              },
            ),
          ],
        ),
      ),
    );
  }

  confirmCancelDialog(BuildContext context, TextTheme textTheme) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Your subscription has been cancelled.",
                  textAlign: TextAlign.center,
                  style: textTheme.displayMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
