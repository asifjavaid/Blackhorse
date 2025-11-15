import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/selfcare_tags.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';

class EnjoymentByPracticeCard extends StatefulWidget {
  const EnjoymentByPracticeCard({super.key});

  @override
  EnjoymentByPracticeCardState createState() => EnjoymentByPracticeCardState();
}

class EnjoymentByPracticeCardState extends State<EnjoymentByPracticeCard> {
  bool _expanded = false;

  String _labelFor(double v) {
    if (v >= 9) return 'Pure joy';
    if (v >= 7) return 'Enjoyable';
    if (v >= 5) return 'Okay';
    if (v >= 3) return 'Meh';
    return 'Draining';
  }

  Color _barColor(double v, BuildContext context) {
    if (v >= 8) return AppColors.successColor500;
    if (v >= 4) return AppColors.accentColorTwo500;
    return AppColors.errorColor500;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<SelfcareProvider>(builder: (_, prov, __) {
      final data = prov.selfCareTagsCounts.graphData;
      if (!prov.selfCareTagsCounts.isDataLoaded ||
          data == null ||
          data.isEmpty) {
        return const SizedBox.shrink();
      }
      final rawList = data.first.practicesData ?? [];
      final practices = List<PracticesData>.from(rawList)
        ..sort(
          (a, b) =>
              (b.averageEnjoyment ?? 0).compareTo(a.averageEnjoyment ?? 0),
        );
      final visible = _expanded ? practices : practices.take(3).toList();
      return Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(11),
            boxShadow: const [AppThemes.shadowDown]),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Enjoyment by practice',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => HelperFunctions.openCustomBottomSheet(
                          context,
                          content: _helpPanel(),
                          height: 400),
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
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                avg.toStringAsFixed(1),
                                style: textTheme.labelSmall,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _labelFor(avg),
                              style: textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
            )),
      );
    });
  }
}

Widget _helpPanel() {
  return SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Which practices bring you the most joy?",
          textAlign: TextAlign.start,
          style: Theme.of(AppNavigation.currentContext!)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppColors.neutralColor600)),
      const SizedBox(
        height: 24,
      ),
      RichText(
        text: TextSpan(
          style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
          children: const [
            TextSpan(
              text:
                  "This card shows your average enjoyment for each self-care practice you’ve tracked—like journaling, meditation, cuddles, and more.\n\n",
            ),
            TextSpan(
              text:
                  "It’s based on your own data, so you can see what actually supports you, not just what should.\n\n",
            ),
            TextSpan(
              text:
                  "Use this insight to reflect on what fills your cup and where you might want to give yourself more of what you love 💜✨\n\n",
            ),
          ],
        ),
      ),
    ]),
  );
}
