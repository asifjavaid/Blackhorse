import 'package:ekvi/Providers/Reminders/medication_reminder_provider.dart';
import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Buttons/custom_field_dropdown.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

import '../../generated/assets.dart';

class MedicationReminderScreen extends StatefulWidget {
  final ScreenArguments? args;
  const MedicationReminderScreen({super.key, this.args});

  @override
  State<MedicationReminderScreen> createState() =>
      _MedicationReminderScreenState();
}

class _MedicationReminderScreenState extends State<MedicationReminderScreen> {
  @override
  void initState() {
    if (widget.args?.medicationReminderId != null) {
      var provider = Provider.of<MedicationReminderProvider>(
          AppNavigation.currentContext!,
          listen: false);
      provider.getMedicationReminder(widget.args!.medicationReminderId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
        body: GradientBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<MedicationReminderProvider>(
              builder: (context, value, child) => Column(
                    children: [
                      BackNavigation(
                        title: localizations.newMedication,
                        callback: () {
                          AppNavigation.goBack();
                          var provider = Provider.of<RemindersProvider>(
                              AppNavigation.currentContext!,
                              listen: false);
                          provider.getAllReminders();
                        },
                      ),
                      Column(
                        children: [
                          ContentBox(
                            width: 92.w,
                            listView: false,
                            contentHorizontalAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.h),
                              Text(
                                localizations.typeOfMedication,
                                style: textTheme.headlineSmall,
                              ),
                              SizedBox(height: 2.h),
                              CustomFieldDropdown(
                                options: value.medicationOptions,
                                value: value.selectedMedication,
                                getLabel: (String value) => value,
                                onChanged: (String? newValue) async {
                                  // await value.consultBackendIfMedicineReminderExists(newValue!);
                                  value.setSelectedMedicine(newValue!);
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomFieldDropdown(
                                options: value.numberOfPillsOptions,
                                value: value.selectedNumberOfPills,
                                getLabel: (String value) => value,
                                onChanged: (String? newValue) async {
                                  value.setNumberOfPills(newValue!);
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomFieldDropdown(
                                options: value.dosageOptions,
                                value: value.selectedDosage,
                                getLabel: (String value) => value,
                                onChanged: (String? newValue) async {
                                  value.setDosage(newValue!);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          ContentBox(
                            width: 92.w,
                            listView: false,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    localizations.dailyReminder,
                                    style: textTheme.headlineSmall,
                                  ),
                                  FlutterSwitch(
                                    width: 50,
                                    height: 30.0,
                                    valueFontSize: 25.0,
                                    toggleSize: 30.0,
                                    value: value.isDailyReminderOn,
                                    borderRadius: 29.0,
                                    activeColor: AppColors.actionColor600,
                                    onToggle: (val) {
                                      value.setIsDailyReminderOn(val);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomButton(
                                title: DateFormat("hh:mm a")
                                    .format(value.selectedTime),
                                color: AppColors.primaryColor400,
                                fontColor: AppColors.blackColor,
                                tralingIcon: SvgPicture.asset(
                                  Assets.customiconsArrowDown,
                                  color: AppColors.actionColor600,
                                  height: 16,
                                  width: 16,
                                ),
                                leadingIcon: const Icon(
                                  Icons.watch_later_sharp,
                                  size: 20,
                                  color: AppColors.blackColor,
                                ),
                                elevation: 0,
                                onPressed: () => HelperFunctions.showSheet(
                                    context,
                                    child: HelperFunctions.buildTimePicker(
                                        value.selectedTime,
                                        value.setSelectedTime),
                                    onClicked: (() => Navigator.pop(context))),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Notes(
                                title: localizations.customizeReminder,
                                placeholderText: value.notes,
                                notesText: value.notes,
                                callback: value.setNotes,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CustomButton(
                              title: localizations.save,
                              onPressed: () =>
                                  widget.args?.medicationReminderId != null
                                      ? value.handleCreateOrUpdateMedication(
                                          update: true,
                                          id: widget.args?.medicationReminderId)
                                      : value.handleCreateOrUpdateMedication()),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ],
                  )),
        ),
      ),
    ));
  }
}
