import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/ekvi_journeys_module_card.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/ekvi_journeys_course_header.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/ekvi_journeys_course_metadata.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/ekvi_journeys_subtext.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/course_loading_screen.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';

class EkviJourneysCourseScreen extends StatefulWidget {
  final ScreenArguments? arguments;
  final VoidCallback? onPop;

  const EkviJourneysCourseScreen({
    super.key,
    this.arguments,
    this.onPop,
  });

  @override
  State<EkviJourneysCourseScreen> createState() =>
      _EkviJourneysCourseScreenState();
}

class _EkviJourneysCourseScreenState extends State<EkviJourneysCourseScreen> {
  @override
  void initState() {
    super.initState();
    final courseId = widget.arguments?.courseId;
    if (courseId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          await Provider.of<EkviJourneysCourseProvider>(context, listen: false)
              .fetchCourseStructure(courseId);
        } catch (e) {
          // Handle error if needed
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseProv = context.watch<EkviJourneysCourseProvider>();
    final journeysProv = context.watch<EkviJourneysProvider>();

    // Show shimmer loading screen while loading
    if (courseProv.isLoading) {
      return const CourseLoadingScreen();
    }

    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          // Refresh dashboard data when screen is popped
          _refreshDashboardData();
          widget.onPop?.call();
        }
      },
      child: Scaffold(
        body: GradientBackground(
          child: courseProv.error != null
              ? Center(child: Text('Error: ${courseProv.error}'))
              : courseProv.title == null
                  ? const Center(child: Text(''))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EkviJourneysCourseHeader(
                            completionPct: journeysProv
                                .completionPctFor(courseProv.courseId ?? ''),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 32),
                                const EkviJourneysCourseMetadata(),
                                const SizedBox(height: 16),
                                Builder(
                                  builder: (_) {
                                    final ctaType = courseProv
                                        .computePrimaryCta(journeysProv);
                                    final ctaTitle = courseCtaTitle(ctaType);

                                    return CustomButton(
                                      title: ctaTitle,
                                      maxSize: const Size(double.infinity, 48),
                                      onPressed: () async {
                                        await courseProv
                                            .handlePrimaryCta(journeysProv);
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(height: 32),
                                const ModuleCardList(),
                                const SizedBox(height: 32),
                                const EkviJourneysSubtext(
                                    text: "This journey ends here... "),
                                const EkviJourneysSubtext(
                                    text: "but yours doesn't! 🎉"),
                                const SizedBox(height: 32),
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

  void _refreshDashboardData() {
    // Silently refresh dashboard data without showing loading states
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final journeysProvider =
            Provider.of<EkviJourneysProvider>(context, listen: false);
        await Future.wait([
          journeysProvider.fetchLatestJourneys(),
          journeysProvider.fetchCurrentCourseLesson(),
        ]);
      } catch (e) {
        // Silently handle errors
      }
    });
  }
}
