import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
// import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:sizer/sizer.dart';

class DeletePanel extends StatefulWidget {
  const DeletePanel({super.key});

  @override
  State<DeletePanel> createState() => _DeletePanelState();
}

class _DeletePanelState extends State<DeletePanel> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<DailyTrackerProvider>(
      builder: (context, value, child) => Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: () => value.revertDeleteMode(), child: Text("Cancel", style: textTheme.headlineSmall!.copyWith(color: AppColors.secondaryColor600))),
              Text("${value.toBeDeleteCategoriesCount} selected", style: textTheme.bodyMedium),
              TextButton(
                  onPressed: () {
                    var provider = Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!, listen: false);
                    provider.handleDeleteCategoryData();
                  },
                  child: Text(
                    "Delete",
                    style: textTheme.headlineSmall!.copyWith(color: AppColors.accentColorOne500),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
