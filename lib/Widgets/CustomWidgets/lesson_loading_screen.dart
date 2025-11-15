import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// ---------- Shimmer primitives (no external deps) ----------
class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.baseOpacity = 0.36,
    this.highlightOpacity = 0.78,
    this.margin,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final double baseOpacity;
  final double highlightOpacity;
  final EdgeInsetsGeometry? margin;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Colors.white.withOpacity(widget.baseOpacity);
    final highlight = Colors.white.withOpacity(widget.highlightOpacity);

    final child = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
    );

    // Moving highlight using ShaderMask over the base box
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            final dx = bounds.width * 2 * _c.value;
            final rect = Rect.fromLTWH(-bounds.width + dx, 0, bounds.width * 3, bounds.height);

            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [base, highlight, base],
              stops: const [0.28, 0.50, 0.72],
            ).createShader(rect);
          },
          child: child,
        );
      },
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle({
    super.key,
    required this.size,
    this.opacity = 0.36,
    this.highlightOpacity = 0.78,
    this.margin,
  });

  final double size;
  final double opacity;
  final double highlightOpacity;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: size,
      height: size,
      borderRadius: size / 2,
      baseOpacity: opacity,
      highlightOpacity: highlightOpacity,
      margin: margin,
    );
  }
}

/// ---------- Screen ----------
class LessonLoadingScreen extends StatelessWidget {
  const LessonLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Media placeholder (works for video or header image)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ShimmerBox(borderRadius: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.2.h),

                // Title & a couple lines (works for article/audio title)
                ShimmerBox(width: 65.w, height: 22, borderRadius: 10),
                SizedBox(height: 1.2.h),
                ShimmerBox(width: 45.w, height: 16, borderRadius: 8),

                SizedBox(height: 2.0.h),

                // Paragraph lines (article text placeholder)
                ...List.generate(
                  4,
                  (i) => ShimmerBox(
                    width: (i == 3) ? 60.w : 100.w,
                    height: 12,
                    borderRadius: 6,
                    margin: EdgeInsets.only(bottom: 0.9.h),
                  ),
                ),

                SizedBox(height: 2.0.h),

                // Notes / prompt card + CTA (shared across types)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withOpacity(0.12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          ShimmerBox(width: 48.w, height: 14, borderRadius: 8),
                          const Spacer(),
                          const ShimmerCircle(size: 28),
                        ],
                      ),
                      SizedBox(height: 1.6.h),
                      ShimmerBox(width: 100.w, height: 46, borderRadius: 28),
                    ],
                  ),
                ),

                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
