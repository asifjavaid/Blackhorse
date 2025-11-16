// import 'package:ekvi/Components/Onboarding/tutorial_dialog.dart';
import 'package:ekvi/Components/Onboarding/options_list.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_helper.dart';
import 'package:ekvi/Providers/Onboarding/onboarding_provider.dart';
import 'package:ekvi/Screens/Onboarding/onbaording_welcome_note.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/veritcal_wheel_number_picker.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    HelperFunctions.initializeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Consumer<OnboardingProvider>(
            builder: (context, value, child) {
              return (value.onboardingQuestion.firstQuestion ?? false) && (value.welcomeNote)
                  ? const OnboardingWelcomeNote()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: value.onboardingQuestion.questionId != null
                              ? ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 24),
                                        value.wasLastQuestion
                                            ? const SizedBox.shrink()
                                            : Row(
                                                children: [
                                                  (value.onboardingQuestion.questionId == OnboardingHelper.firstQuestionId)
                                                      ? const SizedBox.shrink()
                                                      : Row(
                                                          children: [
                                                            InkWell(
                                                              borderRadius: BorderRadius.circular(100),
                                                              onTap: () => value.goBackToPreviousAnswer(),
                                                              child: SvgPicture.asset(
                                                                Assets.customiconsArrowLeft,
                                                                height: 18,
                                                                width: 18,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 24,
                                                            )
                                                          ],
                                                        ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 18,
                                                      alignment: Alignment.center,
                                                      child: LinearProgressIndicator(
                                                        value: value.userProgressValue,
                                                        minHeight: 4.0,
                                                        backgroundColor: AppColors.primaryColor500,
                                                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondaryColor600),
                                                        borderRadius: BorderRadius.circular(21),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        const SizedBox(height: 32),
                                        Text(
                                          value.onboardingQuestion.header!,
                                          style: textTheme.displayMedium,
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: 24),
                                        ...value.onboardingQuestion.topText!.map(
                                          (text) => Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: Text(
                                              text,
                                              style: textTheme.bodyMedium,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        value.onboardingQuestion.questionId == OnboardingHelper.diagnosisQuestionID
                                            ? NumberPickerWidget(
                                                selectedBorder: const Border(
                                                  top: BorderSide(
                                                    color: AppColors.neutralColor300,
                                                    width: 0.5,
                                                  ),
                                                  bottom: BorderSide(
                                                    color: AppColors.neutralColor300,
                                                    width: 0.5,
                                                  ),
                                                ),
                                                options: OnboardingHelper.diagnosisYearsList,
                                                widgetBorder: Border.all(color: AppColors.primaryColor600, width: 1),
                                                selectedBgColor: Colors.white,
                                                selectedBorderRadius: BorderRadius.circular(0),
                                                textStyle: const TextStyle(color: AppColors.neutralColor600, fontSize: 23, fontWeight: FontWeight.w400, decorationColor: AppColors.neutralColor600),
                                                numberTextStyle:
                                                    const TextStyle(color: AppColors.neutralColor400, fontSize: 18, fontWeight: FontWeight.w400, decorationColor: AppColors.neutralColor400),
                                                widgetBgColor: AppColors.whiteColor,
                                                widgetBorderRadius: BorderRadius.circular(12),
                                                selected: value.cycleTracking.diagnosisTimeframe!,
                                                onSelectedItemChanged: value.setDiagnosisTime,
                                              )
                                            : OptionsList(
                                                answers: value.onboardingQuestion.answersList,
                                              ),
                                        const Spacer(),
                                        value.onboardingQuestion.type == AppConstant.oboardingDisplayText
                                            ? Align(
                                                alignment: Alignment.bottomRight,
                                                child: CustomButton(
                                                  title: value.onboardingQuestion.buttonText!,
                                                  onPressed: () => value.saveUserAnswer(),
                                                ),
                                              )
                                            : Align(
                                                alignment: Alignment.bottomRight,
                                                child: CustomButton(
                                                  title: value.onboardingQuestion.buttonText!,
                                                  onPressed: value.anyAnswerSelected ? () => value.syncUserResponse() : null,
                                                ),
                                              ),
                                        const SizedBox(height: 32),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        );
                      }),
                    );
            },
          ),
        ),
      ),
    );
  }
}
