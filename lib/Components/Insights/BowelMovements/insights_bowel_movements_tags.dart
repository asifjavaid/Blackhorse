import 'package:ekvi/Components/DailyTracker/BowelMovement/bowl_movement_color_panel.dart';
import 'package:ekvi/Components/DailyTracker/BowelMovement/bristol_stool_scale_widget.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/BowelMovement/bowel_movement_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_list_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsBowelMovementsTags extends StatelessWidget {
  const InsightsBowelMovementsTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BowelMovementProvider>(builder: (context, value, child) {
      return (value.bowelMovTaglist.isDataLoaded)
          ? Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                ListGridOptions(
                  title: "Bristol Stool Scale",
                  elevated: true,
                  options: value.bowelMovTaglist.graphData?.bristolScale?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                  width: 100.w,
                  height: 100.h,
                  enableHelp: true,
                  margin: EdgeInsets.zero,
                  enableHelpCallback: () {
                    HelperFunctions.openCustomBottomSheet(context, content: const BristolStoolScaleWidget(), height: 750);
                  },
                  backgroundColor: AppColors.whiteColor,
                  callback: () {},
                  subCategoryOptions: [
                    GridOptions(
                      title: "Colour",
                      elevated: false,
                      options: value.bowelMovTaglist.graphData?.stoolColour?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      enableHelp: true,
                      enableHelpCallback: () {
                        HelperFunctions.openCustomBottomSheet(context, content: const ColorWidget(), height: 700);
                      },
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Size",
                      elevated: false,
                      options: value.bowelMovTaglist.graphData?.stoolSize?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Effort",
                      elevated: false,
                      options: value.bowelMovTaglist.graphData?.stoolEffort?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Unusual components",
                      elevated: false,
                      options: value.bowelMovTaglist.graphData?.stoolComponents?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Duration",
                      elevated: false,
                      options: value.bowelMovTaglist.graphData?.stoolDuration?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    )
                  ],
                ),
              ],
            )
          : const SizedBox.shrink();
    });
  }
}
