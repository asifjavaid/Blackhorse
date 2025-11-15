import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';

class MovementDeleteAlertDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttionTitle;
  final Function onPress;
  const MovementDeleteAlertDialog({super.key, required this.title, required this.subtitle, required this.buttionTitle, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => AppNavigation.goBack(),
                child: const Icon(Icons.close),
              ),
            ),
            const SizedBox(height: 32),
            Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 16),
            Text(subtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 32),
            CustomButton(title: buttionTitle, onPressed: () => onPress.call()),
          ],
        ),
      ),
    );
  }
}
