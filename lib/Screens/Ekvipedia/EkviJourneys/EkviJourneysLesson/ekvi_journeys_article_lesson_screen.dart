import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_lesson_content_display.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/lesson_reference_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Widgets/CustomWidgets/lesson_loading_screen.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_lesson_header.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_article_screen_button.dart';

class EkviJourneysArticleLessonScreen extends StatefulWidget {
  const EkviJourneysArticleLessonScreen({super.key});

  @override
  State<EkviJourneysArticleLessonScreen> createState() =>
      _EkviJourneysArticleLessonScreenState();
}

class _EkviJourneysArticleLessonScreenState
    extends State<EkviJourneysArticleLessonScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysProvider>();
    final lesson = provider.lesson;

    if (provider.isLoading) {
      return const LessonLoadingScreen();
    }

    if (lesson == null) {
      return const Scaffold(
        body: GradientBackground(
          child: Center(child: Text("Lesson not found.")),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EkviJourneysLessonHeader(lesson: lesson),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      children: [
                        EkviJourneysLessonContentDisplay(lesson: lesson),
                        LessonReferencePreview(
                            lessonReferences: lesson.lessonReferences,
                            lesson: lesson),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const EkviJourneysArticleScreenButton(),
      ),
    );
  }
}
