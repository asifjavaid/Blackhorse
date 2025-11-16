import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UrinationUrgencyColorHelpWidget extends StatelessWidget {
  const UrinationUrgencyColorHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Understanding your urine colour', style: textTheme.headlineSmall),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Text.rich(
              TextSpan(
                children: [
                  subtitleText(
                      'Keeping an eye on the colour of your urine can provide valuable insights into your health. Here’s a quick guide to help you understand what different colours might mean:\n\n',
                      textTheme),
                  titleText('Clear: ', textTheme),
                  subtitleText(
                      'You might be overhydrating. It’s good to drink water, but too much can dilute important salts in your body.\n\n', textTheme),
                  titleText('Pale yellow: ', textTheme),
                  subtitleText(
                      'Great job! This colour indicates you’re well-hydrated and everything is normal.\n\n',
                      textTheme),
                  titleText('Dark yellow: ', textTheme),
                  subtitleText(
                      'Time to drink more water. This colour suggests mild dehydration.\n\n',
                      textTheme),
                  titleText('Amber or Honey: ', textTheme),
                  subtitleText(
                      'You’re likely dehydrated. Make sure to increase your fluid intake.\n\n',
                      textTheme),
                  titleText('Orange: ', textTheme),
                  subtitleText(
                      'This could be due to dehydration or something you’ve eaten (like carrots), or certain medications. If it’s persistent, check with a healthcare provider to rule out liver or bile duct issues.\n\n',
                      textTheme),
                  titleText('Pink or Red: ', textTheme),
                  subtitleText(
                      'Don’t panic, but do pay attention. This might be from foods like beets or berries, but it could also indicate blood in your urine. If you haven’t eaten anything red, it’s best to consult a healthcare provider.\n\n',
                      textTheme),
                  titleText('Blue or Green: ', textTheme),
                  subtitleText(
                      'This unusual colour can result from certain medications, foods, or dyes. Rarely, it could indicate an infection or other medical condition. Check with a healthcare provider if you’re concerned.\n\n',
                      textTheme),
                  titleText('Dark brown: ', textTheme),
                  subtitleText(
                      'This could mean you’re very dehydrated, or it might indicate liver disease or muscle injury. Eating large amounts of fava beans or taking certain medications can also cause this colour. Check with a healthcare provider if you’re concerned.\n\n',
                      textTheme),
                  titleText('Cloudy: ', textTheme),
                  subtitleText(
                      'This might indicate a urinary tract infection (UTI), kidney stones, or another condition. If you notice persistent cloudiness, it’s a good idea to get it checked out.\n\n',
                      textTheme),
                  titleText('Foamy: ', textTheme),
                  subtitleText(
                      'This could mean there’s protein in your urine, possibly pointing to a kidney issue. If you notice this often, it’s a good idea to get it checked out.\n\n',
                      textTheme),
                  subtitleText(
                      'By tracking the colour of your urine, you can get a better understanding of your hydration levels and overall health. If you ever have concerns or notice persistent changes, don’t hesitate to reach out to a healthcare provider for advice.\n\n',
                      textTheme),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  TextSpan titleText(title, textTheme) {
    return TextSpan(
      text: title,
      style: textTheme.titleSmall?.copyWith(
        color: AppColors.neutralColor600,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  TextSpan subtitleText(subtitle, textTheme) {
    return TextSpan(
      text: subtitle,
      style: textTheme.bodySmall?.copyWith(
        color: AppColors.neutralColor600,
        height: 1.60,
      ),
    );
  }
}
