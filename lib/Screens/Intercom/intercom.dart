import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class IntercomScreen extends StatefulWidget {
  final ScreenArguments? arguments;
  const IntercomScreen({super.key, this.arguments});

  @override
  State<IntercomScreen> createState() => _IntercomScreenState();
}

class _IntercomScreenState extends State<IntercomScreen> {
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildBackNavigation(
                  widget.arguments?.feedbackOpenedFromBottomnav, context),
              _buildCard(
                title: localizations.support,
                subtitle: localizations.messageOurExperts,
                trailingIcon: const Icon(
                  AppCustomIcons.question,
                  size: 16,
                  color: AppColors.actionColor600,
                ),
                onTap: () async {
                  await Intercom.instance.displayMessenger();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              _buildCard(
                  title: localizations.helpCenter,
                  subtitle: localizations.faqGuidesLegal,
                  trailingIcon: const Icon(
                    AppCustomIcons.info,
                    size: 16,
                    color: AppColors.actionColor600,
                  ),
                  onTap: () => AppNavigation.navigateTo(AppRoutes.faqs)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackNavigation(
      bool? feedbackOpenedFromBottomnav, BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(
        AppNavigation.currentContext!,
        listen: false);

    return feedbackOpenedFromBottomnav ?? false
        ? BackNavigation(
            title: localizations.ekviFeedbackSupport,
            hideBackButton: true,
          )
        : BackNavigation(
            title: localizations.ekviFeedbackSupport,
            callback: () {
              sideNavManagerProvider.onSelected(
                  MenuItems(AppNavigation.currentContext!).bottomNavManager);
            });
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required Icon trailingIcon,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.whiteColor,
        ),
        child: ListTile(
          minVerticalPadding: 24,
          shape: const Border(
            bottom: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              HelperFunctions.giveBackgroundToIcon(trailingIcon,
                  bgColor: AppColors.actionColor400, height: 36, width: 36),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
