import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EkvipediaSavedLessonsByTypeScreen extends StatefulWidget {
  const EkvipediaSavedLessonsByTypeScreen({super.key});

  @override
  State<EkvipediaSavedLessonsByTypeScreen> createState() =>
      _EkvipediaSavedLessonsByTypeScreenState();
}

class _EkvipediaSavedLessonsByTypeScreenState
    extends State<EkvipediaSavedLessonsByTypeScreen> {
  late EkviJourneysProvider ekviJourneys;

  @override
  void initState() {
    super.initState();
    ekviJourneys = context.read<EkviJourneysProvider>();
  }

  String _formatLessonType(String? rawType) {
    switch (rawType?.toLowerCase()) {
      case 'audio':
        return 'Audio';
      case 'video':
        return 'Video';
      case 'rich text':
        return 'Article';
      default:
        return rawType ?? '';
    }
  }

  List<dynamic> _getLessonsByType(List<dynamic> lessons, String type) {
    return lessons
        .where(
            (lesson) => lesson.lessonType?.toLowerCase() == type.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments?;
    final lessonType = args?.lessonType ?? '';
    final categoryTitle = args?.categoryTitle ?? _formatLessonType(lessonType);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              BackNavigation(
                title: 'Saved $categoryTitle',
                callback: () => AppNavigation.goBack(),
              ),
              Expanded(
                child: Consumer<EkviJourneysProvider>(
                  builder: (context, provider, child) {
                    final savedLessons = provider.savedLessons;
                    final filteredLessons =
                        _getLessonsByType(savedLessons, lessonType);

                    if (filteredLessons.isEmpty) {
                      // FIX: This centers correctly because it now fills the remaining space
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.bookmark_border,
                                size: 64,
                                color: AppColors.neutralColor400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No saved $categoryTitle yet',
                                textAlign: TextAlign.center,
                                style: textTheme.titleMedium?.copyWith(
                                  color: AppColors.neutralColor500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Save some $categoryTitle to see them here',
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.neutralColor400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredLessons.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final lesson = filteredLessons[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [AppThemes.shadowDown],
                          ),
                          height: 102,
                          child: Material(
                            color: AppColors.neutralColor100,
                            borderRadius: BorderRadius.circular(12),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                final lessonId = lesson.lessonId;
                                if (lessonId != null) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(
                                    AppRoutes.ekviJourneysLesson,
                                    arguments: ScreenArguments(
                                      lessonId: lessonId,
                                      isCurrentLessonFlow: false,
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                              left: Radius.circular(12)),
                                      child: Image(
                                        image: lesson.featuredImageUrl != null
                                            ? NetworkImage(
                                                lesson.featuredImageUrl!)
                                            : const AssetImage(
                                                    'assets/images/sample.png')
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: 6,
                                            runSpacing: 4,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              const Icon(
                                                AppCustomIcons.info,
                                                size: 14,
                                                color:
                                                    AppColors.neutralColor500,
                                              ),
                                              Text(
                                                _formatLessonType(
                                                    lesson.lessonType),
                                                style: textTheme.labelMedium
                                                    ?.copyWith(
                                                  color:
                                                      AppColors.neutralColor500,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              SvgPicture.asset(
                                                '${AppConstant.assetIcons}clock.svg',
                                                width: 14,
                                                height: 14,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  AppColors.neutralColor500,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 120),
                                                child: Text(
                                                  lesson.lessonDuration ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textTheme.labelMedium
                                                      ?.copyWith(
                                                    color: AppColors
                                                        .neutralColor500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            lesson.title ?? '',
                                            style: textTheme.titleSmall,
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
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
