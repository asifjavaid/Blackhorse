import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final ButtonType? buttonType;
  final Color? color;
  final Color? disabledColor;
  final Color? fontColor;
  final double? elevation;
  final double? disabledElevation;

  final Size? minSize;
  final Size? maxSize;

  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;

  final Icon? tralingIcon;
  final Icon? icon;
  final Icon? leadingIcon;

  final VoidCallback? onPressed;
  final RoundedRectangleBorder? shapeBorder;
  final bool? titleAtStart;

  const CustomButton(
      {super.key,
      required this.title,
      this.color,
      this.disabledColor,
      this.fontColor,
      this.elevation,
      this.disabledElevation,
      this.minSize,
      this.maxSize,
      this.fontFamily,
      this.fontSize,
      this.fontWeight,
      this.tralingIcon,
      this.icon,
      this.leadingIcon,
      this.onPressed,
      this.shapeBorder,
      this.titleAtStart,
      this.buttonType = ButtonType.primary});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return widget.buttonType == ButtonType.primary
        ? ElevatedButton(
            onPressed: widget.onPressed,
            style: _buildButtonStyle(context),
            child: SizedBox(
              width: widget.minSize?.width,
              child: Row(children: _buildRowChildren()),
            ),
          )
        : OutlinedButton(
            onPressed: widget.onPressed,
            style: _buildButtonStyle(context),
            child: SizedBox(
              width: widget.minSize?.width,
              child: Row(children: _buildRowChildren()),
            ),
          );
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      elevation: widget.elevation,
      backgroundColor: widget.color,
      minimumSize: widget.minSize,
      maximumSize: widget.maxSize,
      shape: widget.shapeBorder,
      padding: EdgeInsets.zero,
      foregroundColor: widget.fontColor,
    ).merge(widget.buttonType == ButtonType.primary ? Theme.of(context).elevatedButtonTheme.style : Theme.of(context).outlinedButtonTheme.style);
  }

  List<Widget> _buildRowChildren() {
    return [
      if (widget.leadingIcon != null) ...[
        Expanded(
          flex: 1,
          child: widget.leadingIcon!,
        ),
        // SizedBox(width: 5.w),
      ] else if (widget.tralingIcon != null) ...[
        SizedBox(width: 3.w),
      ],
      Expanded(
        flex: 5,
        child: Text(
          widget.title,
          textAlign: (widget.leadingIcon != null || widget.tralingIcon != null) ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontFamily: widget.fontFamily,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
        ),
      ),
      if (widget.tralingIcon != null) ...[
        SizedBox(width: 2.w),
        widget.tralingIcon!,
        SizedBox(width: 4.w),
      ],
      if (widget.icon != null) ...[
        Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: widget.icon!,
        ),
      ],
    ];
  }
}
