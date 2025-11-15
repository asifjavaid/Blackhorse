import 'package:ekvi/Providers/Reminders/iud_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Screens/CycleTracking/cycle_tracking.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Buttons/custom_field_dropdown.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class IUDReminder extends StatefulWidget {
  const IUDReminder({super.key});

  @override
  State<IUDReminder> createState() => _IUDReminder();
}

class _IUDReminder extends State<IUDReminder> {
  var provider = Provider.of<IUDReminderProvider>(AppNavigation.currentContext!,
      listen: false);

  @override
  void initState() {
    provider.handleGetIUDReminder();
    super.initState();
  }

  @override
  void dispose() {
    provider.setEnableButton(true, notify: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackNavigation(
                  title: localizations.iud,
                  callback: () => AppNavigation.goBack(),
                ),
                Consumer<IUDReminderProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      TextAndSwitch(
                        text: localizations.iud,
                        value: value.isIUDReminderSwitchTurnedOn,
                        callback: value.setIUDReminderSwitch,
                      ),
                      SizedBox(height: 2.h),
                      WhiteContainer(
                          width: 94.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localizations.stringCheck,
                                  style: textTheme.headlineSmall),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("hh:mm a")
                                    .format(value.iudReminderTime),
                                color: AppColors.primaryColor400,
                                fontColor: AppColors.blackColor,
                                tralingIcon: const Icon(
                                  AppCustomIcons.arrow_down,
                                  color: AppColors.actionColor600,
                                  size: 16,
                                ),
                                elevation: 0,
                                onPressed: () => HelperFunctions.showSheet(
                                    context,
                                    child: HelperFunctions.buildTimePicker(
                                        value.iudReminderTime,
                                        value.setIudReminderTime),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      Notes(
                        title: localizations.personalizeYourMessage,
                        placeholderText: value.iudNotes,
                        notesText: value.iudNotes,
                        callback: value.setIudNotes,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      WhiteContainer(
                          width: 94.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localizations.iudReplacement,
                                  style: textTheme.headlineSmall),
                              SizedBox(height: 2.h),
                              Text(localizations.iudReplacementDescription,
                                  style: textTheme.labelMedium),
                              SizedBox(height: 2.h),
                              CustomFieldDropdown(
                                  options: value.iudTypes,
                                  value: value.selectedIUD,
                                  getLabel: (String value) => value,
                                  onChanged: (String? newValue) =>
                                      value.setIUD(newValue)),
                              SizedBox(height: 2.h),
                              CustomFieldDropdown(
                                  options: value.iudPeriodOfUse,
                                  value: value.iudSelectedPeriodOfUse,
                                  getLabel: (String value) => value,
                                  onChanged: (String? newValue) =>
                                      value.setIudPeriodOfUse(newValue)),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("dd/MM/yy")
                                    .format(value.iudReminderDate),
                                color: AppColors.primaryColor400,
                                fontColor: AppColors.blackColor,
                                tralingIcon: const Icon(
                                  AppCustomIcons.arrow_down,
                                  color: AppColors.actionColor600,
                                  size: 16,
                                ),
                                elevation: 0,
                                onPressed: () => HelperFunctions.showSheet(
                                    context,
                                    child: HelperFunctions.buildDatePicker(
                                        value.iudReminderDate,
                                        value.setIudReminderDate),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      CustomButton(
                          title: localizations.save,
                          onPressed: value.enableButton
                              ? () => value.handleCreateOrUpdateIUD()
                              : null),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
