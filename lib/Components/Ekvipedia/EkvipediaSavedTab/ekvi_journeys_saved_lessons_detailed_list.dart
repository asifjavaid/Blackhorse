import 'package:ekvi/Components/Ekvipedia/news_card.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkviJourneysSavedLessonsDetailedList extends StatelessWidget {
  const EkviJourneysSavedLessonsDetailedList({super.key});

  List<dynamic> _getLessonsByType(List<dynamic> lessons, String type) {
    return lessons
        .where(
            (lesson) => lesson.lessonType?.toLowerCase() == type.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysProvider>();
    final savedLessons = provider.savedLessons;
    final textTheme = Theme.of(context).textTheme;

    // Group lessons by type
    final articles = _getLessonsByType(savedLessons, 'rich text');
    final videos = _getLessonsByType(savedLessons, 'video');
    final audio = _getLessonsByType(savedLessons, 'audio');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Articles Section
        if (articles.isNotEmpty) ...[
          const SizedBox(height: 64),
          _buildCategorySection(
            context,
            'Article',
            articles,
            'rich text',
            textTheme,
          ),
        ],

        // Videos Section
        if (videos.isNotEmpty) ...[
          const SizedBox(height: 64),
          _buildCategorySection(
            context,
            'Video',
            videos,
            'video',
            textTheme,
          ),
        ],

        // Audio Section
        if (audio.isNotEmpty) ...[
          const SizedBox(height: 64),
          _buildCategorySection(
            context,
            'Audio',
            audio,
            'audio',
            textTheme,
          ),
        ],
        const SizedBox(height: 64),
      ],
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String title,
    List<dynamic> lessons,
    String lessonType,
    TextTheme textTheme,
  ) {
    final displayLessons = lessons.toList();
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textTheme.displaySmall),
              GestureDetector(
                onTap: () {
                  AppNavigation.navigateTo(
                    AppRoutes.ekvipediaSavedLessonsByType,
                    arguments: ScreenArguments(
                      lessonType: lessonType,
                      categoryTitle: title,
                    ),
                  );
                },
                child: const Text(
                  "see all",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1,
                    shadows: [
                      Shadow(
                        color: AppColors.actionColor600,
                        offset: Offset(0,
                            -2),
                      ),
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    decorationColor: AppColors.actionColor600,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Horizontal Cards List
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayLessons.length,
            itemBuilder: (context, index) {
              final lesson = displayLessons[index];

              return NewsCard(
                index: index,
                width: 200,
                height: 200,
                imagePath: lesson.featuredImageUrl,
                date: title,
                readTime: lesson.lessonDuration,
                title: lesson.title ?? '',
                maxLines: 2,
                isPaid: false,
                onPressed: () {
                  final lessonId = lesson.lessonId;
                  if (lessonId != null) {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRoutes.ekviJourneysLesson,
                      arguments: ScreenArguments(
                        lessonId: lessonId,
                        isCurrentLessonFlow: false,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
