import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UrinationUrgencyVolumeHelpWidget extends StatelessWidget {
  const UrinationUrgencyVolumeHelpWidget({super.key});

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
            'How much did you pee?',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  'Choose the option that best describes how full your bladder felt and how much urine came out.:\n\n',
                  textTheme),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text.rich(
              TextSpan(
                children: [
                  _TitleText('• None / Tried but couldn’t pee: ', textTheme),
                  _SubtitleText(' You felt the urge but couldn’t release urine.\n', textTheme),
                  _TitleText('• Drops: ', textTheme),
                  _SubtitleText('Just a few drops or a brief trickle.\n', textTheme),
                  _TitleText('• Small: ', textTheme),
                  _SubtitleText(' A light flow, lasting only a few seconds.\n', textTheme),
                  _TitleText('• Moderate: ', textTheme),
                  _SubtitleText(' A steady, normal flow that feels like a typical amount for you.\n', textTheme),
                  _TitleText('• Large: ', textTheme),
                  _SubtitleText('A strong flow and noticeable relief after.\n', textTheme),
                  _TitleText('• Very large: ', textTheme),
                  _SubtitleText(' A long or forceful stream — your bladder felt very full.\n', textTheme),
                ],
              ),
            ),
          ),
          Text.rich(TextSpan(children: [
            _SubtitleText(
                'Remember, there’s no “right” amount. This helps you and your care team see patterns. For example, if you’re urinating small amounts frequently, or struggling to empty your bladder at certain times in your cycle.',
                textTheme),
          ])),
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
