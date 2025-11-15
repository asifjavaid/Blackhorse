import 'package:ekvi/Models/EkviJourneys/get_all_saved_lessons.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';

class EkviJourneysSavedLessonsList extends StatelessWidget {
  final List<GetAllSavedLessons> lessons;

  const EkviJourneysSavedLessonsList({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sortedLessons = [...lessons]..sort((a, b) {
        final aDate = DateTime.tryParse(a.savedAt ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = DateTime.tryParse(b.savedAt ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sortedLessons.length,
        itemBuilder: (context, index) {
          final lesson = sortedLessons[index];

          return GestureDetector(
            onTap: () {
              final moduleId = lesson.moduleId;
              if (moduleId != null) {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoutes.ekviJourneysLesson,
                  arguments: ScreenArguments(
                    moduleId: moduleId,
                    isCurrentLessonFlow: false,
                  ),
                );
              }
            },
            child: Container(
              width: 200,
              margin: EdgeInsets.only(right: index == sortedLessons.length - 1 ? 0 : 16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [AppThemes.shadowDown],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: lesson.featuredImageUrl != null
                          ? Image.network(
                              lesson.featuredImageUrl!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/sample.png',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
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
                          Text(
                            lesson.title ?? '',
                            style: textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            _formatDate(lesson.savedAt),
                            style: textTheme.labelSmall?.copyWith(
                              color: AppColors.neutralColor500,
                            ),
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

  String _formatDate(String? isoString) {
    if (isoString == null) return '';
    try {
      final date = DateTime.parse(isoString);
      return '${_monthName(date.month)} ${date.day}, ${date.year}';
    } catch (_) {
      return '';
    }
  }

  String _monthName(int month) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month - 1];
  }
}
