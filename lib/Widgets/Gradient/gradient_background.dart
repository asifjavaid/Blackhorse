import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.decal,
          stops: const [0.1, 0.6, 0.8, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8E0A5).withOpacity(0.3),
            const Color(0xFFF3A492).withOpacity(0.3),
            const Color(0xFFF3A492).withOpacity(0.1),
            const Color(0xFFD3D0F1).withOpacity(0.1),
          ],
        ),
      ),
      child: child,
    );
  }
}
