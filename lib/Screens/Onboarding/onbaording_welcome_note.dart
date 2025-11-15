import 'package:ekvi/Providers/Onboarding/onboarding_provider.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingWelcomeNote extends StatelessWidget {
  const OnboardingWelcomeNote({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<OnboardingProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            "Welcome Gorgeous!",
            style: textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            "We’re excited to have you on board! Now, let’s jazz up your profile to tailor this experience just for you.",
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Pssst! It's a quick 5-minute tour, and the more you spill, the better we weave the magic into your app for those personal vibes. ",
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomButton(
              title: "Let’s Begin!",
              onPressed: () => provider.hideWelcomeNote(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
