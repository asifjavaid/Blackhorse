import 'package:ekvi/Providers/Reminders/contraceptive_patch_povider.dart';
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

class ContraceptivePatchReminder extends StatefulWidget {
  const ContraceptivePatchReminder({super.key});

  @override
  State<ContraceptivePatchReminder> createState() =>
      _ContraceptivePatchReminder();
}

class _ContraceptivePatchReminder extends State<ContraceptivePatchReminder> {
  var provider = Provider.of<ContraceptivePatchProvider>(
      AppNavigation.currentContext!,
      listen: false);
  @override
  void initState() {
    provider.handleGetContraceptivePatchReminder();
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
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackNavigation(
                  title: localizations!.patch,
                  callback: () => AppNavigation.goBack(),
                ),
                Consumer<ContraceptivePatchProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      TextAndSwitch(
                        text: localizations.contraceptivesPatch,
                        value: value.isContraceptivePatchSwitchOn,
                        callback: value.setContraceptivePatchSwitch,
                      ),
                      SizedBox(height: 2.h),
                      WhiteContainer(
                          width: 94.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localizations.reminderTime,
                                  style: textTheme.headlineSmall),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("hh:mm a").format(
                                    value.contraceptivePatchReminderTime),
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
                                        value.contraceptivePatchReminderTime,
                                        value
                                            .setContraceptivePatchReminderTime),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      Notes(
                        title: localizations.personalizeYourMessage,
                        placeholderText: value.notesContraceptivePatch,
                        notesText: value.notesContraceptivePatch,
                        callback: value.setNotes,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      WhiteContainer(
                          width: 94.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localizations.numberOfPatches,
                                  style: textTheme.headlineSmall),
                              SizedBox(height: 2.h),
                              Text(localizations.patchReminderDescription,
                                  style: textTheme.labelMedium),
                              SizedBox(height: 2.h),
                              CustomFieldDropdown(
                                  options: value.lengthOptionsContraception,
                                  value: value.selectedLengthContraception,
                                  getLabel: (String value) => value,
                                  onChanged: (String? newValue) =>
                                      value.setContraceptionLength(newValue)),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("dd/MM/yy").format(
                                    value.contraceptivePatchReminderDate),
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
                                        value.contraceptivePatchReminderDate,
                                        value
                                            .setContraceptivePatchReminderDate),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      CustomButton(
                          title: "Save",
                          minSize: Size(92.w, 7.h),
                          maxSize: Size(92.w, 7.h),
                          onPressed: value.enableButton
                              ? () =>
                                  value.handleCreateOrUpdateContraceptivePatch()
                              : null),
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
