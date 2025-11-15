import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Buttons/custom_navigation_button.dart';
import 'package:flutter/material.dart';

class BackNavigation extends StatelessWidget {
  final Icon? startIcon;
  final VoidCallback? callback;
  final String title;
  final bool? hideBackButton;
  final Widget? endIcon;
  final EdgeInsets? padding;
  const BackNavigation({
    this.startIcon,
    this.callback,
    required this.title,
    this.hideBackButton,
    this.endIcon,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: hideBackButton ?? false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: Text(title, textAlign: TextAlign.center, style: textTheme.displaySmall)), if (endIcon != null) endIcon!],
            )
          : Column(
              children: [
                Row(
                  children: [
                    NavigationButton(
                      callback: callback,
                      // iconAddress: iconAddress,
                      icon: startIcon ??
                          const Icon(
                            AppCustomIcons.arrow_left__property_2_ic,
                            size: 18,
                          ),
                    ),
                    Expanded(child: Text(title, textAlign: TextAlign.center, style: textTheme.displaySmall)),
                    if (endIcon != null) endIcon!
                  ],
                ),
              ],
            ),
    );
  }
}
