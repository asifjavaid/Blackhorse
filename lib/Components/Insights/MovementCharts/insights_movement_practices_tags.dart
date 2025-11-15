import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_provider.dart';
import 'package:ekvi/Providers/DailyTracker/YourWellBeing/your_well_being_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsMovementPracticesTags extends StatelessWidget {
  const InsightsMovementPracticesTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovementProvider>(
        builder: (context, value, child) => value.movementTagsCounts.isDataLoaded
            ? GridOptions(
                title: "My practices",
                elevated: true,
                options: value.movementTagsCounts.graphData?[0].practicesData?.map((data) => OptionModel(text: "${data.emoji} ${data.practiceName}", value: data.count)).toList() ?? [],
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: (index) {},
                margin: EdgeInsets.zero,
                enableHelp: true,
                helpWidget: GestureDetector(
                  onTap: () {
                    Provider.of<YourWellBeingProvider>(context, listen: false).selectTab(WellbeingTab.movement);
                    AppNavigation.navigateTo(AppRoutes.yourWellBeingScreen);
                  },
                  child: HelperFunctions.giveBackgroundToIcon(
                      const Icon(
                        AppCustomIcons.arrow_right,
                        size: 16,
                      ),
                      height: 36,
                      width: 36,
                      bgColor: AppColors.actionColor400),
                ),
                subCategoryOptions: GridOptions(
                  title: "Types",
                  elevated: false,
                  options: value.movementTagsCounts.graphData?[0].typeData?.map((data) => OptionModel(text: data.typeName ?? "Unknown", value: data.count)).toList() ?? [],
                  width: 100.w,
                  height: 100.h,
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColors.whiteColor,
                  callback: (index) {},
                  margin: EdgeInsets.zero,
                  enableHelp: false,
                ),
              )
            : const SizedBox.shrink());
  }
}
