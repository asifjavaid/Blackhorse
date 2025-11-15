import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_categories.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BodyPain extends StatefulWidget {
  const BodyPain({
    super.key,
  });

  @override
  State<BodyPain> createState() => _BodyPainState();
}

class _BodyPainState extends State<BodyPain> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Consumer<DailyTrackerProvider>(
        builder: (context, value, child) => GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BackNavigation(
                    title: "Body Pain",
                    callback: () => AppNavigation.goBack(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Text(
                          "What did you do when experiencing the ${value.categoriesData.bodyPain.selectedBodyParts.length > 1 ? value.categoriesData.bodyPain.selectedBodyParts[0].category1 : value.categoriesData.bodyPain.selectedBodyParts[0].nameForUser} pain?",
                          textAlign: TextAlign.left,
                          style: textTheme.headlineSmall),
                      SizedBox(
                        height: 2.h,
                      ),
                      GridCategories(
                          elevated: false,
                          options: value.eventsAndThingsIdo,
                          width: 100.w,
                          height: 25.h,
                          indicesWithLargeContent: const [0, 1, 2, 3, 4, 5, 6, 7],
                          backgroundColor: Colors.transparent,
                          callback: (String title) {
                            AmplitudeBodyPainActivity(activity: title, bodyParts: value.categoriesData.bodyPain.selectedBodyParts).log();
                            value.handleSelectedPainEvent(title);
                          }),
                    ]),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
