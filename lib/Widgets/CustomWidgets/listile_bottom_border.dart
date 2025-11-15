import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ListTileBottomBorder extends StatelessWidget {
  final Widget child;
  const ListTileBottomBorder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primaryColor500, width: 1.0), // Bottom border color and width
          ),
        ),
        child: child);
  }
}
