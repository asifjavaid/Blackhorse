import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HeadacheTypeHelpWidget extends StatelessWidget {
  const HeadacheTypeHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Not sure what type of headache you’re having?',
            style: textTheme.headlineSmall?.copyWith(
                color: AppColors.neutralColor600,
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          const SizedBox(height: 16),
          Text(
            "That’s completely normal. Many women don’t have a clear diagnosis, and you don’t need one to benefit from tracking.\n\n"
            "Start by asking:\n"
            " • Where does it hurt?\n"
            " • What did it feel like?\n"
            " • Did anything trigger it?\n"
            " • How long did it last?\n\n"
            "If it feels familiar (like your usual migraine or stress headache), go ahead and log it. If not, just describe the experience using the other fields. The app can still help you track and understand your patterns.\n\n"
            "Here’s a quick guide to some common headache types:\n",
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.neutralColor600,
              height: 1.6,
              fontSize: 14.56,
            ),
          ),
          _buildBulletItem(
            textTheme,
            title: "Tension:",
            description:
                "A dull, tight pressure — like a band around your head or neck.",
          ),
          _buildBulletItem(
            textTheme,
            title: "Migraine:",
            description:
                "Often one-sided, throbbing, with nausea or light sensitivity.",
          ),
          _buildBulletItem(
            textTheme,
            title: "Aura:",
            description:
                "Visual changes (flashing lights, zig-zags) that come before a migraine.",
          ),
          _buildBulletItem(
            textTheme,
            title: "Hormonal:",
            description:
                "Headaches linked to your cycle, pregnancy, or menopause.",
          ),
          _buildBulletItem(
            textTheme,
            title: "Cluster:",
            description:
                "Intense pain around one eye, often at the same time of day.",
          ),
          _buildBulletItem(
            textTheme,
            title: "Sinus:",
            description:
                "Pressure in your cheeks, forehead, or around your eyes, often with congestion.",
          ),
          _buildBulletItem(
            textTheme,
            title: "Rebound:",
            description: "Headaches that come back when painkillers wear off.",
          ),
          _buildBulletItem(
            textTheme,
            title: "Thunderclap:",
            description:
                "Sudden and severe — peaks within seconds. Needs medical attention.",
          ),
          const SizedBox(height: 16),
          Text(
            "Over time, you’ll start to see patterns. And if you choose to share this with a healthcare provider, the details you’ve logged will be much more helpful than just picking a label.",
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.neutralColor600,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildBulletItem(TextTheme textTheme,
      {required String title, required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " • ",
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.neutralColor600,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: "$title ",
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
