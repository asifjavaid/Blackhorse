import 'package:ekvi/Components/Insights/invitation_to_power_sheet.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SubscribeBottomPanel extends StatelessWidget {
  const SubscribeBottomPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
      height: 55.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is Ekvi Empower?',
            style: textTheme.headlineSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          Text(
            'Ekvi Empower is a subscription service designed to support you on your wellness journey. With Ekvi Empower, you will:',
            style: textTheme.bodySmall,
          ),
          Expanded(
            child: UnlockPersonalizedWidget(
              textTheme: textTheme,
              isButton: false,
            ),
          ),
        ],
      ),
    );
  }
}
