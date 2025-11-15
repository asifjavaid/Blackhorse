import 'package:ekvi/Components/AppUpdater/app_update_banner.dart';
import 'package:ekvi/Components/Dashboard/dashboard_icons_bar.dart';
import 'package:ekvi/Components/Dashboard/feedback_message.dart';
import 'package:ekvi/Components/Dashboard/feel_today.dart';
import 'package:ekvi/Components/Dashboard/get_greeting.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/ekvi_journeys_lesson_card.dart';
import 'package:ekvi/Components/Ekvipedia/latest_events.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/latest_journeys.dart';
import 'package:ekvi/Components/Ekvipedia/latest_news.dart';
import 'package:ekvi/Components/Ekvipedia/news_from_ekvi.dart';
import 'package:ekvi/Components/InAppPurchases/subscribe_billing_issue_banner.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/AppUpdater/app_updater_provider.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Providers/WellnessWeekly/wellness_weekly_provider.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Mood/DashboardMood/dashboard_mood_support_panels.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  late DashboardProvider provider;
  late AppUpdaterProvider updater;
  late EkvipediaProvider ekvipedia;
  late EkviJourneysProvider ekviJourneys;
  late WellnessWeeklyProvider wellnessWeekly;

  @override
  void initState() {
    super.initState();
    provider = context.read<DashboardProvider>();
    updater = context.read<AppUpdaterProvider>();
    ekvipedia = context.read<EkvipediaProvider>();
    ekviJourneys = context.read<EkviJourneysProvider>();
    wellnessWeekly = context.read<WellnessWeeklyProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.callDashboardApi();
      updater.checkForAppUpdate();
      ekvipedia.fetchLatestNews();
      ekvipedia.fetchNewsFromEkvi();
      ekvipedia.fetchLatestEvents();
      ekviJourneys.fetchLatestJourneys();
      ekviJourneys.fetchCurrentCourseLesson();
      wellnessWeekly.checkPopupStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Consumer4<DashboardProvider, EkvipediaProvider,
            EkviJourneysProvider, WellnessWeeklyProvider>(
          builder:
              (context, provider1, provider2, provider3, provider4, child) =>
                  SlidingUpPanel(
            backdropTapClosesPanel: false,
            controller: provider1.panelController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            backdropEnabled: false,
            backdropOpacity: 0.6,
            boxShadow: const [AppThemes.shadowUp],
            renderPanelSheet: true,
            maxHeight: getMoodPanelHeight(provider1.panelType),
            minHeight: 0,
            panel: const DashboardMoodSupportPanelsManager(),
            body: Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SubscribeBillingIssueBanner(),
                        const AppUpdateBanner(),
                        DashboardIconsBar(context: context),
                        const GreetingWidget(),
                        const FeelToday(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: EkviJourneysLessonCard(),
                          ),
                        ),
                        LatestEvents(
                          latestEvents: provider2.latestEvents,
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        LatestNews(
                          latestNews: provider2.latestNews,
                        ),
                        LatestJourneys(
                          journeys: provider3.journeys,
                          // error: provider3.error,
                        ),
                        NewsFromEkvi(
                          newsFromEkvi: provider2.newsFromEkvi,
                        ),
                        // const EkviStore(),
                        const FeedbackMessage(),

                        // Testing button for wellness weekly popup
                        // CustomButton(
                        //   buttonType: ButtonType.primary,
                        //   onPressed: () {
                        //     showDialog(
                        //         context: AppNavigation.currentContext!,
                        //         builder: (BuildContext context) {
                        //           return WellnessWeeklyPopup(
                        //             title: provider4.popupData?.title ?? '',
                        //             message: provider4.popupData?.message ?? '',
                        //             buttonText:
                        //                 provider4.popupData?.buttonText ?? '',
                        //           );
                        //         });
                        //   },
                        //   title: 'View Wellness Weekly',
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double getMoodPanelHeight(DashboardMoodPanelType panel) {
  switch (panel) {
    case DashboardMoodPanelType.tracker:
      return 90.h;
    case DashboardMoodPanelType.roll:
      return 420;
    case DashboardMoodPanelType.bitoff:
      return 444;
    case DashboardMoodPanelType.toughtime:
      return 466;
    case DashboardMoodPanelType.notalone:
      return 510;
    default:
      return 0;
  }
}
