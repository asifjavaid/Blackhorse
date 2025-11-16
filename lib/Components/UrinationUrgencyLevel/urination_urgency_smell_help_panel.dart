import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UrinationUrgencySmellHelpWidget extends StatelessWidget {
  const UrinationUrgencySmellHelpWidget({super.key});

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
            'Urine smell and why it matters',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  'Your bladder can give important clues about your health — and the smell of your urine is one of them. Changes in urine smell can reflect your hydration, hormones, diet, or even signal an infection.:\n\n',
                  textTheme),
              _SubtitleText(
                  'Here are some common smells and what they might mean:\n',
                  textTheme),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text.rich(
              TextSpan(
                children: [
                  _TitleText('• No smell: ', textTheme),
                  _SubtitleText(' Often a sign of good hydration.\n', textTheme),
                  _TitleText('• Strong or ammonia-like: ', textTheme),
                  _SubtitleText('May mean dehydration or concentrated urine.\n', textTheme),
                  _TitleText('• Sweet or fruity: ', textTheme),
                  _SubtitleText(' Can be linked to high blood sugar or ketosis.\n', textTheme),
                  _TitleText('• Fishy or foul: ', textTheme),
                  _SubtitleText(' Might suggest a UTI or bacterial imbalance.\n', textTheme),
                  _TitleText('• Burnt or sulfur-like: ', textTheme),
                  _SubtitleText('Often caused by foods like asparagus or garlic.\n', textTheme),
                  _TitleText('• Chemical: ', textTheme),
                  _SubtitleText(' Common with certain vitamins or medications.\n', textTheme),
                ],
              ),
            ),
          ),
          Text.rich(TextSpan(children: [
            _SubtitleText(
                'Tracking urine smell helps you spot changes, understand how your cycle, food, or lifestyle affect your bladder, and gives you clear info to share with your doctor.',
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
