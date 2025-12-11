import 'package:ekvi/Providers/Reminders/contraceptive_injection_provider.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

import '../../generated/assets.dart';

class ContraceptiveInjectionReminder extends StatefulWidget {
  const ContraceptiveInjectionReminder({super.key});

  @override
  State<ContraceptiveInjectionReminder> createState() =>
      _ContraceptiveInjectionReminder();
}

class _ContraceptiveInjectionReminder
    extends State<ContraceptiveInjectionReminder> {
  var provider = Provider.of<ContraceptiveInjectionProvider>(
      AppNavigation.currentContext!,
      listen: false);

  @override
  void initState() {
    provider.handleGetContraceptiveInjectionReminder();
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
                  title: localizations.injection,
                  callback: () => AppNavigation.goBack(),
                ),
                Consumer<ContraceptiveInjectionProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      TextAndSwitch(
                        text: localizations.contraceptivesInjection,
                        value: value.isContraceptionInjectionSwitchTurnedOn,
                        callback: value.setContraceptionInjectionSwitch,
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
                                    value.contraceptionInjectionReminderTime),
                                color: AppColors.primaryColor400,
                                fontColor: AppColors.blackColor,
                                tralingIcon: SvgPicture.asset(
                                    Assets.customiconsArrowDown,
                                    height: 16,
                                    width: 16,
                                    color: AppColors.actionColor600
                                ),
                                elevation: 0,
                                onPressed: () => HelperFunctions.showSheet(
                                    context,
                                    child: HelperFunctions.buildTimePicker(
                                        value
                                            .contraceptionInjectionReminderTime,
                                        value.setContraceptionInjectionTime),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      Notes(
                        title: localizations.personalizeYourMessage,
                        placeholderText: value.contraceptionInjectionNotes,
                        notesText: value.contraceptionInjectionNotes,
                        callback: value.setContraceptionInjectionNotes,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      WhiteContainer(
                          width: 94.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localizations.injectionFrequency,
                                  style: textTheme.headlineSmall),
                              SizedBox(height: 2.h),
                              Text(localizations.injectionFrequencyDescription,
                                  style: textTheme.labelMedium),
                              SizedBox(height: 2.h),
                              CustomFieldDropdown(
                                  options: value
                                      .contraceptionInjectionFrequecyOptions,
                                  value: value.selectedFrequency,
                                  getLabel: (String value) => value,
                                  onChanged: (String? newValue) =>
                                      value.setFrequency(newValue)),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("dd/MM/yy").format(
                                    value.contraceptionInjectionReminderDate),
                                color: AppColors.primaryColor400,
                                fontColor: AppColors.blackColor,
                                tralingIcon: SvgPicture.asset(
                                    Assets.customiconsArrowDown,
                                    height: 16,
                                    width: 16,
                                    color: AppColors.actionColor600
                                ),
                                elevation: 0,
                                onPressed: () => HelperFunctions.showSheet(
                                    context,
                                    child: HelperFunctions.buildDatePicker(
                                        value
                                            .contraceptionInjectionReminderDate,
                                        value.setContraceptionInjectionDate),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      CustomButton(
                          title: localizations.save,
                          onPressed: value.enableButton
                              ? () => value
                                  .handleCreateOrUpdateContraceptiveInjection()
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
