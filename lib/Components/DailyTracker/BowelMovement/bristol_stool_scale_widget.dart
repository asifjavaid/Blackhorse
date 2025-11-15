import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BristolStoolScaleWidget extends StatelessWidget {
  const BristolStoolScaleWidget({super.key});

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
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  'Your gut health is an important part of your overall wellbeing, and the Bristol Stool Scale is a simple way to understand it better. This scale categorizes stool into seven types, helping you track what’s normal for you and what might need attention:\n',
                  textTheme),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text.rich(
              TextSpan(
                children: [
                  _TitleText('• Type 1: ', textTheme),
                  _SubtitleText(' Separate hard lumps, like nuts (hard \n\t\tto pass).\n', textTheme),
                  _TitleText('• Type 2: ', textTheme),
                  _SubtitleText('Sausage-shaped but lumpy.\n', textTheme),
                  _TitleText('• Type 3: ', textTheme),
                  _SubtitleText(' Like a sausage but with cracks on the \n\t\tsurface (average stool).\n', textTheme),
                  _TitleText('• Type 4: ', textTheme),
                  _SubtitleText(' Like a sausage or snake, smooth and \n\t\tsoft (average stool).\n', textTheme),
                  _TitleText('• Type 5: ', textTheme),
                  _SubtitleText('Soft blobs with clear-cut edges \n\t\t(passed easily).\n', textTheme),
                  _TitleText('• Type 6: ', textTheme),
                  _SubtitleText(' Fluffy pieces with ragged edges, a\n\t\tmushy stool (diarrhea).\n', textTheme),
                  _TitleText('• Type 7: ', textTheme),
                  _SubtitleText('Watery, no solid pieces, entirely liquid \n\t\t(diarrhea).\n', textTheme),
                ],
              ),
            ),
          ),
          Text.rich(TextSpan(children: [
            _SubtitleText(
                'Tracking your bowel movements with the scale helps you spot patterns, understand how your diet, hormones, or stress might affect your gut, and share clear information with your healthcare provider.',
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
