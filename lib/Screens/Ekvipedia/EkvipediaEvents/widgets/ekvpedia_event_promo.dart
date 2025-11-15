import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class EkviPromo extends StatelessWidget {
  final String promoCode;
  const EkviPromo({super.key, required this.promoCode});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: 132,
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Promo code',
            textAlign: TextAlign.center,
            style: textTheme.displaySmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Register with our promo code ',
                  style: spanStyle(textTheme),
                ),
                TextSpan(
                  text: promoCode,
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.neutralColor600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' to join the event for free. ',
                  style: spanStyle(textTheme),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle spanStyle(textTheme) {
    return textTheme.titleSmall?.copyWith(
      color: AppColors.neutralColor600,
      fontWeight: FontWeight.w400,
    );
  }
}
