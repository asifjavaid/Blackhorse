import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Models/EditProfle/user_profile_model.dart';
import 'package:ekvi/Models/Notifications/ekvipedia_notification_model.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/Notifications/notifications_service.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ConsentProvider extends ChangeNotifier {
  final List<String> consentMessages = [
    "I consent to Ekvi processing the health data I choose to share with the app, so that the app can provide me with personalized information and guidance.",
    "I consent to my anonymized health data being used for women's health research to help improve understanding and care for all women.",
    "I would like to receive information, tips and updates from Ekvi via email."
  ];

  bool _wantsConsent1 = false;
  bool get wantsConsent1 => _wantsConsent1;

  bool _wantsConsent2 = false;
  bool get wantsConsent2 => _wantsConsent2;

  bool _wantsConsent3 = false;
  bool get wantsConsent3 => _wantsConsent3;

  final PanelController panelController = PanelController();
  final UserManager _userManager = UserManager();
  UserProfileModel? _profileModel;
  String? errorMessage;

  void toggleBottomSheet() {
    panelController.isPanelOpen ? panelController.close() : panelController.open();
    notifyListeners();
  }

  void setWantsConsent1(bool? value, {bool notify = true}) {
    _wantsConsent1 = value ?? false;
    if (notify) notifyListeners();
    // updateNotificationPreferences();
  }

  void setWantsConsent2(bool? value, {bool notify = true}) {
    _wantsConsent2 = value ?? false;
    if (notify) notifyListeners();
    // updateNotificationPreferences();
  }

  void setWantsConsent3(bool? value, {bool notify = true}) {
    _wantsConsent3 = value ?? false;
    if (notify) notifyListeners();
    // updateNotificationPreferences();
  }

  Future<void> getConsentPreferences() async {
    final id = _userManager.userId;
    if (id == null) {
      errorMessage = 'User ID is null';
      notifyListeners();
      return;
    }

    CustomLoading.showLoadingIndicator();

    try {
      final res = await NotificationsService.fetchNotificationApi(id);
      res.fold(
        (error) {
          errorMessage = error.toString();
          notifyListeners();
        },
        (data) {
          _profileModel = data;
          final prefs = _profileModel?.notificationPreferences;
          if (prefs != null) {
            _updateCategoriesEnabledFromPreferences(prefs);
          }
          notifyListeners();
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      CustomLoading.hideLoadingIndicator();
    }
  }

  Future<void> updateNotificationPreferences() async {
    final id = _userManager.userId;
    final email = _userManager.email;
    if (id == null || email == null) {
      errorMessage = 'User ID or email is null';
      notifyListeners();
      return;
    }

    CustomLoading.showLoadingIndicator();

    try {
      final notifies = UserNotificationPreferences(
        email: email,
        notificationPreferences: _createPreferencesFromCategoriesEnabled(),
      );

      final res = await NotificationsService.updateNotificationApi(notifies, id);

      res.fold(
        (error) {
          errorMessage = error.toString();
          notifyListeners();
        },
        (data) {
          _profileModel = data;
          final prefs = _profileModel?.notificationPreferences;
          if (prefs != null) {
            _updateCategoriesEnabledFromPreferences(prefs);
          }
          // Navigate to the desired screen after successful update
          final context = AppNavigation.currentContext;
          if (context != null) {
            Provider.of<SideNavManagerProvider>(context, listen: false).onSelected(MenuItems(context).bottomNavManager);
          }
          notifyListeners();
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      CustomLoading.hideLoadingIndicator();
    }
  }

  void _updateCategoriesEnabledFromPreferences(NotificationPreferences prefs) {
    _wantsConsent1 = prefs.processDataConsent ?? false;
    _wantsConsent2 = prefs.shareDataConsent ?? false;
    _wantsConsent3 = prefs.marketingConsent ?? false;
  }

  NotificationPreferences _createPreferencesFromCategoriesEnabled() {
    return NotificationPreferences(
      processDataConsent: wantsConsent1,
      shareDataConsent: wantsConsent2,
      marketingConsent: wantsConsent3,
    );
  }
}
