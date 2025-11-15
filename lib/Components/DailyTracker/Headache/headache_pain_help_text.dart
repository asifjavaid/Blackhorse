import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HeadachePainHelpWidget extends StatelessWidget {
  const HeadachePainHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Not sure how to rate your headache pain?',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Everyone experiences pain differently — what matters most is how it affects you.\n\n"
            "Use this scale to reflect on how the headache felt in your body and how much it interfered with your day. There’s no right or wrong answer, just choose the level that feels closest.\n\n"
            "Here’s a guide to help you:\n",
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.neutralColor600,
              height: 1.6,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                _TitleText('Minimal: ', textTheme),
                _SubtitleText(
                    "I can notice a faint pain, but it doesn’t affect my day.\n\n",
                    textTheme),
                _TitleText('Mild: ', textTheme),
                _SubtitleText(
                    "There’s a dull ache in the background, but I can focus and function normally.\n\n",
                    textTheme),
                _TitleText('Uncomfortable: ', textTheme),
                _SubtitleText(
                    "The pain is nagging and hard to ignore, but I can keep going.\n\n",
                    textTheme),
                _TitleText('Moderate: ', textTheme),
                _SubtitleText(
                    "I’m constantly aware of the pain. It’s starting to affect my mood or focus.\n\n",
                    textTheme),
                _TitleText('Distracting: ', textTheme),
                _SubtitleText(
                    "The pain is interfering with my ability to concentrate or stay present.\n\n",
                    textTheme),
                _TitleText('Distressing: ', textTheme),
                _SubtitleText(
                    "It’s hard to stay engaged in what I’m doing. The pain is taking over my attention.\n\n",
                    textTheme),
                _TitleText('Unmanageable: ', textTheme),
                _SubtitleText(
                    "The pain is constant and limiting. I need to rest or withdraw to cope.\n\n",
                    textTheme),
                _TitleText('Severe: ', textTheme),
                _SubtitleText(
                    "Pain dominates my experience. Light, sound, or conversation feel overwhelming.\n\n",
                    textTheme),
                _TitleText('Debilitating: ', textTheme),
                _SubtitleText(
                    "The pain consumes everything. Thinking, moving, or speaking is extremely difficult.\n\n",
                    textTheme),
                _TitleText('Excruciating: ', textTheme),
                _SubtitleText(
                    "I’m completely overwhelmed by pain. I can’t function, speak, or think. I need help.\n",
                    textTheme),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "💡Tip: ",
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.neutralColor600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text:
                      "Be as consistent as you can, but don’t overthink it. Over time, your logs will reveal important patterns and support better care from your healthcare provider.",
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.neutralColor600,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
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
          style: textTheme.titleSmall?.copyWith(
            color: AppColors.neutralColor600,
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        );
}

class _SubtitleText extends TextSpan {
  _SubtitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            height: 1.6,
          ),
        );
}
