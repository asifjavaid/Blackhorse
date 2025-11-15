import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/apple_signin_helper.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_register_header.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/TextFields/custom_checkbox_listile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class RegisterWithApple extends StatefulWidget {
  const RegisterWithApple({super.key});

  @override
  RegisterWithAppleState createState() => RegisterWithAppleState();
}

class RegisterWithAppleState extends State<RegisterWithApple> {
  final _formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapGestureRecognizer;
  var provider = Provider.of<RegisterProvider>(AppNavigation.currentContext!);

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = provider.launchTOSUrl;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose(); // Dispose the gesture recognizer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<RegisterProvider>(
      builder: (context, value, child) => Scaffold(
        body: GradientBackground(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                RegisterHeader(
                  login: false,
                  step: value.step,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Before we move on, please confirm you’re onboard with the legal stuff.',
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormField<bool>(
                        initialValue: value.hasAgreedToTOS,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (bool? val) {
                          if (val == null || !val) {
                            return 'At Ekvi, we value your privacy and trust. To be able to continue, we ask you to agree to our terms & conditions and privacy policy';
                          }
                          return null;
                        },
                        builder: (FormFieldState<bool> state) {
                          return CustomCheckboxListTile(
                            value: value.hasAgreedToTOS,
                            onChanged: (bool? val) {
                              // You can update state and provider both here if required
                              value.setHasAgreedToTOS(val);
                              state.didChange(val);
                            },
                            title: TextSpan(
                              style: textTheme.labelMedium,
                              children: [
                                TextSpan(
                                  text:
                                      "By signing up I have read and agree to Ekvi's ",
                                  style: textTheme.labelMedium!.copyWith(
                                      color: AppColors.neutralColor500),
                                ),
                                TextSpan(
                                    text: "Terms & Conditions ",
                                    style: textTheme.labelMedium!.copyWith(
                                      color: AppColors.actionColor600,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.actionColor600,
                                    ),
                                    recognizer: _tapGestureRecognizer),
                                TextSpan(
                                  text: "and ",
                                  style: textTheme.labelMedium!.copyWith(
                                      color: AppColors.neutralColor500),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: textTheme.labelMedium!.copyWith(
                                    color: AppColors.actionColor600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.actionColor600,
                                  ),
                                ),
                              ],
                            ),
                            isError: state
                                .hasError, // or whatever condition you're using to determine an error
                          );
                        },
                      ),
                      CustomCheckboxListTile(
                        value: value.wantsNewsletter,
                        onChanged: value.setWantsNewsLetter,
                        title: TextSpan(
                          style: textTheme.labelMedium,
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!
                                  .newsletterSubscription,
                              style: textTheme.labelMedium!
                                  .copyWith(color: AppColors.neutralColor500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Column(
                        children: [
                          CustomButton(
                            title: AppLocalizations.of(context)!.signUpButton,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AppleSignInHelper.continueWithApple();
                              }
                            },
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .alreadyHaveAccount,
                                    style: textTheme.bodySmall!),
                                SizedBox(
                                  width: 2.w,
                                ),
                                GestureDetector(
                                    onTap: (() {
                                      AppNavigation.pushReplacementTo(
                                          AppRoutes.loginRoute);
                                    }),
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .signUpLoginText,
                                        style: textTheme.bodySmall!.copyWith(
                                          color: AppColors.actionColor600,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.actionColor600,
                                        ))),
                              ]),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
