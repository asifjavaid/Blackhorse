import 'package:ekvi/Screens/Notifications/notification_preferences_screen.dart';
import 'package:flutter/material.dart';

class MovementTextAndSwitch extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> callback;
  const MovementTextAndSwitch({super.key, required this.text, required this.value, required this.callback});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: Theme.of(context).textTheme.headlineSmall),
          CustomSwitch(value: value, onChanged: callback),
        ],
      );
}
