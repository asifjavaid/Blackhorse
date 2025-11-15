import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EkviJourneysModuleCompletionHeader extends StatelessWidget {
  const EkviJourneysModuleCompletionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final courseProvider = context.read<EkviJourneysCourseProvider>();
    final journeysProvider = context.read<EkviJourneysProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Consumer<EkviJourneysProvider>(
                builder: (context, provider, child) {
                  return GestureDetector(
                    onTap: () async {
                      final moduleCompletion =
                          provider.moduleCompletionResponse;
                      if (moduleCompletion != null) {
                        // Fetch the last lesson of the completed module
                        // Backend will return the last lesson when currentLessonOrder is not provided
                        await provider.fetchPreviousLesson(
                            moduleCompletion.moduleId,
                            sequential: false);
                      } else {
                        AppNavigation.goBack();
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(
                          '${AppConstant.assetIcons}backIcon.svg',
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Module completed',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  courseProvider.refreshCourseStructure();
                  journeysProvider.refreshAllData();
                  AppNavigation.goBack();
                },
                behavior: HitTestBehavior.translucent,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: SvgPicture.asset(
                      '${AppConstant.assetIcons}crossIcon.svg',
                      height: 16,
                      width: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
