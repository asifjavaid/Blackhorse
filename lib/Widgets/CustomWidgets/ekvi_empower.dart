import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';

class EkviEmpower extends StatelessWidget {
  const EkviEmpower({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Color(0xFFFFDBCE)),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [AppThemes.shadowDown],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Unlock Ekvi Empower',
                style: textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Subscribe to Ekvi Empower and get access to all your data, insights, and stories.',
                style: textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              title: 'Tell me more',
              onPressed: () {
                PurchaseAccessedEvent(feature: "Settings").log();
                AppNavigation.navigateTo(AppRoutes.subscribe);
              },
            ),
          ],
        ),
      ),
    );
  }
}
