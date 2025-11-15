import 'package:ekvi/Models/Dashboard/menu_item.dart';
import 'package:ekvi/Providers/LocaleProvider/locale_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/BottomNavManager/bottom_nav_manager.dart';
import 'package:ekvi/Screens/EditProfile/edit_profile.dart';
import 'package:ekvi/Screens/Intercom/intercom.dart';
import 'package:ekvi/Screens/Notifications/notification_preferences_screen.dart';
import 'package:ekvi/Screens/Reminders/reminders.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SideNavManagerProvider with ChangeNotifier {
  String _languageCode = "en";
  BuildContext context = AppNavigation.currentContext!;

  late MenuItemModel currentItem;
  late MenuItems menuItemsProvider;
  late List<MenuItemModel> menuItems;
  PanelController panelController = PanelController();

  SideNavManagerProvider() {
    _initLanguageCode();
    _initVariables();
  }

  String get languageCode => _languageCode;

  // Initialize language code from SharedPreferences
  Future<void> _initLanguageCode() async {
    String? savedLanguageCode =
        await SharedPreferencesHelper.getStringPrefValue(key: 'languageCode');
    if (savedLanguageCode != null) {
      _languageCode = savedLanguageCode;
      notifyListeners();
    }
  }

  _initVariables() {
    updateMenuItems(context);
    currentItem = menuItems.first;
    notifyListeners(); // Ensure that you notify listeners once the current item is set
  }

  void updateLanguageCode(String newLang) {
    _languageCode = newLang;
    notifyListeners();
  }

  void updateMenuItems(BuildContext cont) {
    menuItemsProvider = MenuItems(cont);
    menuItems = [
      menuItemsProvider.bottomNavManager,
      menuItemsProvider.profile,
      menuItemsProvider.notifications,
      menuItemsProvider.reminders,
      menuItemsProvider.supportfeedback,
      // menuItemsProvider.language(_languageCode == "en" ? "English" : "Norwegian"),
    ];
  }

  void saveSelectedLanguage(BuildContext context) async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    await localeProvider.setLocale(Locale(_languageCode));
    panelController.close();
    notifyListeners();
  }

  void onSelected(item, {bool notify = true}) {
    currentItem = item;
    if (notify) {
      notifyListeners();
    }
  }

  void togglePanel() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
    notifyListeners();
  }

  Widget getScreen() {
    switch (currentItem.id) {
      case "bottomNavManager":
        return const BottomNavManager();
      case "notification":
        return const NotificationsPreferencesScreen();
      case "reminders":
        return Reminders(
          screenArguments: ScreenArguments(isSideNavRoute: true),
        );
      case "supportfeedback":
        return const IntercomScreen();
      case "profile":
        return const EditProfileScreen();
      default:
        return const BottomNavManager();
    }
  }
}

class MenuItems {
  final BuildContext context;

  MenuItems(this.context);

  MenuItemModel get profile => MenuItemModel(
        "profile",
        AppLocalizations.of(context)!.menu_profile,
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.actionColor600,
        ),
      );

  MenuItemModel get bottomNavManager => MenuItemModel(
        "bottomNavManager",
        AppLocalizations.of(context)!.menu_dashboard,
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.actionColor600,
        ),
      );

  MenuItemModel get notifications => MenuItemModel(
        "notification",
        AppLocalizations.of(context)!.notifications,
        const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.actionColor600,
        ),
      );

  MenuItemModel get reminders => MenuItemModel(
        "reminders",
        AppLocalizations.of(context)!.menu_reminders,
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.actionColor600,
        ),
      );

  MenuItemModel get supportfeedback => MenuItemModel(
        "supportfeedback",
        AppLocalizations.of(context)!.menu_supportFeedback,
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.actionColor600,
        ),
      );
}
