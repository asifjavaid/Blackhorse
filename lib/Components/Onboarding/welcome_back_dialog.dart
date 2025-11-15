import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeBackOnboardingDialog extends StatelessWidget {
  const WelcomeBackOnboardingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: const Icon(Icons.close), onPressed: () => AppNavigation.goBack()),
            ),
            const SizedBox(height: 32),
            SvgPicture.asset(
              "${AppConstant.assetImages}welcome_back.svg",
            ),
            const SizedBox(height: 32),
            Text("Welcome back!", style: textTheme.displayMedium),
            const SizedBox(height: 16),
            Text("You’re just a few questions away from experiencing the magic of Ekvi!\n", style: textTheme.bodyMedium),
            Text("The more you tell us, the more we can tell you", style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
