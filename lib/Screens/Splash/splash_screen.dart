import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_display/delayed_display.dart';
// import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Providers/Login/login_provider.dart';
import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Providers/Splash/splash_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final splashProvider = context.read<SplashProvider>();
      // final journeysProvider = context.read<EkviJourneysProvider>();

      splashProvider.showTextTyper();
      // journeysProvider.syncContentfulData(); // Trigger sync immediately

      Timer(const Duration(seconds: 3), () {
        splashProvider.decideNavigation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer3<SplashProvider, LoginProvider, RegisterProvider>(
      builder:
          (context, splashProvider, loginProvider, registerProvider, child) {
        return Scaffold(
          body: GradientBackground(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DelayedDisplay(
                      fadingDuration: const Duration(seconds: 1),
                      slidingCurve: Curves.ease,
                      child: SvgPicture.asset(
                        "${AppConstant.assetImages}ekvi.svg",
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: splashProvider.showText
                        ? _typer()
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(height: 2.h),
                  if (splashProvider.enableBiometricAuthentication) ...[
                    CustomButton(
                      title: AppLocalizations.of(context)!
                          .authenticateWithBiometric,
                      onPressed: () => loginProvider.biometricAuthentication(),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No biometric?", style: textTheme.bodySmall),
                        SizedBox(width: 2.w),
                        GestureDetector(
                          onTap: () {
                            AppNavigation.pushReplacementTo(
                                AppRoutes.loginRoute);
                          },
                          child: Text(
                            "Sign in",
                            style: textTheme.bodySmall!.copyWith(
                              color: AppColors.actionColor600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.actionColor600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _typer() {
    return SizedBox(
      child: DefaultTextStyle(
        style: Theme.of(AppNavigation.currentContext!).textTheme.titleSmall!,
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          pause: const Duration(milliseconds: 500),
          animatedTexts: [
            ColorizeAnimatedText(
              "Know yourself. Be known.",
              textStyle:
                  Theme.of(AppNavigation.currentContext!).textTheme.titleSmall!,
              colors: [
                AppColors.neutralColor600,
                Colors.transparent,
              ],
              speed: const Duration(milliseconds: 50),
            ),
          ],
        ),
      ),
    );
  }
}
