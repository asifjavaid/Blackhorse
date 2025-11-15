import 'package:flutter/material.dart';

class CustomGradientBackground extends StatelessWidget {
  final Widget child;
  const CustomGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.0, 0.0),
              radius: 0.8,
              colors: [
                Colors.white.withOpacity(0.4),
                Colors.white.withOpacity(0.0),
              ],
              stops: const [0.0, 0.98],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
              startAngle: 228 * 3.1416 / 180,
              colors: [
                const Color(0xFFF8E0A5).withOpacity(0.28),
                const Color(0xFFD3D0F1).withOpacity(0.14),
                const Color(0xFFF3A492).withOpacity(0.28),
                const Color(0xFFF3A492).withOpacity(0.28),
              ],
              stops: const [0.0, 0.49, 0.97, 1.0],
              center: const Alignment(1.1, -0.1),
            ),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
