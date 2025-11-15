import 'package:ekvi/Components/InAppPurchases/subscribe_bottom_panel_widget.dart';
import 'package:ekvi/Providers/userProvider/free_user_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SubscribeScreenHeader extends StatelessWidget {
  const SubscribeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var freeUserProvider = Provider.of<FreeUserProvider>(context, listen: true);
    return BackNavigation(
      title: "",
      callback: () {
        AppNavigation.goBack();
      },
      startIcon: const Icon(
        AppCustomIcons.delete,
        size: 16,
      ),
      endIcon: GestureDetector(
        onTap: () {
          freeUserProvider.updateInfoValue(true);
          if (freeUserProvider.info) {
            showModalFunction(context);
          }
        },
        child: SvgPicture.asset(
          "${AppConstant.assetIcons}info.svg",
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Future<bool> showModalFunction(context) {
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (c) {
        return const SubscribeBottomPanel();
      },
    ).then(
      (value) {
        return true;
      },
    );
  }
}
