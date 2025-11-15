import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_audio_player.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_lesson_header.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/ekvi_journeys_bottom_sheet.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/ekvi_journeys_save_button.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/CustomWidgets/lesson_loading_screen.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EkviJourneysAudioLessonScreen extends StatefulWidget {
  const EkviJourneysAudioLessonScreen({super.key});

  @override
  State<EkviJourneysAudioLessonScreen> createState() => _EkviJourneysAudioLessonScreenState();
}

class _EkviJourneysAudioLessonScreenState extends State<EkviJourneysAudioLessonScreen> {
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
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GradientBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSectionAudioPlayer(),
                EkviJourneysAudioPlayer(lesson: lesson),
                EkviJourneysBottomSheetOverlay(lesson: lesson),              
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSectionAudioPlayer() {
    final lesson = context.watch<EkviJourneysProvider>().lesson;

    return Column(
      children: [
        EkviJourneysLessonHeader(lesson: lesson),
        SizedBox(height: 1.h),
        // Image section
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: lesson?.featuredImageUrl != null &&
                      lesson!.featuredImageUrl!.isNotEmpty
                  ? Image.network(
                      lesson.featuredImageUrl!,
                      height: 24.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Image.asset(
                          '${AppConstant.assetImages}sample.png',
                          height: 24.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      '${AppConstant.assetImages}sample.png',
                      height: 24.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            const Positioned(
              top: 12,
              right: 12,
              child: EkviJourneysSaveButton(),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            lesson?.title ?? '',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
