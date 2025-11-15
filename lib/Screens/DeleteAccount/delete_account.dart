import 'package:ekvi/Components/DeleteAccount/delete_account_dialog.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              BackNavigation(
                  title: "Delete Account",
                  callback: () {
                    AppNavigation.goBack();
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We’re sorry to see you go",
                      style: textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Just a heads-up: Deleting your account will erase all your data, including your symptom history and personal insights.\n",
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      "If you decide to join us again in the future, you'll need to create a new account and start fresh.\n",
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      "If there's anything we can do to improve your experience or if you have concerns you'd like to discuss, we're here to listen.",
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 32 + 24,
                    ),
                    CustomButton(
                      title: "Delete Account",
                      buttonType: ButtonType.secondary,
                      onPressed: () {
                        showDialog(
                            context: AppNavigation.currentContext!,
                            builder: (BuildContext context) {
                              return const DeleteAccountDialog();
                            });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
