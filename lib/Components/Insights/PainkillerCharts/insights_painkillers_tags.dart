import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsPainkillerTags extends StatelessWidget {
  const InsightsPainkillerTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PainKillersProvider>(
        builder: (context, value, child) => value.painKillersTagsCounts.isDataLoaded
            ? GridOptions(
                title: "My painkillers",
                elevated: true,
                options: value.painKillersTagsCounts.painkillersData?.map((data) => OptionModel(text: data.painkillerName ?? "Unknown", value: data.usageCount)).toList() ?? [],
                width: 100.w,
                height: 100.h,
                backgroundColor: AppColors.whiteColor,
                callback: (index) {},
                margin: EdgeInsets.zero,
                enableHelp: true,
                helpWidget: GestureDetector(
                  onTap: () => AppNavigation.navigateTo(AppRoutes.allPainKillersVault),
                  child: HelperFunctions.giveBackgroundToIcon(
                      const Icon(
                        AppCustomIcons.arrow_right,
                        size: 16,
                      ),
                      height: 36,
                      width: 36,
                      bgColor: AppColors.actionColor400),
                ),
              )
            : const SizedBox.shrink());
  }
}
