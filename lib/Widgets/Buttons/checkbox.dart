import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onChecked;
  const CheckBox({super.key, required this.isChecked, required this.onChecked});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChecked,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(72, 111, 174, 0.12).withOpacity(0.12),
              spreadRadius: 3,
              blurRadius: 10,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.whiteColor,
        ),
        child: isChecked
            ? const Icon(
                Icons.check,
                color: Colors.blue,
                size: 25,
              )
            : Container(),
      ),
    );
  }
}
