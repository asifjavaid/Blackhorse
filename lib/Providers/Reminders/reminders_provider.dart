import 'dart:async';
import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Models/Reminders/MedicationReminder/Request/medicine_reminder_request.dart';
import 'package:ekvi/Models/Reminders/PeriodReminder/period_reminder_model.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Services/Reminders/reminders_service.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/local_notification_helper.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../generated/assets.dart';

class RemindersProvider extends ChangeNotifier {
  List<ContraceptionReminderModel> contraceptionReminders = [];
  List<MedicineReminderRequest> medicationReminders = [];
  var dashboardProvider = Provider.of<DashboardProvider>(AppNavigation.currentContext!, listen: false);
  PanelController panelController = PanelController();
  List<String> toBeDeletedContraceptionReminderIds = [];
  List<String> toBeDeletedMedicationReminderIds = [];
  String toBeDeletedPeriodReminderId = "";
  int toBeDeleteRemindersCount = 0;
  bool isDeleteMode = false;
  String medicineReminderText = "Hey gorgeous! It’s time to take your medicine 💜";

  Future<void> handleDeleteReminderData() async {
    AppNavigation.goBack();
    CustomLoading.showLoadingIndicator();
    if (toBeDeletedContraceptionReminderIds.isNotEmpty) {
      final result = await RemindersService.deteleBatchContraceptionReminders(toBeDeletedContraceptionReminderIds);
      result.fold((l) {}, (r) {
        for (var element in toBeDeletedContraceptionReminderIds) {
          RemindersHelper.deleteReminderID(element);
        }
        toBeDeletedContraceptionReminderIds = [];
        toBeDeleteRemindersCount = 0;
        notifyListeners();
      });
    }
    if (toBeDeletedMedicationReminderIds.isNotEmpty) {
      final result = await RemindersService.deleteBatchMedicationReminders(toBeDeletedMedicationReminderIds);
      result.fold((l) {}, (r) {
        for (var element in toBeDeletedMedicationReminderIds) {
          RemindersHelper.deleteReminderID(element);
          LocalNotificationsHelper().cancelNotification(element.hashCode);
        }
        toBeDeletedMedicationReminderIds = [];
        toBeDeleteRemindersCount = 0;

        notifyListeners();
      });
    }

    if (toBeDeletedPeriodReminderId.isNotEmpty) {
      final result = await RemindersService.deleteBatchPeriodReminder([toBeDeletedPeriodReminderId]);
      result.fold((l) {}, (r) {
        RemindersHelper.deleteReminderID(toBeDeletedPeriodReminderId);
        LocalNotificationsHelper().cancelNotification(toBeDeletedPeriodReminderId.hashCode);
        toBeDeletedPeriodReminderId = "";
        toBeDeleteRemindersCount = 0;
        notifyListeners();
      });
    }
    revertDeleteMode(togglePanelRequired: true);
    getAllReminders();
    notifyListeners();
    CustomLoading.hideLoadingIndicator();
  }

  void revertDeleteMode({bool togglePanelRequired = true}) {
    isDeleteMode = false;
    toBeDeleteRemindersCount = 0;
    toBeDeletedContraceptionReminderIds.clear();
    toBeDeletedMedicationReminderIds.clear();
    toBeDeletedPeriodReminderId = "";
    if (togglePanelRequired) {
      togglePanel();
      notifyListeners();
    }
  }

  void togglePanel() {
    panelController.isPanelOpen ? panelController.close() : panelController.open();
    notifyListeners();
  }

  void toggleDeleteMode({String? contraceptionId, String? medicationId, String? periodId}) {
    isDeleteMode = !isDeleteMode;
    togglePanel();
    if (contraceptionId != null || medicationId != null || periodId != null) {
      handleReminderDelete(contraceptionId: contraceptionId, medicationId: medicationId, periodId: periodId);
    }
    notifyListeners();
  }

  void handleReminderDelete({String? contraceptionId, String? medicationId, String? periodId}) {
    if (contraceptionId != null) {
      bool contains = toBeDeletedContraceptionReminderIds.contains(contraceptionId);
      if (contains) {
        toBeDeletedContraceptionReminderIds.remove(contraceptionId);
        toBeDeleteRemindersCount -= 1;
      } else {
        toBeDeletedContraceptionReminderIds.add(contraceptionId);
        toBeDeleteRemindersCount += 1;
      }
    } else if (medicationId != null) {
      bool contains = toBeDeletedMedicationReminderIds.contains(medicationId);
      if (contains) {
        toBeDeletedMedicationReminderIds.remove(medicationId);
        toBeDeleteRemindersCount -= 1;
      } else {
        toBeDeletedMedicationReminderIds.add(medicationId);
        toBeDeleteRemindersCount += 1;
      }
    } else if (periodId != null) {
      bool isSame = toBeDeletedPeriodReminderId == periodId;
      if (isSame) {
        toBeDeletedPeriodReminderId = "";
        toBeDeleteRemindersCount -= 1;
      } else {
        toBeDeletedPeriodReminderId = periodId;
        toBeDeleteRemindersCount += 1;
      }
    }
    if (toBeDeletedContraceptionReminderIds.isEmpty && toBeDeletedMedicationReminderIds.isEmpty && toBeDeletedPeriodReminderId.isEmpty) {
      toggleDeleteMode();
      notifyListeners();
    }
    notifyListeners();
  }

  // get all types of reminders, contraception, medication, period
  void getAllReminders({bool? showLoader}) async {
    if (showLoader ?? true) CustomLoading.showLoadingIndicator();
    final contraceptionRemindersFuture = handleGetAllContraceptionReminders();
    final medicationRemindersFuture = handleGeltAllMedicationReminders();
    await Future.wait([contraceptionRemindersFuture, medicationRemindersFuture]);
    if (showLoader ?? true) CustomLoading.hideLoadingIndicator();
  }

  // get and schedule all types of reminders simultaneously

  void clearAndGetAllRemindersAndSchedule() async {
    // clear all scheudled notifications and reminders ids in preferences
    await LocalNotificationsHelper().cancelAllNotifications();
    await RemindersHelper.deleteAllReminderIDs();
    // get all reminders
    getAllReminders(showLoader: false);

    // iterate over reminders and schedule them, alongside setting up preferences
    for (var element in contraceptionReminders) {
      if (element.active!) {
        scheduleReminder(contraception: element);
      }
      RemindersHelper.updateReminderID(element.contraceptionType!, element.id!);
    }
    for (var element in medicationReminders) {
      if (element.active!) {
        scheduleReminder(medication: element);
      }
    }
  }

  // clear reminders
  void clearReminders() {
    contraceptionReminders.clear();
    medicationReminders.clear();
  }

  void scheduleReminder({ContraceptionReminderModel? contraception, MedicineReminderRequest? medication, PeriodReminderModel? period}) async {
    try {
      if (contraception != null) {
        DateTime dateAndTime = HelperFunctions.combineDateTime(contraception.date!, contraception.time!);
        // Schedule if reminder is scheduled first time, re-schedule if already scheduled
        await LocalNotificationsHelper()
            .scheduleNotification(id: contraception.id.hashCode, title: contraception.contraceptionType, body: contraception.text, scheduledNotificationDateTime: dateAndTime);
        // await HelperFunctions.showNotification(AppNavigation.currentContext!, "Successfully scheduled reminder");
      } else if (medication != null) {
        await LocalNotificationsHelper().scheduleNotification(
            id: medication.id.hashCode,
            title: RemindersHelper.medicationReminderString,
            body: medicineReminderText.replaceAll("medicine", medication.medicineName!),
            scheduledNotificationDateTime: HelperFunctions.combineDateTime(medication.medicineDailyReminderDate!, medication.medicineDailyReminderTime!),
            isDaily: medication.isDailyReminderOn! ? true : null);
        // await HelperFunctions.showNotification(AppNavigation.currentContext!, "Successfully scheduled reminder");
      } else if (period != null) {
        DateTime dateAndTime = DateTime.parse(period.periodStartDate!);
        await LocalNotificationsHelper().scheduleNotification(id: period.id.hashCode, title: RemindersHelper.periodReminderString, body: period.message, scheduledNotificationDateTime: dateAndTime);
        // await HelperFunctions.showNotification(AppNavigation.currentContext!, "Successfully scheduled reminder");
      }
    } catch (e) {
      // HelperFunctions.showNotification(AppNavigation.currentContext!, "Something went wrong while scheduling the reminder");
    }
  }

  // Contraception reminders
  Future<bool> handleCreateOrUpdateContraceptionReminder({required ContraceptionReminderModel data, bool create = true, String? id}) async {
    CustomLoading.showLoadingIndicator();

    final completer = Completer<bool>();
    final result = create
        ? await RemindersService.createOrUpdateContraceptionReminder(
            request: data,
          )
        : await RemindersService.createOrUpdateContraceptionReminder(request: data, create: false, id: id!);

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        CustomLoading.hideLoadingIndicator();
        completer.complete(false);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        await RemindersHelper.updateReminderID(r.contraceptionType!, r.id!);

        final localNotificationsHelper = LocalNotificationsHelper();
        // Check if the notification is disabled
        if (!r.active!) {
          // if the notification has been scheduled aready, cancel it
          bool ifNotificationScheduled = await localNotificationsHelper.checkIfNotificationScheduled(r.id!.hashCode);
          if (ifNotificationScheduled) {
            await localNotificationsHelper.cancelNotification(r.id!.hashCode);
            // await HelperFunctions.showNotification(AppNavigation.currentContext!, "Success! Contraception Reminder disabled.");
          }
          // else do not schedule it
          else {
            // await HelperFunctions.showNotification(AppNavigation.currentContext!, "Success! Contraception Reminderis saved but disabled.");
          }
        }
        // if notification is active, schedule/reschedule it
        else {
          scheduleReminder(contraception: r);
        }
        var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(AppNavigation.currentContext!, listen: false);
        sideNavManagerProvider.onSelected(MenuItems(AppNavigation.currentContext!).reminders);
        AppNavigation.pushAndKillAll(AppRoutes.sideNavManager);
        completer.complete(true);
      },
    );

    return completer.future;
  }

  Future<ContraceptionReminderModel> handleGetContraceptionReminder(String? id) async {
    CustomLoading.showLoadingIndicator();
    final completer = Completer<ContraceptionReminderModel>();
    final result = await RemindersService.getContraceptionReminder(id);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        CustomLoading.hideLoadingIndicator();
        completer.complete(ContraceptionReminderModel());
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        completer.complete(r);
      },
    );

    return completer.future;
  }

  Future<void> handleGetAllContraceptionReminders() async {
    final result = await RemindersService.getAllContraceptionReminders();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
      },
      (r) async {
        contraceptionReminders = r;
        notifyListeners();
      },
    );
  }

  // Medication reminders
  Future<bool> handleCreateOrUpdateMedicationReminder({required MedicineReminderRequest data, bool create = true, String? id}) async {
    CustomLoading.showLoadingIndicator();

    final completer = Completer<bool>();
    final result = create ? await RemindersService.createOrUpdateMedicineReminder(request: data) : await RemindersService.createOrUpdateMedicineReminder(request: data, create: false, id: id!);

    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        CustomLoading.hideLoadingIndicator();
        completer.complete(false);
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        scheduleReminder(medication: r);

        completer.complete(true);
        var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(AppNavigation.currentContext!, listen: false);

        sideNavManagerProvider.onSelected(MenuItems(AppNavigation.currentContext!).reminders);
        AppNavigation.pushAndKillAll(AppRoutes.sideNavManager);
        // HelperFunctions.showNotification(AppNavigation.currentContext!, "Reminder Scheduled Succesfully!");
      },
    );

    return completer.future;
  }

  Future<void> handleGeltAllMedicationReminders() async {
    final result = await RemindersService.getAllMedicinesRemindersFromApi();
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
      },
      (r) async {
        medicationReminders = r;
        notifyListeners();
      },
    );
  }

  Future<PeriodReminderModel> getPeriodReminder(String id) async {
    CustomLoading.showLoadingIndicator();
    final completer = Completer<PeriodReminderModel>();
    final result = await RemindersService.getPeriodReminder(id);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
        completer.complete(PeriodReminderModel());
      },
      (r) async {
        completer.complete(r);
        CustomLoading.hideLoadingIndicator();
      },
    );

    return completer.future;
  }

  // UI Helper functions
  void handleReminderNavigation({MedicineReminderRequest? medicine, ContraceptionReminderModel? contraception, PeriodReminderModel? period}) {
    if (medicine?.id != null) {
      AppNavigation.navigateTo(AppRoutes.medicationReminder, arguments: ScreenArguments(medicationReminderId: medicine?.id));
    } else if (contraception?.id != null) {
      switch (contraception?.contraceptionType) {
        case RemindersHelper.oralContraceptionsString:
          AppNavigation.navigateTo(AppRoutes.oralContraceptionReminder);
          break;
        case RemindersHelper.vaginalRingString:
          AppNavigation.navigateTo(AppRoutes.vaginalRingReminder);
          break;
        case RemindersHelper.contraceptivePatchString:
          AppNavigation.navigateTo(AppRoutes.contraceptivePatchReminder);
          break;
        case RemindersHelper.contraceptiveInjectionString:
          AppNavigation.navigateTo(AppRoutes.contraceptiveInjectionReminder);
          break;
        case RemindersHelper.iudString:
          AppNavigation.navigateTo(AppRoutes.iudReminder);
          break;
        case RemindersHelper.contraceptiveImplantString:
          AppNavigation.navigateTo(AppRoutes.contraceptiveImplantReminder);
          break;
        default:
      }
    }
  }

  Color decideTileBorderColor({required RemindersProvider value, MedicineReminderRequest? medicine, ContraceptionReminderModel? contraception, PeriodReminderModel? period}) {
    Color borderColor = Colors.transparent;
    if (medicine?.id != null) {
      value.toBeDeletedMedicationReminderIds.contains(medicine?.id) ? borderColor = AppColors.primaryColor600 : borderColor = Colors.transparent;
    } else if (contraception?.id != null) {
      value.toBeDeletedContraceptionReminderIds.contains(contraception?.id) ? borderColor = AppColors.primaryColor600 : borderColor = Colors.transparent;
    } else if (period?.id != null) {
      value.toBeDeletedPeriodReminderId.contains(period!.id!) ? borderColor = AppColors.primaryColor600 : borderColor = Colors.transparent;
    }
    return borderColor;
  }

  String getTime({MedicineReminderRequest? medicine, ContraceptionReminderModel? contraception, PeriodReminderModel? period}) {
    String time = "";
    if (medicine?.medicineDailyReminderTime != null) {
      time = DateFormat("h:mm a").format(HelperFunctions.combineDateTime(medicine!.medicineDailyReminderDate!, medicine.medicineDailyReminderTime!));
    } else if (contraception?.time != null) {
      time = DateFormat("h:mm a").format(HelperFunctions.combineDateTime(contraception!.date!, contraception.time!));
    } else if (period?.periodStartDate != null) {
      time = DateFormat("h:mm a").format(DateTime.parse(period!.periodStartDate!));
    }
    return time;
  }

  Widget getReminderIcon({MedicineReminderRequest? medicine, ContraceptionReminderModel? contraception, PeriodReminderModel? period}) {
    Widget? icon;
    Color? bgColor;
    if (medicine?.id != null) {
      icon = SvgPicture.asset(
        Assets.customiconsPill1,
        height: 24,
        width: 24,
        color: AppColors.accentColorFour500,
      );
      bgColor = AppColors.accentColorFour400;
    } else if (contraception?.id != null) {
      icon = SvgPicture.asset(
        Assets.customiconsHormones,
        height: 24,
        width: 24,
        color: AppColors.accentColorFour500,
      );
      bgColor = AppColors.accentColorFour400;
    } else if (period?.id != null) {
      icon = SvgPicture.asset(
        Assets.customiconsDrip,
        height: 24,
        width: 24,
        color: AppColors.primaryColor600,
      );
      bgColor = AppColors.primaryColor400;
    }
    return HelperFunctions.giveBackgroundToIcon(icon!, bgColor: bgColor, isRectangle: true);
  }

  Padding? buildSubtitle({MedicineReminderRequest? medicine, ContraceptionReminderModel? contraception, PeriodReminderModel? period}) {
    String subtitle = "";
    if (medicine?.id != null) {
      subtitle = medicine!.medicineDose!;
    } else if (contraception?.id != null) {
      subtitle = "";
    } else if (period?.id != null) {
      subtitle = "Period begins in 2 days";
    }
    return subtitle.isEmpty
        ? null
        : Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              subtitle,
              style: Theme.of(AppNavigation.currentContext!).textTheme.labelMedium,
            ),
          );
  }
  // Delete reminders
}
