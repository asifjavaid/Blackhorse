import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UrinationUrgencyLevelHelpWidget extends StatelessWidget {
  const UrinationUrgencyLevelHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What does it mean?',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(
            TextSpan(
              children: [
                _TitleText('Mild - ', textTheme),
                _SubtitleText("Slight sense of needing to urinate, easy to ignore or delay.\n\n", textTheme),
                _TitleText('Moderate - ', textTheme),
                _SubtitleText("Noticeable urge to urinate, manageable but might require planning.\n\n", textTheme),
                _TitleText('Strong - ', textTheme),
                _SubtitleText("Strong urge to urinate, difficult to delay, requires attention.\n\n", textTheme),
                _TitleText('Severe - ', textTheme),
                _SubtitleText("Very strong urge to urinate, challenging to delay, can be distressing.\n\n", textTheme),
                _TitleText('Intense - ', textTheme),
                _SubtitleText("Overwhelming urge to urinate, almost impossible to delay, very distressing.\n\n", textTheme),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TitleText extends TextSpan {
  _TitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.titleSmall?.copyWith(color: AppColors.neutralColor600, fontWeight: FontWeight.w700, height: 0),
        );
}

class _SubtitleText extends TextSpan {
  _SubtitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            height: 1.60,
          ),
        );
}
