import 'package:ekvi/Components/Insights/BleedingCharts/bleeding_charts.dart';
import 'package:ekvi/Components/Insights/BloatingCharts/bloating_charts.dart';
import 'package:ekvi/Components/Insights/BowelMovements/bowel_movements_charts.dart';
import 'package:ekvi/Components/Insights/BrainFogCharts/brain_fog_charts.dart';
import 'package:ekvi/Components/Insights/EnergyCharts/energy_charts.dart';
import 'package:ekvi/Components/Insights/FatigueCharts/fatigue_charts.dart';
import 'package:ekvi/Components/Insights/HeadacheCharts/headache_charts.dart';
import 'package:ekvi/Components/Insights/MoodCharts/mood_charts.dart';
import 'package:ekvi/Components/Insights/NauseaCharts/nausea_charts.dart';
import 'package:ekvi/Components/Insights/PainCharts/pain_charts.dart';
import 'package:ekvi/Components/Insights/PainReliefCharts/pain_relief_charts.dart';
import 'package:ekvi/Components/Insights/PainkillerCharts/painkiller_charts.dart';
import 'package:ekvi/Components/Insights/SelfcareCharts/selfcare_charts.dart';
import 'package:ekvi/Components/Insights/StressCharts/stress_charts.dart';
import 'package:ekvi/Components/Insights/example_data_banner.dart';
import 'package:ekvi/Components/Insights/insights_feedback_banner.dart';
import 'package:ekvi/Components/Insights/MovementCharts/movement_chart.dart';
import 'package:ekvi/Components/Insights/symptom_time_selection.dart';
import 'package:ekvi/Components/Insights/unlock_stories_panel_content.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Providers/userProvider/free_user_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Components/Insights/UrinationCharts/urination_charts.dart';

class InsightsScreen extends StatefulWidget {
  final ScreenArguments? arguments;

  const InsightsScreen({super.key, this.arguments});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  final PanelController _panelController = PanelController();
  late FreeUserProvider provider;
  @override
  void initState() {
    super.initState();

    provider = Provider.of<FreeUserProvider>(context, listen: false);
    provider.resetValues();
    // Delay the panel sliding up animation when the screen is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _panelController.animatePanelToPosition(
          0.3, // Change this to the desired height (0.0 to 1.0)
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  // Function to handle swipe left to right gesture
  void _onHorizontalSwipe(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx > 0) {
      provider.resetValuesWithNotify();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsightsSymptomTimeSelectionProvider>(
        builder: (context, value, child) => GradientBackground(
          child: SafeArea(
            child: GestureDetector(
              onHorizontalDragEnd: _onHorizontalSwipe, // Detect swipe gesture
              child: SlidingUpPanel(
                controller: _panelController,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                backdropEnabled: false,
                renderPanelSheet: true,
                minHeight: UserManager().isPremium ? 0 : 150,
                maxHeight: UserManager().isPremium ? 0 : 150,
                panel: const UnlockStoriesPanelContent(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildInsightsHeader(context),
                        if (!UserManager().isPremium)
                          const ExampleDataBanner(
                            title: "Example Data",
                            description:
                                "You’re seeing example data in the graphs below because you’re on the free plan. Upgrade to Ekvi Empower to unlock your personalized insights and get a clear picture of your symptom patterns.",
                          ),
                        const SymptomTimeSelection(),
                        _getInsightsChartsForSymptom(value.selectedSymptom),
                        const InsightsFeedbackBanner(),
                        SizedBox(
                          height: UserManager().isPremium ? 168 : 320,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildInsightsHeader(BuildContext context) {
    return Column(
      children: [
        widget.arguments?.cycleHistoryOpenedFromBottomnav ?? false
            ? BackNavigation(
                title: AppLocalizations.of(context)!.insights,
                hideBackButton: true,
              )
            : BackNavigation(
                title: AppLocalizations.of(context)!.insights,
                callback: () => AppNavigation.goBack(),
              ),
      ],
    );
  }

  Widget _getInsightsChartsForSymptom(String symptom) {
    switch (symptom) {
      case "Pain":
        return const PainCharts();
      case "Bleeding":
        return const BleedingCharts();
      case "Mood":
        return const MoodCharts();
      case "Stress":
        return const StressCharts();
      case "Energy":
        return const EnergyCharts();
      case "Nausea":
        return const NauseaCharts();
      case "Fatigue":
        return const FatigueCharts();
      case "Bloating":
        return const BloatingCharts();
      case "Brain fog":
        return const BrainFogCharts();
      case "Bowel movement":
        return const BowelMovementsCharts();
      case "Urination":
        return const UrinationCharts();
      case "Headache":
        return const HeadacheCharts();
      case "Painkillers":
        return const PainkillerCharts();
      case "Movement":
        return const MovementChart();
      case "Self-care":
        return const SelfcareCharts();
      case "Pain relief":
        return const PainReliefCharts();
      default:
        return const SizedBox.shrink();
    }
  }
}
