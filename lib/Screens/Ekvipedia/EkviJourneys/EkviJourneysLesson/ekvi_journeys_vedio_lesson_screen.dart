import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_lesson_header.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_vedio_player.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/ekvi_journeys_bottom_sheet.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Widgets/CustomWidgets/lesson_loading_screen.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkviJourneysVedioLessonScreen extends StatefulWidget {
  const EkviJourneysVedioLessonScreen({super.key});

  @override
  State<EkviJourneysVedioLessonScreen> createState() => _EkviJourneysVedioLessonScreenState();
}

class _EkviJourneysVedioLessonScreenState extends State<EkviJourneysVedioLessonScreen> {
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
            child: CustomScrollView(
              slivers: [
                // Header is regular box content
                SliverToBoxAdapter(
                  child: EkviJourneysLessonHeader(lesson: lesson),
                ),

                // Fill the remaining viewport with: [Video (expands)] + [Bottom Sheet]
                SliverFillRemaining(
                  hasScrollBody: false, // <- lets children expand to fill viewport height
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Video takes all remaining space here
                      Expanded(
                        child: EkviJourneysVideoPlayer(lesson: lesson),
                      ),
                      EkviJourneysBottomSheetOverlay(lesson: lesson),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
