import 'package:ekvi/Providers/Login/login_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_icon_bulder.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/TextFields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

import '../../generated/assets.dart';

class LoginWithBankId extends StatefulWidget {
  const LoginWithBankId({super.key});

  @override
  State<LoginWithBankId> createState() => _LoginWithBankIdState();
}

class _LoginWithBankIdState extends State<LoginWithBankId> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var localization = AppLocalizations.of(context)!;
    return Scaffold(
        body: GradientBackground(
      child: SafeArea(
        child: Consumer<LoginProvider>(
            builder: (context, value, child) => Stack(children: [
                  SizedBox(
                    height: 100.h,
                    width: 100.w,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 6.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "${AppConstant.assetImages}ekvi.svg"),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(localization.signIn,
                              style: textTheme.displayLarge),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(localization.greetingMessage,
                                  textAlign: TextAlign.center,
                                  style: textTheme.headlineSmall!
                                      .copyWith(fontSize: 18))
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Text(localization.welcomeBackMessage,
                                textAlign: TextAlign.center,
                                style: textTheme.bodySmall),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5.w, right: 5.w, top: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: Text(localization.emailAddress,
                                      textAlign: TextAlign.left,
                                      style: textTheme.titleSmall),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 2.w, right: 2.w),
                                  child: Column(
                                    children: [
                                      CustomTextFormField(
                                        inputType: TextInputType.text,
                                        controller: value.emailController,
                                        prefixWidget: iconBuilder(
                                            SvgPicture.asset(
                                              Assets.customiconsEmail,
                                              height: 16,
                                              width: 16,
                                            ),
                                            Colors.transparent),
                                        obscureText: false,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      CustomButton(
                                        title: localization.loginWithBankID,
                                        onPressed: () => value.handleLogin(),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: (() {
                                              AppNavigation.pushReplacementTo(
                                                  AppRoutes.registerRoute);
                                            }),
                                            child: Text(
                                                localization.notUnaSignUp,
                                                style: textTheme.bodySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor600)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])),
      ),
    ));
  }
}
