import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_audio_lesson_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_vedio_lesson_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_article_lesson_screen.dart';
import 'package:ekvi/Screens/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/ekvi_journeys_module_completion_screen.dart';
import 'package:ekvi/Widgets/CustomWidgets/lesson_loading_screen.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkviJourneysLessonScreen extends StatefulWidget {
  final ScreenArguments? arguments;

  const EkviJourneysLessonScreen({super.key, this.arguments});

  @override
  State<EkviJourneysLessonScreen> createState() =>
      _EkviJourneysLessonScreenState();
}

class _EkviJourneysLessonScreenState extends State<EkviJourneysLessonScreen> {
  bool _isInitialized = false;
  bool isCurrentLessonFlow = false;

  @override
  void initState() {
    super.initState();

    final args = widget.arguments;
    final moduleId = args?.moduleId;
    final lessonId = args?.lessonId;
    final courseId = args?.courseId;
    final isStartCourseJourney = args?.isStartCourseJourney ?? false;
    final isContinueCourseJourney = args?.isContinueCourseJourney ?? false;
    isCurrentLessonFlow = args?.isCurrentLessonFlow ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeLessonIfNeeded(
        context: context,
        moduleId: moduleId,
        lessonId: lessonId,
        courseId: courseId,
        isCurrentLessonFlow: isCurrentLessonFlow,
        isStartCourseJourney: isStartCourseJourney,
        isContinueCourseJourney: isContinueCourseJourney,
        onError: _showError,
        onComplete: () {
          if (!mounted) return;
          setState(() => _isInitialized = true);
        },
      );
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysProvider>();
    final args = widget.arguments;
    final moduleId = args?.moduleId;
    final lessonId = args?.lessonId;

    // Show loading screen while loading or not initialized
    if (!_isInitialized || provider.isLoading) {
      return const LessonLoadingScreen();
    }

    final lessonType = provider.lesson?.lessonType;

    final screenArgs = ScreenArguments(
      moduleId: moduleId,
      lessonId: lessonId,
      isCurrentLessonFlow: isCurrentLessonFlow,
    );

    return KeyedSubtree(
      key: ValueKey(lessonType),
      child: _getLessonScreen(lessonType, screenArgs),
    );
  }

  Widget _getLessonScreen(String? lessonType, ScreenArguments args) {
    final provider = context.watch<EkviJourneysProvider>();

    // Check if we have a module completion response
    if (provider.moduleCompletionResponse != null) {
      return const EkviJourneysModuleCompletionScreen();
    }

    // Otherwise show the appropriate lesson type
    switch (lessonType) {
      case 'audio':
        return const EkviJourneysAudioLessonScreen();
      case 'video':
        return const EkviJourneysVedioLessonScreen();
      case 'rich text':
        return const EkviJourneysArticleLessonScreen();
      default:
        return const Scaffold(
            body: GradientBackground(child: SizedBox.shrink()));
    }
  }
}

Future<void> initializeLessonIfNeeded({
  required BuildContext context,
  required String? moduleId,
  required String? lessonId,
  required String? courseId,
  required bool isCurrentLessonFlow,
  required bool isStartCourseJourney,
  required bool isContinueCourseJourney,
  required VoidCallback onComplete,
  required void Function(String message) onError,
}) async {
  try {
    final provider = context.read<EkviJourneysProvider>();

    if (isStartCourseJourney && courseId != null) {
      // Use start course journey API
      await provider.startCourseJourney(courseId);
    } else if (isContinueCourseJourney && courseId != null) {
      // Use continue course journey API
      await provider.continueCourseJourney(courseId);
    } else if (isCurrentLessonFlow) {
      // Load current course lesson for CTA button flow
      await provider.fetchCurrentCourseLesson();
    } else if (lessonId != null) {
      // Load specific lesson by ID
      await provider.fetchLessonById(lessonId);
    } else if (moduleId != null) {
      // Load lesson by module ID - use sequential=false for direct access
      await provider.fetchLesson(moduleId, sequential: false);
    }
  } catch (e) {
    onError('Failed to load lesson.');
    return;
  } finally {
    onComplete();
  }
}
