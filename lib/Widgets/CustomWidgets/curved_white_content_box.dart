import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContentBox extends StatefulWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool listView;
  final bool? showShadow;
  final Border? border;
  final Color? bgColor;
  final EdgeInsets? padding;

  final CrossAxisAlignment? contentHorizontalAlignment;

  List<Widget>? children;
  ContentBox(
      {super.key,
      required this.children,
      required this.listView,
      this.width,
      this.height,
      this.contentHorizontalAlignment,
      this.borderRadius,
      this.showShadow,
      this.border,
      this.bgColor,
      this.padding});

  @override
  // ignore: library_private_types_in_public_api
  _ContentBoxState createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          border: widget.border,
          boxShadow: widget.showShadow ?? true ? const [AppThemes.shadowDown] : null,
          color: widget.bgColor ?? AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 12)),
        ),
        child: widget.listView
            ? ListView(
                children: widget.children ?? [],
              )
            : Column(
                crossAxisAlignment: widget.contentHorizontalAlignment ?? CrossAxisAlignment.center,
                children: widget.children ?? [],
              ),
      ),
    );
  }
}
