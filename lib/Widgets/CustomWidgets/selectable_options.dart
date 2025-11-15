import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MultiSelectWidget extends StatefulWidget {
  final List<String> options;
  final Function(List<String>)? onSelectionChanged;
  final bool multiSelect;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle? textStyle;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final WrapAlignment wrapAlignment;

  const MultiSelectWidget({
    super.key,
    required this.options,
    this.onSelectionChanged,
    this.multiSelect = true,
    this.selectedBackgroundColor = AppColors.actionColor600,
    this.unselectedBackgroundColor = const Color(0xFFF3F4F6),
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = const Color(0xFF374151),
    this.borderColor = AppColors.actionColor600,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.margin = const EdgeInsets.all(4),
    this.textStyle,
    this.spacing = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.wrapAlignment = WrapAlignment.start,
  });

  @override
  State<MultiSelectWidget> createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  List<String> selectedOptions = [];

  void _toggleOption(String option) {
    setState(() {
      if (widget.multiSelect) {
        if (selectedOptions.contains(option)) {
          selectedOptions.remove(option);
        } else {
          selectedOptions.add(option);
        }
      } else {
        if (selectedOptions.contains(option)) {
          selectedOptions.clear();
        } else {
          selectedOptions.clear();
          selectedOptions.add(option);
        }
      }
    });

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(selectedOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.options.map((option) {
        final isSelected = selectedOptions.contains(option);

        return GestureDetector(
          onTap: () => _toggleOption(option),
          child: Container(
            margin: widget.margin,
            padding: widget.padding,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isSelected
                  ? widget.selectedBackgroundColor
                  : widget.unselectedBackgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: 1.5,
              ),
            ),
            child: Text(
              option,
              style: widget.textStyle?.copyWith(
                    color: isSelected
                        ? widget.selectedTextColor
                        : widget.unselectedTextColor,
                  ) ??
                  TextStyle(
                    color: isSelected
                        ? widget.selectedTextColor
                        : widget.unselectedTextColor,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
