import 'package:ekvi/Providers/Reminders/oral_contraception_provider.dart';
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

class OralContraceptionReminder extends StatefulWidget {
  const OralContraceptionReminder({super.key});

  @override
  State<OralContraceptionReminder> createState() =>
      _OralContraceptionReminder();
}

class _OralContraceptionReminder extends State<OralContraceptionReminder> {
  var provider = Provider.of<OralContraceptionProvider>(
      AppNavigation.currentContext!,
      listen: false);

  @override
  void initState() {
    provider.handleGetOralContraceptionReminder();

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
                  title: localizations!.oral,
                  callback: () => AppNavigation.goBack(),
                ),
                Consumer<OralContraceptionProvider>(
                  builder: (context, value, child) => Column(
                    children: [
                      TextAndSwitch(
                        text: localizations.oralContraceptives,
                        value: value.isContraceptionReminderSwitchedOn,
                        callback: value.setContraceptionReminderSwitch,
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
                                title: DateFormat("hh:mm a")
                                    .format(value.contraceptionReminderTime),
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
                                        value.contraceptionReminderTime,
                                        value.setContraceptionReminderTime),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      Notes(
                        title: localizations.personalizeYourMessage,
                        placeholderText: value.notesContraception,
                        notesText: value.notesContraception,
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
                              Text(localizations.numberOfPills,
                                  style: textTheme.headlineSmall),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(localizations.packageInfo,
                                  style: textTheme.bodySmall),
                              SizedBox(height: 2.h),
                              CustomButton(
                                titleAtStart: true,
                                title: DateFormat("dd/MM/yy")
                                    .format(value.contraceptionReminderDate),
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
                                        value.contraceptionReminderDate,
                                        value.setContraceptionReminderDate),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                              SizedBox(height: 2.h),
                              CustomFieldDropdown(
                                  options: value.lengthOptionsContraception,
                                  value: value.selectedLengthContraception,
                                  getLabel: (String value) => value,
                                  onChanged: (String? newValue) =>
                                      value.setLength(newValue)),
                            ],
                          )),
                      SizedBox(height: 2.h),
                      CustomButton(
                          title: "Save",
                          minSize: Size(92.w, 7.h),
                          maxSize: Size(92.w, 7.h),
                          onPressed: value.enableButton
                              ? () =>
                                  value.handleCreateOrUpdateOralContraception()
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
