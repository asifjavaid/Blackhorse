import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Models/EditProfle/user_profile_model.dart';
import 'package:ekvi/Models/Notifications/ekvipedia_notification_model.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/Notifications/notifications_service.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Utils/helpers/helper_functions.dart';

class NotificationsProvider extends ChangeNotifier {
  final List<String> notificationCategories = [
    "Subscription renewal",
    "Trial period ending",
    "Daily tracking"
  ];
  DateTime selectedTime = DateTime.now();

  bool showTimeControl = false;
  final List<bool> notificationCategoriesEnabled = List.filled(3, false);
  final PanelController panelController = PanelController();
  final UserManager _userManager = UserManager();
  UserProfileModel? _profileModel;
  String? errorMessage;

  Future<void> getNotificationPreferences() async {
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
            showTimeControl = prefs.dailyTrackingReminder ?? false;
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

  void toggleBottomSheet() {
    panelController.isPanelOpen ? panelController.close() : panelController.open();
    notifyListeners();
  }

  void setSelectedTime(DateTime time) {
    selectedTime = time;
    notifyListeners();
  }

  void updateValue(int index, bool value) {
    if (index >= 0 && index < notificationCategoriesEnabled.length) {
      notificationCategoriesEnabled[index] = value;
      if(index == 2)
        showTimeControl = value;

      notifyListeners();
    }
  }

  void _updateCategoriesEnabledFromPreferences(NotificationPreferences prefs) {
    notificationCategoriesEnabled[0] = prefs.subscriptionRenewal ?? false;
    notificationCategoriesEnabled[1] = prefs.trialPeriodEnding ?? false;
    notificationCategoriesEnabled[2] = prefs.dailyTrackingReminder ?? false;
    String date = HelperFunctions.formatDate(DateTime.now());
    selectedTime = prefs.dailyTrackingReminderTime != null ? HelperFunctions.combineDateTime(date, prefs.dailyTrackingReminderTime!) : DateTime.now();
  }

  NotificationPreferences _createPreferencesFromCategoriesEnabled() {
    return NotificationPreferences(
      subscriptionRenewal: notificationCategoriesEnabled[0],
      trialPeriodEnding: notificationCategoriesEnabled[1],
      dailyTrackingReminder: notificationCategoriesEnabled[2],
      dailyTrackingReminderTime: HelperFunctions.formatTime(selectedTime),
    );
  }
}
