import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/user_pain_killer_model.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Notifications/notification_preferences_screen.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/assets.dart';

class YourPillsScreen extends StatefulWidget {
  const YourPillsScreen({super.key});

  @override
  YourPillsScreenState createState() => YourPillsScreenState();
}

class YourPillsScreenState extends State<YourPillsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchPills();
  }

  Future<void> _fetchPills() async {
    final provider = Provider.of<PainKillersVaultProvider>(context, listen: false);
    await provider.fetchPainkillers();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PainKillersVaultProvider>(context);
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _fetchPills,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  BackNavigation(title: "Your pills", callback: () => AppNavigation.goBack()),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const SizedBox(height: 18),
                              SvgPicture.asset(Assets.customiconsPill1, color: AppColors.actionColor600, height: 18, width: 18,),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Painkillers",
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.neutralColor600, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 4,
                                width: 86,
                                decoration: BoxDecoration(
                                  color: AppColors.actionColor600,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                        CustomButton(
                            title: "Add new painkiller",
                            onPressed: () {
                              AppNavigation.navigateTo(AppRoutes.painKillerAddScreen);
                            }),
                        const SizedBox(height: 24),
                        if (provider.currentPills.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [AppThemes.shadowDown],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Current Painkillers", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600)),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.currentPills.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final pill = provider.currentPills[index];
                                    return PillListItem(pill: pill);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (provider.previousPills.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [AppThemes.shadowDown],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Previous Painkillers",
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: AppColors.neutralColor600,
                                        )),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.previousPills.length,
                                  itemBuilder: (context, index) {
                                    final pill = provider.previousPills[index];
                                    return PillListItem(pill: pill);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (provider.currentPills.isEmpty && provider.previousPills.isEmpty)
                          Center(
                              child: Text(
                            "No painkillers found. Please add a new one.",
                            style: Theme.of(context).textTheme.bodySmall,
                          )),
                      ],
                    ),
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

class PillListItem extends StatelessWidget {
  final UserPainKillerResponseModel pill;

  const PillListItem({super.key, required this.pill});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PainKillersVaultProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      minVerticalPadding: 0,
      dense: true,
      leading: HelperFunctions.giveBackgroundToIcon(
        width: 36,
        height: 36,
        SvgPicture.asset(Assets.customiconsPill1, color: AppColors.actionColor600, height: 18, width: 18,),
        bgColor: AppColors.actionColor400,
      ),
      title: Text(
        pill.name,
        style: textTheme.bodySmall,
      ),
      subtitle: Text(
        "${pill.dosage}${pill.dosageEntity}",
        style: textTheme.labelMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          pill.isTrigger
              ? Text(
                  '⚠️',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                )
              : const SizedBox(),
          const SizedBox(width: 16),
          CustomSwitch(
            value: pill.isVisibleInTracker,
            onChanged: (bool newValue) {
              provider.toggleVisibility(pill, newValue);
            },
          ),
          const SizedBox(width: 16),
          IconButton(
              icon: SvgPicture.asset(Assets.customiconsArrowRight, color: AppColors.actionColor600, height: 18, width: 18,),
              onPressed: () => AppNavigation.navigateTo(AppRoutes.painKillerEditScreen, arguments: ScreenArguments(painkiller: pill))),
        ],
      ),
      onTap: () {
        AppNavigation.navigateTo(AppRoutes.painKillerEditScreen, arguments: ScreenArguments(painkiller: pill));
      },
    );
  }
}
