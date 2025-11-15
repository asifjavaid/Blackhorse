import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgCircleWidget extends StatefulWidget {
  final String? svgAssetPath;
  final double size;
  final Duration animationDuration;
  final Color? circleColor;
  final Color? circleBgColor;

  const SvgCircleWidget({
    super.key,
    this.svgAssetPath,
    this.size = 33,
    this.animationDuration = const Duration(milliseconds: 500),
    required this.circleColor,
    this.circleBgColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SvgCircleWidgetState createState() => _SvgCircleWidgetState();
}

class _SvgCircleWidgetState extends State<SvgCircleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: widget.circleColor ?? Colors.transparent, width: 1),
          color: widget.circleBgColor ?? Colors.transparent,
        ),
        child: widget.svgAssetPath != null
            ? Center(
                child: SvgPicture.asset(
                  widget.svgAssetPath!,
                  width: 13.6,
                  height: 17,
                  semanticsLabel: 'SVG Image',
                ),
              )
            : null,
      ),
    );
  }
}
