import 'package:ekvi/Screens/Ekvipedia/EkvipediaTabs/ekvipedia_articles_tab.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaTabs/ekvipedia_journeys_tab.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaTabs/ekvipedia_saved_tab.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EkvipediaScreen extends StatelessWidget {
  const EkvipediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GradientBackground(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackNavigation(
                  title: "Ekvipedia",
                  hideBackButton: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Material(
                    color: Colors.transparent,
                    child: TabBar(
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 2.5,
                          color: AppColors.actionColor600,
                        ),
                        insets: EdgeInsets.symmetric(horizontal: -20),
                      ),
                      labelColor: AppColors.neutralColor600,
                      unselectedLabelColor: Colors.grey,
                      dividerColor: Colors.transparent,
                      tabs: [
                        CustomTab(
                          iconPath: '${AppConstant.assetIcons}articleIcon.svg',
                          label: 'Articles',
                          textTheme: textTheme,
                        ),
                        CustomTab(
                          iconPath: '${AppConstant.assetIcons}moduleIcon.svg',
                          label: 'Journeys',
                          textTheme: textTheme,
                        ),
                        CustomTab(
                          iconPath: '${AppConstant.assetIcons}saveIcon.svg',
                          label: 'Saved',
                          textTheme: textTheme,
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      EkvipediaArticlesTab(),
                      EkvipediaJourneysTab(),
                      EkvipediaSavedTab(),
                    ],
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

class CustomTab extends StatelessWidget {
  final String iconPath;
  final String label;
  final TextTheme textTheme;

  const CustomTab({
    super.key,
    required this.iconPath,
    required this.label,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isModuleIcon = iconPath.contains('moduleIcon.svg');
    final iconColor = isModuleIcon ? AppColors.actionColor600 : null;
    return Tab(
      child: SizedBox(
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 20,
              fit: BoxFit.contain,
              color: iconColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
