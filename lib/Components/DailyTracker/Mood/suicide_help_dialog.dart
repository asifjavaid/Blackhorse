import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SuicideHelpDialog extends StatelessWidget {
  const SuicideHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      surfaceTintColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  child: const Icon(
                    Icons.close,
                  ),
                  onTap: () => AppNavigation.goBack()),
            ),
            const SizedBox(height: 32),
            Text("You’re not alone", style: textTheme.displayMedium),
            const SizedBox(height: 16),
            Text("You have indicated that you are having suicidal thoughts. This is not something you should have to carry alone. We strongly recommend seeking help.\n", style: textTheme.bodyMedium),
            Text(
                "Please contact your doctor's office and ask if they have an available appointment today. If your doctor is not available, we recommend that you call your nearest emergency medical service.",
                style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
