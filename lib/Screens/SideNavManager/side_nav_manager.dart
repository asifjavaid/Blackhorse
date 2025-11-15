import 'dart:developer';

import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Screens/MenuPage/menu_page.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

class SideNavManager extends StatefulWidget {
  const SideNavManager({super.key});

  @override
  State<SideNavManager> createState() => _SideNavManagerState();
}

class _SideNavManagerState extends State<SideNavManager> {
  @override
  void initState() {
    super.initState();
    log("Initializing Subscription data");
    Provider.of<SubscriptionProvider>(context, listen: false).initializeSubscription();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ZoomDrawer(
        menuBackgroundColor: AppColors.whiteColor,
        style: DrawerStyle.defaultStyle,
        borderRadius: 24.0,
        showShadow: false,
        angle: 0.0,
        slideWidth: screenWidth,
        menuScreenWidth: screenWidth,
        menuScreen: Builder(
          builder: (context) => Consumer<SideNavManagerProvider>(
            builder: (context, value, child) => MenuPage(
                currentItem: value.currentItem,
                onSelectedItem: (item) {
                  value.onSelected(item);
                  ZoomDrawer.of(context)!.close();
                }),
          ),
        ),
        mainScreen: Consumer<SideNavManagerProvider>(builder: (context, value, child) => value.getScreen()));
  }
}
