import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HeaderAndSubtitle extends StatelessWidget {
  final String text;
  final String subtitle;
  const HeaderAndSubtitle({super.key, required this.text, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.neutralColor600,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
