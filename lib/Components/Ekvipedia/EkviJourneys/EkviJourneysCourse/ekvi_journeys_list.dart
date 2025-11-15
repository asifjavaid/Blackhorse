import 'package:ekvi/Models/EkviJourneys/journeys.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';

class EkviJourneysList extends StatelessWidget {
  final List<Journeys> journeys;

  const EkviJourneysList({
    super.key,
    required this.journeys,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isUserPremium = context.select<EkviJourneysProvider, bool>((p) => p.isUserPremium);

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: journeys.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final journey = journeys[index];

          final isPremiumContent = (journey.accessType ?? '').toLowerCase() == 'premium';
          final isLocked = isPremiumContent && !isUserPremium;

          return GestureDetector(
            onTap: () {
              AppNavigation.navigateTo(
                AppRoutes.ekviJourneysCourse,
                arguments: ScreenArguments(courseId: journey.courseId),
              );
            },
            child: Container(
              width: 200,
              margin: EdgeInsets.only(right: index == journeys.length - 1 ? 0 : 16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [AppThemes.shadowDown],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: (journey.imageUrl != null && journey.imageUrl!.isNotEmpty)
                              ? Image.network(
                                  journey.imageUrl!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/sample.png',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/sample.png',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: isLocked
                              ? const PremiumIconWidget()
                              : Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor400,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Text(
                                    (journey.completionPct ?? 0) == 0 ? "Not started" : "${journey.completionPct}%",
                                    style: textTheme.labelSmall?.copyWith(
                                      color: AppColors.neutralColor600,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                '${AppConstant.assetIcons}moduleIcon.svg',
                                width: 14,
                                height: 14,
                                colorFilter: const ColorFilter.mode(AppColors.neutralColor500, BlendMode.srcIn),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${journey.totalModules ?? 0} modules",
                                style: textTheme.labelSmall?.copyWith(
                                  color: AppColors.neutralColor500,
                                ),
                              ),
                              const SizedBox(width: 12),
                              SvgPicture.asset(
                                '${AppConstant.assetIcons}clock.svg',
                                width: 14,
                                height: 14,
                                colorFilter: const ColorFilter.mode(AppColors.neutralColor500, BlendMode.srcIn),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${journey.totalDuration ?? 0} mins",
                                style: textTheme.labelMedium?.copyWith(
                                  color: AppColors.neutralColor500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            journey.title ?? '',
                            style: textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
