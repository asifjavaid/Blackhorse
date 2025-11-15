import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String? iconAddress;
  final Icon? icon;
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
      child: iconAddress != null ? Image.asset(iconAddress!) : icon,
    );
  }
}
