import 'package:ekvi/Providers/Reminders/contraceptive_implant_provider.dart';
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

class ContraceptiveImplantReminder extends StatefulWidget {
  const ContraceptiveImplantReminder({super.key});

  @override
  State<ContraceptiveImplantReminder> createState() =>
      _ContraceptiveImplantReminder();
}

class _ContraceptiveImplantReminder
    extends State<ContraceptiveImplantReminder> {
  var provider = Provider.of<ContraceptiveImplantProvider>(
      AppNavigation.currentContext!,
      listen: false);

  @override
  void initState() {
    provider.handleGetContraceptivesImplantReminder();
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

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackNavigation(
                  title: AppLocalizations.of(context)!.implant,
                  callback: () => AppNavigation.goBack(),
                ),
                Consumer<ContraceptiveImplantProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      TextAndSwitch(
                        text:
                            AppLocalizations.of(context)!.contraceptivesImplant,
                        value: value.isContraceptiveImplantSwitchOn,
                        callback: value.setContraceptiveImplantSwitch,
                      ),
                      SizedBox(height: 2.h),
                      WhiteContainer(
                          width: 94.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.reminderTime,
                                  style: textTheme.headlineSmall),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("hh:mm a").format(
                                    value.contraceptiveImplantReminderTime),
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
                                        value.contraceptiveImplantReminderTime,
                                        value
                                            .setContraceptiveImplantReminderTime),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      Notes(
                        title: AppLocalizations.of(context)!
                            .personalizeYourMessage,
                        placeholderText: value.contraceptiveImplantNotes,
                        notesText: value.contraceptiveImplantNotes,
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
                              Text(AppLocalizations.of(context)!.implant,
                                  style: textTheme.headlineSmall),
                              SizedBox(height: 2.h),
                              Text(
                                  AppLocalizations.of(context)!
                                      .logNumberOfYearsImplant,
                                  style: textTheme.labelMedium),
                              SizedBox(height: 2.h),
                              CustomFieldDropdown(
                                  options: value
                                      .contraceptiveImplantPeriodOfUseOptions,
                                  value: value.selectedPeriodOfUse,
                                  getLabel: (String value) => value,
                                  onChanged: (String? newValue) =>
                                      value.setPeriodOfUse(newValue)),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("dd/MM/yy").format(
                                    value.contraceptiveImplantReminderDate),
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
                                        value.contraceptiveImplantReminderDate,
                                        value
                                            .setContraceptionImplantReminderDate),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      CustomButton(
                          title: AppLocalizations.of(context)!.save,
                          onPressed: value.enableButton
                              ? () => value
                                  .handleCreateOrUpdateContraceptivesImplant()
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
