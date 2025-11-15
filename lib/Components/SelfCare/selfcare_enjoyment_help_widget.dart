import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SelfcareEnjoymentHelpWidget extends StatelessWidget {
  const SelfcareEnjoymentHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headingStyle = textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600);
    final bodyStyle = textTheme.bodySmall?.copyWith(color: AppColors.neutralColor600, height: 1.6);
    final bulletTitleStyle = textTheme.titleSmall?.copyWith(color: AppColors.neutralColor600, fontWeight: FontWeight.w700);

    final enjoymentItems = <Map<String, String>>[
      {'title': 'Draining', 'body': 'You didn’t enjoy it at all. It felt like a chore.'},
      {'title': 'Meh', 'body': 'It was okay, but not something you’d look forward to.'},
      {'title': 'Okay', 'body': 'Neutral. It neither added to nor took away from your day.'},
      {'title': 'Enjoyable', 'body': 'You liked it and felt good during the practice.'},
      {'title': 'Pure joy', 'body': 'You loved it and felt completely uplifted!'},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Why track your enjoyment?', style: headingStyle),
          const SizedBox(height: 24),
          Text(
            'Tracking how much you enjoy your self-care practices helps you understand what truly resonates with you. Enjoyment is a vital part of making self-care feel rewarding and sustainable, transforming it from a task into a moment of joy and connection with yourself.',
            style: bodyStyle,
          ),
          const SizedBox(height: 16),
          Text(
            'Over time, these ratings can uncover patterns—like which activities leave you feeling refreshed, grounded, or uplifted. Here’s a quick breakdown of the scale:',
            style: bodyStyle,
          ),
          const SizedBox(height: 16),
          ...enjoymentItems.map((item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' • ', style: bulletTitleStyle),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '${item['title']}: ', style: bulletTitleStyle),
                        TextSpan(text: item['body'], style: bodyStyle),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          Text(
            '\nBy reflecting on what brings you joy (and what doesn’t), you can curate a self-care routine that truly nurtures your well-being. Remember, the best self-care is the kind that leaves you smiling inside and out.',
            style: bodyStyle,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
