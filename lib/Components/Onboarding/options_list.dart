import 'package:ekvi/Models/Onboarding/onboarding_model.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_helper.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Widgets/Buttons/custom_option_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsList extends StatelessWidget {
  final List<OnboardingAnswerModel>? answers;
  const OptionsList({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    return answers != null
        ? Consumer<OnboardingProvider>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: answers!.map((option) {
                  var buttonData = OnboardingHelper.getOptionButtonData(
                    option: option,
                    provider: value,
                    context: context,
                    goBackCallback: () => AppNavigation.goBack(),
                  );
                  return option.answerText!.isNotEmpty
                      ? CustomOptionButton(
                          optionText: buttonData['optionText'],
                          onPressed: buttonData['onPressed'],
                          isSelected: buttonData['isSelected'],
                        )
                      : const SizedBox.shrink();
                }).toList(),
              );
            },
          )
        : const SizedBox.shrink();
  }
}
