import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MovementIntensityHelpWidget extends StatelessWidget {
  const MovementIntensityHelpWidget({super.key});

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
            'Why rate intensity?',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  "Understanding the intensity of your workouts helps you stay in tune with your body’s needs and limits. Some days call for gentle movement, while others might feel right for pushing your boundaries. By tracking intensity, you can balance your energy levels, avoid burnout, and align your movement with your fitness goals and menstrual cycle. Here’s a quick explanation:\n",
                  textTheme),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text.rich(
              TextSpan(
                children: [
                  _TitleText('• Very Light: ', textTheme),
                  _SubtitleText("This level feels like a casual stroll or\n\t\tgentle stretching – easy and effortless.\n", textTheme),
                  _TitleText('• Light: ', textTheme),
                  _SubtitleText("Think of a brisk walk or a slow bike ride –\n\t\tenough to break a sweat but still comfortable.\n", textTheme),
                  _TitleText('• Moderate: ', textTheme),
                  _SubtitleText("A pace that's noticeably quicker,\n\t\tlike jogging or cycling at a steady pace –\n\t\tfeeling energized but not exhausted.\n", textTheme),
                  _TitleText('• Hard: ', textTheme),
                  _SubtitleText("Pushing yourself with faster movements\n\t\tor heavier weights – feeling challenged but\n\t\tstill able to continue.\n", textTheme),
                  _TitleText('• Very Hard: ', textTheme),
                  _SubtitleText("Maximum effort – sprinting or\n\t\tlifting heavy weights, pushing your limits to\n\t\tthe max.\n", textTheme),
                ],
              ),
            ),
          ),
          Text.rich(TextSpan(children: [
            _SubtitleText(
                "Rating intensity also helps you spot patterns, like when high-intensity workouts energize you or when lighter sessions feel more restorative. It’s not about how hard you can go — "
                "it’s about finding the right level of challenge for you and your journey.",
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
