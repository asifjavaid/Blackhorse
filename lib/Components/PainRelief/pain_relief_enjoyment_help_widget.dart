import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PainReliefEnjoymentHelpWidget extends StatelessWidget {
  const PainReliefEnjoymentHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headingStyle = textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600);
    final bodyStyle = textTheme.bodySmall?.copyWith(color: AppColors.neutralColor600, height: 1.6);
    final bulletTitleStyle = textTheme.titleSmall?.copyWith(color: AppColors.neutralColor600, fontWeight: FontWeight.w700);

    final painReliefItems = <Map<String, String>>[
      {'title': 'None', 'body': 'No relief at all'},
      {'title': 'Mild', 'body': 'Just a little better'},
      {'title': 'Moderate', 'body': ' Somewhat better'},
      {'title': 'Good', 'body': 'Feeling much better'},
      {'title': 'Excellent', 'body': 'Pain-free!'},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating your pain relief',
            style: headingStyle?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            'Tracking how well the pain relief eased your pain can help you and your healthcare provider understand what works best for you. After doing or using your pain relief, describe how well it worked using the scale:',
            style: bodyStyle,
          ),
          const SizedBox(height: 16),
          ...painReliefItems.map((item) {
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
          const SizedBox(height: 24),
          Text(
            'Why this matters',
            style: headingStyle?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'By capturing how well your pain relief techniques work, you’re building a clear picture of what helps and what doesn’t. This information is invaluable for you and your healthcare provider to make the best decisions about your treatment and keep you on track to feeling your best.',
            style: bodyStyle,
          ),
          const SizedBox(height: 16),
          Text(
            'Remember, tracking your experience is key to understanding your pain management journey. Let’s make sure you’re getting the relief you deserve!',
            style: bodyStyle,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
