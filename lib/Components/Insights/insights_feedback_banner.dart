import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

class InsightsFeedbackBanner extends StatelessWidget {
  const InsightsFeedbackBanner({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        decoration: ShapeDecoration(
         color:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('We want your feedback!', style: textTheme.displaySmall),
            const SizedBox(height: 24),
            Text(
                'This is our first version of Insights, and we have big plans to make it even better. But, we want to know what you think! How is it working, what is missing, and how would you want it to evolve?',
                style: textTheme.bodySmall),
            const SizedBox(height: 24),
            CustomButton(
                title: "Let Us Know",
                onPressed: () async {
                  await Intercom.instance.displayMessenger();
                },
                buttonType: ButtonType.secondary)
          ],
        ),
      ),
    );
  }
}
