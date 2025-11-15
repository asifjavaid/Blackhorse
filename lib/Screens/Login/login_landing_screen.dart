import 'dart:io';

import 'package:ekvi/Components/Registration/authentication_button.dart';
import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/apple_signin_helper.dart';
import 'package:ekvi/Utils/helpers/google_signin_helper.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginLandingScreen extends StatelessWidget {
  const LoginLandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<RegisterProvider>(
      builder: (context, value, child) => Scaffold(
        body: GradientBackground(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 2),
                  SvgPicture.asset(
                    "${AppConstant.assetImages}ekvi.svg",
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.bottomCenter,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Login",
                    style: textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text("Welcome back to Ekvi!"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "To keep your account and data extra safe, we’ll ask you to log in with BankID, Google, or Apple.",
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 3),
                  AuthenticationButton(
                    title: "Norwegian BankId",
                    icon: "${AppConstant.assetIcons}bankid_logo.svg",
                    onClick: () => AppNavigation.navigateTo(AppRoutes.loginWithBankId),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AuthenticationButton(
                    title: "Google",
                    icon: "${AppConstant.assetIcons}google.svg",
                    onClick: () => GoogleSignInHelper.continueWithGoogle(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Platform.isIOS
                      ? Column(
                          children: [
                            AuthenticationButton(
                              title: "Apple",
                              icon: "${AppConstant.assetIcons}apple.svg",
                              onClick: () => AppleSignInHelper.continueWithApple(),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: textTheme.bodySmall),
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                        onTap: (() {
                          AppNavigation.pushReplacementTo(AppRoutes.registerRoute);
                        }),
                        child: Text("Sign up",
                            style: textTheme.bodySmall!.copyWith(
                              color: AppColors.actionColor600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.actionColor600,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
