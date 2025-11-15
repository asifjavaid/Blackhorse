import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/latest_journeys.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/expand_horizon.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/pick_up_where_you_left_off.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_lesson_card.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkvipediaJourneysTab extends StatefulWidget {
  const EkvipediaJourneysTab({super.key});

  @override
  State<EkvipediaJourneysTab> createState() => _EkvipediaJourneysTabState();
}

class _EkvipediaJourneysTabState extends State<EkvipediaJourneysTab> {
  late EkviJourneysProvider ekviJourneys;

  @override
  void initState() {
    super.initState();
    ekviJourneys = context.read<EkviJourneysProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        ekviJourneys.fetchRecentlyAccessed(limit: 3),
        ekviJourneys.fetchLatestJourneys(),
        ekviJourneys.fetchExpandHorizon(),
        ekviJourneys.fetchCurrentCourseLesson(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EkviJourneysProvider>(
      builder: (context, provider, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: EkviJourneysLessonCard(),
              ),
            ),
            PickUpWhereYouLeftOff(
              journeys: provider.recentlyAccessedJourneys,
            ),
            LatestJourneys(
              journeys: provider.journeys,
            ),
            ExpandHorizon(
              journeys: provider.expandHorizonJourneys,
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
