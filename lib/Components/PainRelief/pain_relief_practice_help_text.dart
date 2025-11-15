import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PainReliefPracticeHelpText extends StatelessWidget {
  const PainReliefPracticeHelpText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bulletStyle = textTheme.titleSmall?.copyWith(
      color: AppColors.neutralColor600,
      fontWeight: FontWeight.w700,
    );
    final bodyStyle = textTheme.bodySmall?.copyWith(
      color: AppColors.neutralColor600,
      height: 1.6,
    );

    final items = <Map<String, String>>[
      {
        'title': 'Heat/Cold Therapy',
        'body': 'Soothes pain with warmth or cooling. Think: hot bath, heat patch, ice pack.',
      },
      {
        'title': 'TENS/Devices',
        'body': 'Uses tools to interrupt pain signals or relax muscles. Think: TENS machine, pelvic stim.',
      },
      {
        'title': 'Positions',
        'body': 'Positions that ease pressure or cramping. Think: child’s pose, knees up, lying down.',
      },
      {
        'title': 'Manual Therapies',
        'body': 'Physical release through hands-on care. Think: massage, myofascial release, physio.',
      },
      {
        'title': 'Topical Applications',
        'body': 'Things you apply to ease pain. Think: castor oil, CBD balm, essential oils.',
      },
      {
        'title': 'Alternative Therapies',
        'body': 'Body-based or energy-based treatments. Think: acupuncture, reflexology, guided pain meditation.',
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add or edit your pain relief practice',
            style: textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600),
          ),
          const SizedBox(height: 24),
          Text(
            'Find what eases the pain. Here’s how to fill out each field:',
            style: bodyStyle,
          ),
          const SizedBox(height: 16),

          // Match SelfcareDescriptionWidget section formatting
          _buildSection(
            'Emoji',
            'Pick an emoji that captures the kind of relief this practice gives. Maybe it’s ♨️ for heat therapy, 🛌 for lying down, or ✋ for belly massage. Emojis make your list easy to scan and remind you what’s in your toolkit.',
            textTheme,
          ),
          _buildSection(
            'Name',
            'Give your practice a short, clear name you’ll recognize when pain hits. Think “Hot water bottle,” “Fetal position,” or “TENS machine.” This is what you’ll tap when tracking, so make it easy to spot in the moment.',
            textTheme,
          ),
          _buildSection(
            'Type',
            'Choose the type of relief this practice offers. This helps Ekvi learn what’s helping you manage pain and what your body tends to respond to. You can choose from:',
            textTheme,
          ),

          const SizedBox(height: 12),

          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' • ', style: bulletStyle),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: '${item['title']}: ', style: bulletStyle),
                          TextSpan(text: item['body'], style: bodyStyle),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          Text(
            '\nPain relief isn’t one-size-fits-all. What helps today might shift tomorrow. This tracker is your space to tune in, try things, and learn what brings you even a little relief 💜',
            style: bodyStyle,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Same section structure as SelfcareDescriptionWidget
  Widget _buildSection(String title, String subtitle, TextTheme textTheme) {
    final titleStyle = textTheme.titleSmall?.copyWith(
      color: AppColors.neutralColor600,
      fontWeight: FontWeight.w700,
    );
    final bodyStyle = textTheme.bodySmall?.copyWith(
      color: AppColors.neutralColor600,
      height: 1.6,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 4),
        Text(subtitle, style: bodyStyle),
        const SizedBox(height: 16),
      ],
    );
  }
}
