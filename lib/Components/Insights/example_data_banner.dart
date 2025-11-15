import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:flutter/material.dart';

class ExampleDataBanner extends StatelessWidget {
  final String? title;
  final String? description;

  const ExampleDataBanner({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFFFFF4F0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PremiumIconWidget(),
                  Text(title ?? "", textAlign: TextAlign.center, style: textTheme.displaySmall),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(description ?? "", style: textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
