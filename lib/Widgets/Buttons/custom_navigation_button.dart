import 'package:ekvi/Utils/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationButton extends StatelessWidget {
  final String? iconAddress;
  final String? icon;
  final VoidCallback? callback;

  const NavigationButton({
    super.key,
    this.iconAddress,
    this.icon,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: iconAddress != null
          ? Image.asset(iconAddress!)
          : SvgPicture.asset (icon ?? "", height: 18, width: 18, color: AppColors.actionColor600,),
    );
  }
}
