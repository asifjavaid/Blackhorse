import 'package:ekvi/Providers/DailyTracker/YourWellBeing/your_well_being_provider.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Pain-Relief/pain_relief_practices_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Movement/movement_practices_screen.dart';
import 'package:ekvi/Screens/DailyTrackerCategory/PanelScreens/Selfcare/selfcare_practices_screen.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';

import '../../../generated/assets.dart';

class YourWellBeingScreen extends StatelessWidget {
  const YourWellBeingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              BackNavigation(
                title: "Your wellbeing",
                callback: () => AppNavigation.goBack(),
              ),

              // tabs row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Consumer<YourWellBeingProvider>(
                  builder: (_, wb, __) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _TabButton(
                          icon: Assets.customiconsTraining,
                          label: "Movement",
                          selected: wb.selectedTab == WellbeingTab.movement,
                          onTap: () => wb.selectTab(WellbeingTab.movement),
                        ),
                        const SizedBox(width: 24),
                        _TabButton(
                          icon: Assets.customiconsFollicular,
                          label: "Self-care",
                          selected: wb.selectedTab == WellbeingTab.selfcare,
                          onTap: () => wb.selectTab(WellbeingTab.selfcare),
                        ),
                        const SizedBox(width: 24),
                        _TabButton(
                          icon: Assets.customiconsPainRelief,
                          label: "Pain relief",
                          selected: wb.selectedTab == WellbeingTab.painRelief,
                          onTap: () => wb.selectTab(WellbeingTab.painRelief),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // content
              const Expanded(
                child: _TabContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, color: AppColors.actionColor600, height: 24, width: 24,),
          const SizedBox(height: 8),
          Text(label, style: textTheme.labelSmall),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: selected ? AppColors.actionColor600 : const Color.fromARGB(0, 83, 68, 68),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent();

  @override
  Widget build(BuildContext context) {
    final wb = context.watch<YourWellBeingProvider>();
    switch (wb.selectedTab) {
      case WellbeingTab.selfcare:
        return const SelfcarePracticesScreen();
      case WellbeingTab.painRelief:
        return const PainReliefPracticesScreen();
      case WellbeingTab.movement:
      default:
        return const MovementPracticesScreen();
    }
  }
}
