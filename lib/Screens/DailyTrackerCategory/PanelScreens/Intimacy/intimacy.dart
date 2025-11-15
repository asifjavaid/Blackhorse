import 'package:ekvi/Providers/DailyTracker/Initmacy/intimacy_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Intimacy extends StatelessWidget {
  const Intimacy({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<IntimacyProvider>(
        builder: (context, provider, child) => Column(
              children: [
                GridOptions(
                    title: "When did it happen?",
                    elevated: true,
                    options: provider.intimacyData.intimacyTime,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: provider.handleTimeSelection),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "Type of intimacy",
                    elevated: true,
                    options: provider.intimacyData.typeOfIntimacy,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: provider.handleTypeOfIntimacySelection),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                    title: "Activity",
                    elevated: true,
                    options: provider.intimacyData.activityOfInitmacy,
                    width: width,
                    height: height,
                    backgroundColor: AppColors.whiteColor,
                    callback: provider.handleIntimacyActivitySelection),
                const SizedBox(
                  height: 48,
                ),
                CustomButton(
                  title: "Track Intimacy",
                  onPressed: () => provider.saveIntimacyData(context),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}
