import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:ekvi/Components/FeatureAlert/trial_alert.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';

class SubscriptionWelcome extends StatefulWidget {
  final VoidCallback? navigationCallback;
  const SubscriptionWelcome({super.key, this.navigationCallback});

  @override
  State<SubscriptionWelcome> createState() => _SubscriptionWelcomeState();
}

class _SubscriptionWelcomeState extends State<SubscriptionWelcome> {
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 1));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controllerBottomCenter.play();
      await Future.delayed(const Duration(seconds: 1));

      showDialog<void>(
        // ignore: use_build_context_synchronously
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const TrialAlertDialog();
        },
      );
    });
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: GradientBackground(
          child: SafeArea(
              child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BackNavigation(
                  title: "",
                  callback: () {
                    AppNavigation.goBack();
                  },
                  startIcon: Assets.customiconsArrowLeft,
                ),
                SvgPicture.asset(
                  "${AppConstant.assetImages}welcome_tribe.svg",
                  fit: BoxFit.scaleDown,
                  width: 90.w,
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'Welcome to the Tribe!',
                    textAlign: TextAlign.center,
                    style: textTheme.displayLarge
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 24),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 12, right: 12),
                  child: Text(
                    'We’re excited to have you with us. As an Ekvi Empower subscriber, you’re joining a community committed to co-creating a better future for endometriosis patients. We invite you to voice your opinions and help shape our journey together.',
                    textAlign: TextAlign.start,
                    style: textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 12, right: 12),
                  child: Text(
                    'Here’s what you now have access to:',
                    textAlign: TextAlign.start,
                    style: textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 16, right: 16),
                  child: Column(
                    children: [
                      SubscribeRow(
                        title: 'Your personalized data: ',
                        subtitle:
                            'See clear patterns and trends unique to you.',
                        textTheme: textTheme,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: SubscribeRow(
                          title: 'All stories and expert tips: ',
                          subtitle: 'Access content tailored to your symptoms.',
                          textTheme: textTheme,
                        ),
                      ),
                      SubscribeRow(
                        title: 'Real support: ',
                        subtitle:
                            'Navigate your health journey with honest, trustworthy assistance.',
                        textTheme: textTheme,
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        title: "Let's get started",
                        onPressed: 
                        widget.navigationCallback ??
                            () {
                              Provider.of<DashboardProvider>(context,
                                      listen: false)
                                  .setBottomNavIndex(0);
                              AppNavigation.popUntil(AppRoutes.sideNavManager);
                            },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          top: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirectionality: BlastDirectionality.explosive,
              maxBlastForce: 80,
              blastDirection: pi / 2,
              emissionFrequency: 0.1,
              numberOfParticles: 300,
              maximumSize: const Size(15, 10),
              minimumSize: const Size(10, 5),
              shouldLoop: false,
              gravity: 1,
            ),
          ),
        ),
      ]))),
    );
  }
}

class SubscribeRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextTheme textTheme;

  const SubscribeRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "${AppConstant.assetIcons}Vector.svg",
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomCenter,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                TextSpan(
                  text: subtitle,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
