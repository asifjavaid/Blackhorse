import 'package:ekvi/Components/InAppPurchases/subscribe_bottom_panel_widget.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_button_widget.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_package_options_widget.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_regular_carousel_widget.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_restore_purchase_widget.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_screen_header_widget.dart';
import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_terms_policy_widget.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_free_trial_stepper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SubscribeScreen extends StatefulWidget {
  final VoidCallback? navigationCallback;
  const SubscribeScreen({super.key, this.navigationCallback});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GradientBackground(
        child: Consumer<SubscriptionProvider>(
          builder: (context, subscriptionProvider, child) {
            return SafeArea(
              child: SlidingUpPanel(
                controller: _panelController,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                maxHeight: 650,
                minHeight: 0,
                panel: const SubscribeBottomPanel(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SubscribeScreenHeader(),
                      Text(
                        'Unlock Ekvi Empower',
                        textAlign: TextAlign.center,
                        style: textTheme.displayLarge,
                      ),
                      const SizedBox(height: 24),
                      subscriptionProvider.isFreeTrialUI
                          ? const SubscribeFreeTrialStepper()
                          : const SubscribeRegularCarouselWidget(),
                      const SizedBox(height: 64),
                      const SubscribePackageOptionsWidget(),
                      const SizedBox(height: 64),
                      SubscribeButtonWidget(navigationCallback: widget.navigationCallback),
                      const SizedBox(height: 16),
                      const RestorePurchaseWidget(),
                      const SizedBox(height: 24),
                      const TermsAndPolicyText(),
                      const SizedBox(height: 104),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
