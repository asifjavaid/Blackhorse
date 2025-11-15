import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MovementEnjoymentHelpWidget extends StatelessWidget {
  const MovementEnjoymentHelpWidget({super.key});

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
            'Why rate your enjoyment?',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  "Tracking how much you enjoy your practice helps you discover what truly works for you. Enjoyment is key to building a routine you’ll stick with, making movement feel less like a chore and more like self-care. Over time, these ratings can reveal patterns — like which activities boost your mood, energize you, or align with your cycle. Here’s a quick explanation of the rating:\n",
                  textTheme),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text.rich(
              TextSpan(
                children: [
                  _TitleText('• Terrible: ', textTheme),
                  _SubtitleText("You dreaded every moment.\n", textTheme),
                  _TitleText('• Meh: ', textTheme),
                  _SubtitleText("It was okay, but not enjoyable.\n", textTheme),
                  _TitleText('• Decent: ', textTheme),
                  _SubtitleText("Felt fine, nothing special.\n", textTheme),
                  _TitleText('• Good: ', textTheme),
                  _SubtitleText("You liked it and felt energized.\n", textTheme),
                  _TitleText('• Amazing: ', textTheme),
                  _SubtitleText("You loved it and can’t wait to do it\n\t\tagain!\n", textTheme),
                ],
              ),
            ),
          ),
          Text.rich(TextSpan(children: [
            _SubtitleText(
                "By reflecting on what you love (and what you don’t), you can create a sustainable, feel-good movement journey that supports both your physical and mental well-being. After all, the best practice is the one that makes you feel good inside and out!",
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
