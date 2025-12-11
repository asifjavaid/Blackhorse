import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';

class DashboardIconsBar extends StatelessWidget {
  const DashboardIconsBar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => ZoomDrawer.of(context)!.toggle(),
            child: SvgPicture.asset(
              Assets.customiconsMenu,
              height: 20,
              width: 20,
              color: AppColors.actionColor600,
            ),
          ),
          // Row(
          //   children: [
          //     InkWell(onTap: () => AppNavigation.navigateTo(AppRoutes.notifications), child: const Icon(AppCustomIcons.notification, size: 20)),
          //     SizedBox(
          //       width: 2.5.w,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
