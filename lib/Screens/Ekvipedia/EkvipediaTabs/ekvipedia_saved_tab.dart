import 'package:ekvi/Components/Ekvipedia/EkvipediaSavedTab/ekvi_journeys_saved_lessons_detailed_list.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkvipediaSavedTab extends StatefulWidget {
  const EkvipediaSavedTab({super.key});

  @override
  State<EkvipediaSavedTab> createState() => _EkvipediaSavedTabState();
}

class _EkvipediaSavedTabState extends State<EkvipediaSavedTab> {
  late EkviJourneysProvider ekviJourneys;

  @override
  void initState() {
    super.initState();
    ekviJourneys = context.read<EkviJourneysProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      CustomLoading.showLoadingIndicator();
      await ekviJourneys.fetchAllSavedLessons();
      CustomLoading.hideLoadingIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EkviJourneysProvider>(
      builder: (context, provider, child) => const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EkviJourneysSavedLessonsDetailedList(),
          ],
        ),
      ),
    );
  }
}
