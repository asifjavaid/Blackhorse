import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/BodyPain/eating.dart';
import 'package:ekvi/Screens/BodyPain/exercise.dart';
import 'package:ekvi/Screens/BodyPain/existing.dart';
import 'package:ekvi/Screens/BodyPain/intimacy.dart';
import 'package:ekvi/Screens/BodyPain/sleep.dart';
import 'package:ekvi/Screens/BodyPain/toilet.dart';
import 'package:ekvi/Screens/BodyPain/travel.dart';
import 'package:ekvi/Screens/BodyPain/work.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyPainEvent extends StatefulWidget {
  const BodyPainEvent({
    super.key,
  });

  @override
  State<BodyPainEvent> createState() => _BodyPainEventState();
}

class _BodyPainEventState extends State<BodyPainEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Consumer<DailyTrackerProvider>(
            builder: (context, value, child) => SingleChildScrollView(
                child: Column(children: [
              BackNavigation(title: getEventTitle(value), callback: () => AppNavigation.goBack()),
              if (value.selectedPainEventCategory == PainEventsCategory.Existing) ...[const EventExisting()],
              if (value.selectedPainEventCategory == PainEventsCategory.Eating) ...[const EventEating()],
              if (value.selectedPainEventCategory == PainEventsCategory.Toilet) ...[const EventToilet()],
              if (value.selectedPainEventCategory == PainEventsCategory.Travel) ...[const EventTravel()],
              if (value.selectedPainEventCategory == PainEventsCategory.Exercise) ...[const EventExercise()],
              if (value.selectedPainEventCategory == PainEventsCategory.Sleep) ...[const EventSleep()],
              if (value.selectedPainEventCategory == PainEventsCategory.Intimacy) ...[const EventIntimacy()],
              if (value.selectedPainEventCategory == PainEventsCategory.Work) ...[const EventWork()],
            ])),
          ),
        ),
      ),
    );
  }

  String getEventTitle(DailyTrackerProvider provider) {
    return provider.selectedPainEventCategory.toString().split(".")[1].replaceAll("_", " ");
  }
}
