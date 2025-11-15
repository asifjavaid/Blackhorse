import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Mood/DashboardMood/dashboard_mood_tracker.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardMoodSupportPanelRoll extends StatelessWidget {
  const DashboardMoodSupportPanelRoll({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<DashboardProvider>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You’re on a Roll! ",
              style: textTheme.displayLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Your mood is shining bright, and we love to see it! Every positive moment you track helps you understand what lifts you up. Celebrate these wins and keep that good energy flowing 🌈\n\nStay radiant, stay you!",
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 36,
            ),
            CustomButton(
              title: "Track More Symptoms",
              onPressed: () => {value.setBottomNavIndex(2)},
            ),
            const SizedBox(
              height: 36,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardMoodSupportPanelBitOff extends StatelessWidget {
  const DashboardMoodSupportPanelBitOff({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<DashboardProvider>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "We’re Here for You",
              style: textTheme.displayLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "It looks like you’re feeling a bit off, and that’s totally okay. Whether you’re feeling indifferent, insecure, sensitive, apathetic, or just dealing with mood swings, it’s all part of your journey.\n\nUnderstanding these moments can help you navigate them better.",
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 36,
            ),
            CustomButton(
              title: "Track More Symptoms",
              onPressed: () => {value.setBottomNavIndex(2)},
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardMoodSupportPanelToughtTime extends StatelessWidget {
  const DashboardMoodSupportPanelToughtTime({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<DashboardProvider>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "We’re Here for You",
              style: textTheme.displayLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "We see you’re going through a tough time right now. Whether you’re feeling overwhelmed by obsessive thoughts, guilt, fear, self-criticism, anger, anxiety, sadness, or depression, know that it’s okay to feel this way — and you’re not alone.\n\nTracking these emotions is a courageous step toward understanding and managing them.",
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 36,
            ),
            CustomButton(
              title: "Track More Symptoms",
              onPressed: () => {value.setBottomNavIndex(2)},
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardMoodSupportPanelNotAlone extends StatelessWidget {
  const DashboardMoodSupportPanelNotAlone({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<DashboardProvider>(
        builder: (context, value, child) => Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "You’re Not Alone",
                    style: textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "You have indicated that you are having suicidal thoughts. This is not something you should have to carry alone. We strongly recommend seeking help.\n\nPlease contact your doctor's office and ask if they have an available appointment today. If your doctor is not available, we recommend that you call your nearest emergency medical service.",
                    style: textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  CustomButton(
                    title: "Track More Symptoms",
                    onPressed: () => {value.setBottomNavIndex(2)},
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                ],
              ),
            ));
  }
}

class DashboardMoodSupportPanelsManager extends StatelessWidget {
  const DashboardMoodSupportPanelsManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, value, child) => SizedBox(
              child: getMoodPanel(value.panelType),
            ));
  }
}

getMoodPanel(DashboardMoodPanelType panelType) {
  switch (panelType) {
    case DashboardMoodPanelType.tracker:
      return const DashboardMoodTracker();
    case DashboardMoodPanelType.roll:
      return const DashboardMoodSupportPanelRoll();
    case DashboardMoodPanelType.bitoff:
      return const DashboardMoodSupportPanelBitOff();
    case DashboardMoodPanelType.toughtime:
      return const DashboardMoodSupportPanelToughtTime();
    case DashboardMoodPanelType.notalone:
      return const DashboardMoodSupportPanelNotAlone();
    default:
      return const SizedBox.shrink();
  }
}
