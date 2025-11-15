import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/CustomWidgets/clickable_body_back.dart';
import 'package:ekvi/Widgets/CustomWidgets/clickable_body_front.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BodyPartSelection extends StatefulWidget {
  final bool? isEditing;
  const BodyPartSelection({super.key, this.isEditing});

  @override
  State<BodyPartSelection> createState() => _BodyPartSelectionState();
}

class _BodyPartSelectionState extends State<BodyPartSelection> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<DailyTrackerProvider>(
        builder: (context, value, child) => ContentBox(listView: false, showShadow: true, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  "Click the body part where you're feeling pain.",
                  textAlign: TextAlign.center,
                  style: textTheme.titleSmall,
                ),
                SizedBox(
                  height: 0.02 * height,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomButton(
                    title: "Front",
                    color: value.isBodyPoseFront ? AppColors.secondaryColor600 : AppColors.secondaryColor400,
                    fontColor: value.isBodyPoseFront ? AppColors.whiteColor : AppColors.neutralColor600,
                    minSize: Size(0.3 * width, 0.05 * height),
                    onPressed: () {
                      value.setBodyPose(true);
                    },
                  ),
                  SizedBox(
                    width: 0.03 * width,
                  ),
                  CustomButton(
                    title: "Back",
                    color: value.isBodyPoseFront ? AppColors.secondaryColor400 : AppColors.secondaryColor600,
                    fontColor: value.isBodyPoseFront ? AppColors.neutralColor600 : AppColors.whiteColor,
                    minSize: Size(0.3 * width, 0.05 * height),
                    onPressed: () {
                      value.setBodyPose(false);
                    },
                  ),
                ]),
                Visibility(visible: value.isBodyPoseFront, maintainState: true, child: const ClickableBodyFront()),
                Visibility(
                  visible: !value.isBodyPoseFront,
                  maintainState: true,
                  child: const ClickableBodyBack(),
                ),
                (widget.isEditing != null && widget.isEditing!)
                    ? CustomButton(
                        title: value.categoriesData.bodyPain.editingBodyPartsEnabled ? "Save" : "Edit",
                        buttonType: value.categoriesData.bodyPain.editingBodyPartsEnabled ? ButtonType.primary : ButtonType.secondary,
                        onPressed: value.toggleIsEditingBodyPartsEnabled,
                      )
                    : CustomButton(
                        title: "Next",
                        onPressed: value.categoriesData.bodyPain.selectedBodyParts.isEmpty
                            ? null
                            : () {
                                AmplitudeBodyPartsSelection(bodyParts: value.categoriesData.bodyPain.selectedBodyParts).log();
                                AppNavigation.navigateTo(
                                  AppRoutes.bodyPain,
                                );
                              },
                      ),
                SizedBox(
                  height: 3.h,
                ),
              ]),
            ]));
  }
}
