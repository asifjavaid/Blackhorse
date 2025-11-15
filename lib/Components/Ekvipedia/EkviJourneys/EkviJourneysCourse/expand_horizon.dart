import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/ekvi_journeys_list.dart';
import 'package:ekvi/Models/EkviJourneys/journeys.dart';
import 'package:flutter/material.dart';

class ExpandHorizon extends StatelessWidget {
  final List<Journeys> journeys;

  const ExpandHorizon({
    super.key,
    required this.journeys,
  });

  @override
  Widget build(BuildContext context) {
    if (journeys.isEmpty) {
      return const SizedBox.shrink();
    }

    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 64),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Expand Your Horizon", style: textTheme.displaySmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        EkviJourneysList(journeys: journeys),
      ],
    );
  }
}
