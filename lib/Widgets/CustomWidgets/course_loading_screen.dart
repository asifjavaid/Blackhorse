import 'package:flutter/material.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:sizer/sizer.dart';

/// Simple pill helper built on ShimmerBox
class ShimmerPill extends StatelessWidget {
  const ShimmerPill({
    super.key,
    required this.width,
    this.height = 28,
    this.br = 20,
    this.baseOpacity,
    this.highlightOpacity,
    this.margin,
  });

  final double width;
  final double height;
  final double br;
  final double? baseOpacity;
  final double? highlightOpacity;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: width,
      height: height,
      borderRadius: br,
      baseOpacity: baseOpacity ?? 0.36,
      highlightOpacity: highlightOpacity ?? 0.78,
      margin: margin,
    );
  }
}

/// ---------- Shimmer primitives (no external deps) ----------
class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.baseOpacity = 0.36, // increased for visibility
    this.highlightOpacity = 0.78, // increased for visibility
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
              stops: const [0.28, 0.50, 0.72], // wider band for stronger read
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
    this.opacity = 0.36, // match stronger defaults
    this.highlightOpacity = 0.78, // match stronger defaults
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

class CourseLoadingScreen extends StatelessWidget {
  const CourseLoadingScreen({super.key});

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
                // ---------- Hero ----------
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: const AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ShimmerBox(borderRadius: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.0.h),

                // ---------- Tags ----------
                Wrap(
                  spacing: 2.w,
                  runSpacing: 0.8.h,
                  children: [
                    ShimmerPill(width: 18.w),
                    ShimmerPill(width: 22.w),
                    ShimmerPill(width: 16.w),
                  ],
                ),
                SizedBox(height: 2.0.h),

                // ---------- Title ----------
                ShimmerBox(width: 70.w, height: 26, borderRadius: 10),
                SizedBox(height: 0.8.h),
                ShimmerBox(width: 55.w, height: 26, borderRadius: 10),

                SizedBox(height: 1.6.h),

                // ---------- Description ----------
                ShimmerBox(width: 100.w, height: 12, borderRadius: 6),
                SizedBox(height: 0.7.h),
                ShimmerBox(width: 94.w, height: 12, borderRadius: 6),
                SizedBox(height: 0.7.h),
                ShimmerBox(width: 86.w, height: 12, borderRadius: 6),
                SizedBox(height: 1.0.h),
                // Read more hint
                ShimmerBox(width: 20.w, height: 12, borderRadius: 6),

                SizedBox(height: 2.0.h),

                // ---------- CTA ----------
                ShimmerBox(width: 100.w, height: 50, borderRadius: 28),

                SizedBox(height: 2.0.h),

                // ---------- Modules list ----------
                ...List.generate(
                  7,
                  (i) => Padding(
                    padding: EdgeInsets.only(bottom: 1.6.h),
                    child: _ModuleSkeletonCard(dim: i >= 3), // later modules slightly dimmed
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModuleSkeletonCard extends StatelessWidget {
  const _ModuleSkeletonCard({required this.dim});

  final bool dim;

  @override
  Widget build(BuildContext context) {
    final baseOpacity = dim ? 0.28 : 0.36;
    final hiOpacity = dim ? 0.64 : 0.78;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card body
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: "Module x" + progress chip
                Row(
                  children: [
                    ShimmerBox(
                      width: 24.w,
                      height: 12,
                      borderRadius: 8,
                      baseOpacity: baseOpacity,
                      highlightOpacity: hiOpacity,
                    ),
                    const Spacer(),
                    ShimmerPill(
                      width: 14.w,
                      height: 22,
                      baseOpacity: baseOpacity,
                      highlightOpacity: hiOpacity,
                    ),
                  ],
                ),
                SizedBox(height: 1.0.h),
                // Title lines
                ShimmerBox(
                  width: 58.w,
                  height: 16,
                  borderRadius: 8,
                  baseOpacity: baseOpacity,
                  highlightOpacity: hiOpacity,
                ),
                SizedBox(height: 0.6.h),
                ShimmerBox(
                  width: 40.w,
                  height: 14,
                  borderRadius: 8,
                  baseOpacity: baseOpacity,
                  highlightOpacity: hiOpacity,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
