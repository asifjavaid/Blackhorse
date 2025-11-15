import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
// import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/Dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

class DeletePanel extends StatelessWidget {
  const DeletePanel({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<RemindersProvider>(
        builder: (context, value, child) => Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () => value.revertDeleteMode(), child: Text("Cancel", style: textTheme.headlineSmall!.copyWith(color: AppColors.secondaryColor600))),
                  Text("${value.toBeDeleteRemindersCount} selected", style: textTheme.bodyMedium),
                  TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "Delete selected reminders?",
                              description: "Are you sure you want to delete these reminders?",
                              leftButtonText: "Cancel",
                              rightButtonText: "Delete",
                              leftButtonCallback: () => AppNavigation.goBack(),
                              rightButtonCallback: () => value.handleDeleteReminderData(),
                              // image: Image.asset(
                              //   "${AppConstant.assetImages}delete.png",
                              //   height: 15.h,
                              //   width: 15.h,
                              //   fit: BoxFit.cover,
                              // ),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Delete",
                        style: textTheme.headlineSmall!.copyWith(color: AppColors.accentColorOne500),
                      )),
                ],
              ),
            ));
  }
}
