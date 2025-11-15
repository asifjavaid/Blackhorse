import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomOptionButton extends StatelessWidget {
  final String optionText;
  final VoidCallback onPressed;
  final bool isSelected;

  const CustomOptionButton({
    super.key,
    required this.optionText,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      width: 100.w - 32,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.secondaryColor400 : AppColors.whiteColor,
          foregroundColor: isSelected ? AppColors.whiteColor : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          side: BorderSide(
            color: isSelected ? AppColors.secondaryColor600 : Colors.transparent,
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(
          optionText,
          style: textTheme.bodyMedium!.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
