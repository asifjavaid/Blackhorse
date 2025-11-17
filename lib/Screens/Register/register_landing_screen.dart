import 'dart:io';

import 'package:ekvi/Components/Registration/authentication_button.dart';
import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';

class RegisterLandingScreen extends StatelessWidget {
  const RegisterLandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<RegisterProvider>(
      builder: (context, value, child) => Scaffold(
        body: GradientBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 2),
                SvgPicture.asset(
                  "${AppConstant.assetImages}ekvi.svg",
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Welcome to Ekvi",
                  style: textTheme.displayMedium,
                ),
                const Spacer(flex: 3),
                Text(
                  "Sign up with",
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                AuthenticationButton(
                  title: "Norwegian BankId",
                  icon: "${AppConstant.assetIcons}bankid_logo.svg",
                  onClick: () => AppNavigation.navigateTo(AppRoutes.loginWithBankId),
                ),
                const SizedBox(
                  height: 24,
                ),
                AuthenticationButton(
                  title: "Google",
                  icon: Assets.iconsGoogle,
                  onClick: () => AppNavigation.navigateTo(AppRoutes.registerWithGoogle),
                ),
                const SizedBox(
                  height: 24,
                ),
                Platform.isIOS
                    ? Column(
                        children: [
                          AuthenticationButton(
                            title: "Apple",
                            icon: Assets.iconsApple,
                            onClick: () => AppNavigation.navigateTo(AppRoutes.registerWithApple),
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
                    Text("Already have an account?", style: textTheme.bodySmall),
                    SizedBox(
                      width: 1.w,
                    ),
                    GestureDetector(
                      onTap: (() {
                        AppNavigation.pushReplacementTo(AppRoutes.loginRoute);
                      }),
                      child: Text("Log in",
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
    );
  }
}
