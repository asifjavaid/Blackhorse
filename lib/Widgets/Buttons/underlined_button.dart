import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UnderlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const UnderlinedButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColors.actionColor600,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Container(
              height: 1,
              width: 70,
              color: AppColors.actionColor600,
            ),
          ],
        ),
      ),
    );
  }
}
