import 'package:ekvi/Components/SideNavManager/language_panel.dart';
import 'package:ekvi/Models/Dashboard/menu_item.dart';
import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Providers/LocaleProvider/locale_provider.dart';
import 'package:ekvi/Providers/Login/login_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/CustomWidgets/ekvi_empower.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../generated/assets.dart';

class MenuPage extends StatelessWidget {
  final MenuItemModel currentItem;
  final ValueChanged<MenuItemModel> onSelectedItem;

  const MenuPage(
      {super.key, required this.currentItem, required this.onSelectedItem});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Consumer3<LoginProvider, SideNavManagerProvider,
          SubscriptionProvider>(
        builder: (context, value, value2, value3, child) => SlidingUpPanel(
          backdropTapClosesPanel: true,
          controller: value2.panelController,
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
          backdropEnabled: true,
          backdropOpacity: 0.6,
          renderPanelSheet: true,
          maxHeight: 43.h,
          minHeight: 0,
          panel: const LanguagePanel(),
          body: GradientBackground(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BackNavigation(
                    title: AppLocalizations.of(context)!.menu_settings,
                    callback: () {
                      onSelectedItem(MenuItems(context).bottomNavManager);
                    },
                    startIcon: Assets.customiconsDelete
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!UserManager().isPremium) const EkviEmpower(),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Selector<LocaleProvider, Locale>(
                          selector: (context, provider) => provider.locale,
                          builder: (context, locale, child) {
                            value2.updateMenuItems(context);
                            return buildMenuItems();
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 32),
                    child: GestureDetector(
                      onTap: () => value.handleLogout(),
                      child: Text(AppLocalizations.of(context)!.menu_logout,
                          style: textTheme.bodySmall!
                              .copyWith(color: AppColors.actionColor500)),
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

  Widget buildMenuItems() => Consumer<SideNavManagerProvider>(
        builder: (context, value, child) => ListView(
          shrinkWrap: true,
          children: value.menuItems.sublist(1).asMap().entries.map((item) {
            return ListTile(
              title: Text(item.value.title,
                  style: Theme.of(AppNavigation.currentContext!)
                      .textTheme
                      .bodyMedium),
              onTap: () => onSelectedItem(item.value),
              trailing: item.value.trailing,
            );
          }).toList(),
        ),
      );
}
