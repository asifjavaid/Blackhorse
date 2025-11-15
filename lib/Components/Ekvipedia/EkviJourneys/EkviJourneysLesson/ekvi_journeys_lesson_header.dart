import 'package:ekvi/Models/EkviJourneys/current_course_lesson.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_video_player_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EkviJourneysLessonHeader extends StatelessWidget {
  final LessonStructure? lesson;
  final CurrentCourseLesson? currentLesson;

  const EkviJourneysLessonHeader({
    super.key,
    this.lesson,
    this.currentLesson,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final journeysProvider = context.read<EkviJourneysProvider>();
    final courseProvider = context.read<EkviJourneysCourseProvider>();

    final int lessonOrder =
        lesson?.lessonOrder ?? currentLesson?.lessonOrder ?? 0;
    final String totalLessons =
        (lesson?.totalLessons ?? currentLesson?.totalLessons ?? '').toString();
    final String moduleId = (lesson?.moduleID ?? currentLesson?.moduleID ?? '');
    final safeTop = MediaQuery.of(context).padding.top;

    return Container(
      height: 44,
      margin: EdgeInsets.only(
          top: (safeTop > 0) ? safeTop + 8 : 16,
          left: lessonOrder != 1 ? 16 : 42,
          right: 16),
      child: Row(
        children: [
          if (lessonOrder > 1)
            GestureDetector(
              onTap: () async {
                if (moduleId.isEmpty) return;
                await journeysProvider.fetchPreviousLesson(moduleId,
                    currentLessonOrder: lessonOrder, sequential: true);
              },
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SvgPicture.asset(
                    '${AppConstant.assetIcons}backIcon.svg',
                    height: 18,
                    width: 18,
                  ),
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: Text('Lesson $lessonOrder of $totalLessons',
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  )),
            ),
          ),
          InkWell(
            onTap: () async {
              // Dispose video player before navigating back
              final videoProvider = context.read<EkviJourneysVideoPlayerProvider>();
              videoProvider.disposePlayer();
              
              courseProvider.refreshCourseStructure();
              journeysProvider.refreshAllData();
              AppNavigation.goBack();
            },
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    '${AppConstant.assetIcons}crossIcon.svg',
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
