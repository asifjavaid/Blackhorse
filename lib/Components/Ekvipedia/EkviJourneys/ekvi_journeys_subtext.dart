import 'package:flutter/material.dart';
import 'package:ekvi/Utils/Constants/app_colors.dart';

class EkviJourneysSubtext extends StatelessWidget {
  final String text;

  const EkviJourneysSubtext({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textTheme.bodyMedium?.copyWith(
          color: AppColors.actionColor600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
