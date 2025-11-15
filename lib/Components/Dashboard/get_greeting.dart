import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<DashboardProvider>(
      builder: (context, value, child) => Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              value.greeting,
              style: textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
