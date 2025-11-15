import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onClick;
  const AuthenticationButton({super.key, required this.title, required this.icon, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(title),
        ],
      ),
    );
  }
}
