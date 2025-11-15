import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BodyPainHelpWidget extends StatelessWidget {
  const BodyPainHelpWidget({super.key});

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
                _TitleText('Minimal: ', textTheme),
                _SubtitleText("I can notice a faint pain, but it's not slowing me down.\n\n", textTheme),
                _TitleText('Mild: ', textTheme),
                _SubtitleText("I'm aware of the pain. It's like a persistent hum in the background.\n\n", textTheme),
                _TitleText('Uncomfortable: ', textTheme),
                _SubtitleText("There's a nagging pain that's hard to ignore. It's uncomfortable but manageable.\n\n", textTheme),
                _TitleText('Moderate: ', textTheme),
                _SubtitleText("I am constantly aware of the pain but I can continue most activities.\n\n", textTheme),
                _TitleText('Distracting: ', textTheme),
                _SubtitleText("My pain is persistent enough that it's distracting me from my tasks.\n\n", textTheme),
                _TitleText('Distressing: ', textTheme),
                _SubtitleText("It's difficult to maintain my routine because the pain demands attention.\n\n", textTheme),
                _TitleText('Unmanageable: ', textTheme),
                _SubtitleText("I am in constant pain. It's restricting my enjoyment and participation in daily activities.\n\n", textTheme),
                _TitleText('Severe: ', textTheme),
                _SubtitleText("Pain dominates my existence. It's difficult to engage in conversation or even think clearly.\n\n", textTheme),
                _TitleText('Debilitating: ', textTheme),
                _SubtitleText("The pain consumes all my attention. It's a challenge to express thoughts or needs.\n\n", textTheme),
                _TitleText('Excruciating: ', textTheme),
                _SubtitleText("I'm completely overwhelmed by pain. Can't move, can't think, can't bear it.\n\n", textTheme),
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
