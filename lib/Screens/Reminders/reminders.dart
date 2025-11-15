import 'package:ekvi/Components/Reminders/delete_panel.dart';
import 'package:ekvi/Models/Reminders/ContraceptionReminders/contraception_reminder_model.dart';
import 'package:ekvi/Models/Reminders/MedicationReminder/Request/medicine_reminder_request.dart';
import 'package:ekvi/Models/Reminders/PeriodReminder/period_reminder_model.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/reminder_helper.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/CustomWidgets/listile_bottom_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ekvi/l10n/app_localizations.dart';

DateTime scheduleTime = DateTime.now();

class Reminders extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const Reminders({super.key, this.screenArguments});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  var provider = Provider.of<RemindersProvider>(AppNavigation.currentContext!,
      listen: false);
  @override
  void initState() {
    provider.getAllReminders();
    super.initState();
  }

  @override
  void dispose() {
    provider.revertDeleteMode(togglePanelRequired: false);
    provider.clearReminders();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(
        AppNavigation.currentContext!,
        listen: false);

    return Scaffold(
      body: Consumer<RemindersProvider>(
        builder: (context, value, child) => SlidingUpPanel(
          backdropTapClosesPanel: false,
          controller: value.panelController,
          padding: null,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
          backdropEnabled: false,
          backdropOpacity: 0.6,
          renderPanelSheet: true,
          maxHeight: 15.h,
          minHeight: 0,
          panel: const DeletePanel(),
          body: GradientBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BackNavigation(
                      title: AppLocalizations.of(context)!.reminders,
                      callback: () =>
                          (widget.screenArguments?.isSideNavRoute != null &&
                                  widget.screenArguments!.isSideNavRoute!)
                              ? sideNavManagerProvider.onSelected(
                                  MenuItems(AppNavigation.currentContext!)
                                      .bottomNavManager)
                              : AppNavigation.goBack(),
                    ),
                    ContentBox(
                      width: 92.w,
                      listView: false,
                      contentHorizontalAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.addANewReminder,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        // SizedBox(height: 3.h),
                        // ListTileBottomBorder(
                        //   child: ListTile(
                        //     title: Text(
                        //       AppLocalizations.of(context)!.periodBeginsIn2Days,
                        //       style: Theme.of(context).textTheme.bodyMedium,
                        //     ),
                        //     trailing: const Icon(
                        //       Icons.arrow_forward_ios_rounded,
                        //       color: AppColors.actionColor600,
                        //     ),
                        //     onTap: () => AppNavigation.navigateTo(AppRoutes.periodInDays),
                        //   ),
                        // ),
                        SizedBox(height: 2.h),
                        ListTileBottomBorder(
                          child: ListTile(
                            title: Text(
                                AppLocalizations.of(context)!.contraception,
                                style: Theme.of(context).textTheme.bodyMedium),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.actionColor600,
                            ),
                            onTap: () => AppNavigation.navigateTo(
                                AppRoutes.contraceptionMenu),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.medication,
                              style: Theme.of(context).textTheme.bodyMedium),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.actionColor600,
                          ),
                          onTap: () => AppNavigation.navigateTo(
                              AppRoutes.medicationReminder),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    (value.medicationReminders.isNotEmpty ||
                            value.contraceptionReminders.isNotEmpty)
                        ? ContentBox(
                            width: 92.w,
                            listView: false,
                            contentHorizontalAlignment:
                                CrossAxisAlignment.start,
                            children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .currentReminders,
                                  style: textTheme.headlineSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .tapOnTheSymptoms,
                                  style: textTheme.bodyMedium!
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ...value.medicationReminders.map((e) {
                                  return e.id != null
                                      ? reminderTile(
                                          context: context,
                                          value: value,
                                          medicine: e)
                                      : const SizedBox.shrink();
                                }),
                                ...value.contraceptionReminders.map((e) {
                                  return e.id != null
                                      ? reminderTile(
                                          context: context,
                                          value: value,
                                          contraception: e)
                                      : const SizedBox.shrink();
                                }),
                              ])
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget reminderTile(
          {required BuildContext context,
          required RemindersProvider value,
          MedicineReminderRequest? medicine,
          ContraceptionReminderModel? contraception,
          PeriodReminderModel? period}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: value.decideTileBorderColor(
                      value: value,
                      medicine: medicine,
                      contraception: contraception,
                      period: period),
                  width: 1.0,
                ),
                boxShadow: const [AppThemes.shadowDown],
                borderRadius: const BorderRadius.all(Radius.circular(11)),
              ),
              child: Material(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  child: ListTile(
                    tileColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    onTap: !value.isDeleteMode
                        ? () => value.handleReminderNavigation(
                            contraception: contraception,
                            medicine: medicine,
                            period: period)
                        : () => value.handleReminderDelete(
                            contraceptionId: contraception?.id,
                            medicationId: medicine?.id,
                            periodId: period?.id),
                    onLongPress: () => value.toggleDeleteMode(
                        contraceptionId: contraception?.id,
                        medicationId: medicine?.id,
                        periodId: period?.id),
                    leading: value.getReminderIcon(
                        contraception: contraception,
                        medicine: medicine,
                        period: period),
                    title: Text(
                      "${value.getTime(contraception: contraception, medicine: medicine, period: period)}, ${medicine?.medicineName ?? contraception?.contraceptionType ?? RemindersHelper.periodReminderString}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              fontSize: 16),
                    ),
                    subtitle: value.buildSubtitle(
                        contraception: contraception,
                        medicine: medicine,
                        period: period),
                  ))));
}
