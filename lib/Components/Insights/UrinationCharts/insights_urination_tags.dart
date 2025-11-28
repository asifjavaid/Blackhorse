import 'package:ekvi/Components/DailyTracker/BowelMovement/bowl_movement_color_panel.dart';
import 'package:ekvi/Components/DailyTracker/BowelMovement/bristol_stool_scale_widget.dart';
import 'package:ekvi/Components/UrinationUrgencyLevel/urination_urgency_smell_help_panel.dart';
import 'package:ekvi/Components/UrinationUrgencyLevel/urination_urgency_volume_help_panel.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/BowelMovement/bowel_movement_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Urination/urination_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_list_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../UrinationUrgencyLevel/urination_urgency_color_panel.dart';

class InsightsUrinationsTags extends StatelessWidget {
  const InsightsUrinationsTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UrinationProvider>(builder: (context, value, child) {
      return (value.urinationTaglist.isDataLoaded)
          ? Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                ListGridOptions(
                  title: "Sensations",
                  elevated: true,
                  options: value.urinationTaglist.graphData?.sensation?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                  width: 100.w,
                  height: 100.h,
                  enableHelp: false,
                  margin: EdgeInsets.zero,
                  enableHelpCallback: () {
                    // HelperFunctions.openCustomBottomSheet(context, content: const BristolStoolScaleWidget(), height: 750);
                  },
                  backgroundColor: AppColors.whiteColor,
                  callback: () {},
                  subCategoryOptions: [
                    // GridOptions(
                    //   title: "Sensations",
                    //   elevated: false,
                    //   options: value.urinationTaglist.graphData?.sensation?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                    //   width: 100.w,
                    //   height: 100.h,
                    //   enableHelp: false,
                    //   enableHelpCallback: () {
                    //     HelperFunctions.openCustomBottomSheet(context, content: const ColorWidget(), height: 700);
                    //   },
                    //   backgroundColor: AppColors.whiteColor,
                    //   callback: () {},
                    //   padding: const EdgeInsets.only(top: 16),
                    //   margin: EdgeInsets.zero,
                    // ),
                    GridOptions(
                      title: "Complications",
                      elevated: false,
                      options: value.urinationTaglist.graphData?.complication?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Diagnoses",
                      elevated: false,
                      options: value.urinationTaglist.graphData?.diagnosis?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Colour",
                      elevated: false,
                      options: value.urinationTaglist.graphData?.color?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      enableHelp: true,
                      enableHelpCallback: () {
                        HelperFunctions.openCustomBottomSheet(context, content: const UrinationUrgencyColorHelpWidget(), height: 700);
                      },
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Smell",
                      elevated: false,
                      options: value.urinationTaglist.graphData?.smell?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      enableHelp: true,
                      enableHelpCallback: () {
                        HelperFunctions.openCustomBottomSheet(context, content: const UrinationUrgencySmellHelpWidget(), height: 700);
                      },
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Volume",
                      elevated: false,
                      options: value.urinationTaglist.graphData?.volume?.map((data) => OptionModel(text: data.tag ?? "Unkown", value: data.count)).toList() ?? [],
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      enableHelp: true,
                      enableHelpCallback: () {
                        HelperFunctions.openCustomBottomSheet(context, content: const UrinationUrgencyVolumeHelpWidget(), height: 700);
                      },
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
