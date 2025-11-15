// lib/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/module_card_list.dart
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModuleCardList extends StatelessWidget {
  const ModuleCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<EkviJourneysCourseProvider>();
    final modules = courseProvider.modules;
    final fallbackImage = courseProvider.imageUrl ?? '';
    final titleFallback = courseProvider.title ?? '';

    final courseAccessType = (courseProvider.accessType ?? '').toLowerCase();
    final isUserPremium = context.select<EkviJourneysProvider, bool>(
      (p) => p.isUserPremium,
    );

    final isCourseLocked = courseAccessType == 'premium' && !isUserPremium;

    return Column(
      children: List.generate(modules.length, (index) {
        final module = modules[index];
        final isLeftAligned = index % 2 == 0;
        final moduleId = module['moduleId'] as String? ?? '';
        final title = (module['title'] as String?)?.trim();
        final featuredImage = module['featuredImageUrl'] as String? ?? '';
        final order = module['moduleOrder']?.toString() ?? '';
        final completionPct = module['completionPct']?.toString() ?? '0';

        return ModuleCard(
          isLeftAligned: isLeftAligned,
          moduleId: moduleId,
          title: title?.isNotEmpty == true ? title! : titleFallback,
          featuredImage:
              featuredImage.isNotEmpty ? featuredImage : fallbackImage,
          order: order,
          completionPct: completionPct,
          isLocked: isCourseLocked,
          courseId: courseProvider.courseId,
        );
      }),
    );
  }
}

class ModuleCard extends StatelessWidget {
  final bool isLeftAligned;
  final String moduleId;
  final String title;
  final String featuredImage;
  final String order;
  final String completionPct;
  final bool isLocked;
  final String? courseId;

  const ModuleCard({
    super.key,
    required this.isLeftAligned,
    required this.moduleId,
    required this.title,
    required this.featuredImage,
    required this.order,
    required this.completionPct,
    required this.isLocked,
    this.courseId,
  });

  double _parsePct(String s) {
    try {
      return double.parse(s);
    } catch (_) {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final pct = _parsePct(completionPct);
    final isUnstarted = pct <= 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        mainAxisAlignment:
            isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              if (isLocked) {
                // special case: we get back to this screen instead of going to dashboard (Home)
                AppNavigation.navigateTo(AppRoutes.subscribe,
                    arguments: ScreenArguments(navigationCallback: () {
                  // First refresh the provider to update course access status
                  Provider.of<EkviJourneysProvider>(
                          AppNavigation.currentContext!,
                          listen: false)
                      .refreshAllData();
                  AppNavigation.popUntilAndNavigateTo(
                    AppRoutes.sideNavManager,
                    AppRoutes.ekviJourneysCourse,
                    arguments: ScreenArguments(courseId: courseId),
                  );
                }));
              } else {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoutes.ekviJourneysLesson,
                  arguments: ScreenArguments(
                    moduleId: moduleId,
                    isCurrentLessonFlow: false,
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: HelperFunctions.isTablet(context) ? 546 : 273,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [AppThemes.shadowDown],
              ),
              child: Row(
                children: [
                  // Image + "unstarted" white translucent overlay
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 110,
                          height: 100,
                          child: Image.network(
                            featuredImage,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.neutralColor200,
                            ),
                          ),
                        ),
                        if (isUnstarted)
                          Positioned.fill(
                            child: Container(
                              color: Colors.white.withOpacity(0.55),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 8, top: 8, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Top row: Module tag + lock/pct
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Module $order',
                                style: textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.neutralColor500,
                                ),
                              ),
                              isLocked
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(AppRoutes.subscribe);
                                      },
                                      child: const PremiumIconWidget(
                                        circleWidth: 25,
                                        circleHeight: 25,
                                        iconSize: 12,
                                      ),
                                    )
                                  : (isUnstarted
                                      ? const SizedBox.shrink()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor400,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Text(
                                            '${pct.toStringAsFixed(0)}%',
                                            style:
                                                textTheme.labelSmall?.copyWith(
                                              color: AppColors.neutralColor600,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )),
                            ],
                          ),
                          const SizedBox(height: 0),
                          Text(
                            title,
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutralColor600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
