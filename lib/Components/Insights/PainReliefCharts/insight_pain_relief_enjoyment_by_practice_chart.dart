import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_tags_count.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';

class EnjoymentByPainReliefPracticeCard extends StatefulWidget {
  const EnjoymentByPainReliefPracticeCard({super.key});

  @override
  State<EnjoymentByPainReliefPracticeCard> createState() =>
      _EnjoymentByPainReliefPracticeCardState();
}

class _EnjoymentByPainReliefPracticeCardState
    extends State<EnjoymentByPainReliefPracticeCard> {
  bool _expanded = false;

  String _labelFor(double v) {
    if (v >= 9) return 'Excellent';
    if (v >= 7) return 'Good';
    if (v >= 5) return 'Moderate';
    if (v >= 3) return 'Mild';
    if (v >= 1) return 'None';
    return 'Draining';
  }

  Color _barColor(double v, BuildContext context) {
    if (v >= 8) return AppColors.successColor500;
    if (v >= 4) return AppColors.accentColorTwo500;
    return AppColors.errorColor500;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<PainReliefProvider>(builder: (_, prov, __) {
      final data = prov.painReliefTagsCounts.graphData;
      if (!prov.painReliefTagsCounts.isDataLoaded ||
          data == null ||
          data.isEmpty) {
        return const SizedBox.shrink();
      }

      final rawList = data.first.practicesData ?? [];
      final practices = List<PracticesData>.from(rawList)
        ..sort((a, b) =>
            (b.averageEnjoyment ?? 0).compareTo(a.averageEnjoyment ?? 0));
      final visible = _expanded ? practices : practices.take(3).toList();

      return Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [AppThemes.shadowDown],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text('Effectiveness by practice',
                          style: textTheme.bodyMedium)),
                  GestureDetector(
                    onTap: () => HelperFunctions.openCustomBottomSheet(context,
                        content: _helpPanel(), height: 750),
                    child: SvgPicture.asset(
                      height: 24,
                      width: 24,
                      "${AppConstant.assetIcons}info.svg",
                      semanticsLabel: 'Cycle Calendar Info',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...visible.map((pd) {
                final avg = pd.averageEnjoyment ?? 0.0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(pd.emoji ?? '',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 4),
                          Text(pd.practiceName ?? '',
                              style: textTheme.titleSmall),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(avg.toStringAsFixed(1),
                                style: textTheme.labelSmall),
                          ),
                          const Spacer(),
                          Text(_labelFor(avg),
                              style: textTheme.labelMedium!
                                  .copyWith(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          minHeight: 12,
                          value: avg / 10,
                          backgroundColor: AppColors.neutralColor200,
                          valueColor:
                              AlwaysStoppedAnimation(_barColor(avg, context)),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              if (practices.length > 3)
                GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Text(
                    _expanded ? 'See less' : 'See more',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppColors.actionColor600,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.actionColor600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

Widget _helpPanel() {
  final textTheme = Theme.of(AppNavigation.currentContext!).textTheme;
  final titleStyle = textTheme.titleSmall?.copyWith(
    color: AppColors.neutralColor600,
    fontWeight: FontWeight.w700,
  );
  final bodyStyle = textTheme.bodySmall?.copyWith(
    color: AppColors.neutralColor600,
    height: 1.6,
  );
  final bulletStyle = titleStyle;

  final items = <Map<String, String>>[
    {'title': '1–2: None', 'body': 'No noticeable relief'},
    {'title': '3–4: Mild', 'body': 'A little better'},
    {'title': '5–6: Moderate', 'body': 'Helped take the edge off'},
    {'title': '7–8: Good', 'body': 'Made a real difference'},
    {'title': '9–10: Excellent', 'body': 'This really works for you'},
  ];

  Widget section(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(text, style: bodyStyle),
      );

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What helped most?',
          style: textTheme.headlineSmall
              ?.copyWith(color: AppColors.neutralColor600),
        ),
        const SizedBox(height: 24),

        // body paragraphs
        section(
            'This section shows how effective your pain relief practices have been based on what you tracked.'),
        section(
            'Each bar represents a practice you’ve used, along with its average effectiveness score (from 1 to 10). The higher the number, the more relief you felt.'),

        const SizedBox(height: 4),
        Text('Here’s how to read it:', style: titleStyle),
        const SizedBox(height: 8),

        // bullets
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' • ', style: bulletStyle),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '${item['title']} – ', style: bulletStyle),
                        TextSpan(text: item['body'], style: bodyStyle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
        section(
            'The colored bars make it easy to spot what’s supporting you most — whether it’s heat, a certain position, or a hands-on therapy.'),
        section(
            'Tracking these moments helps you learn what your body responds to. And when it’s time to speak with a doctor or physio, you’ll have real data to back up your experience.'),
        section(
            'You’re not just logging pain. You’re learning what brings relief — and that’s powerful.'),
      ],
    ),
  );
}
