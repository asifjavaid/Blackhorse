import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NumberPickerWidget extends StatefulWidget {
  final Color? selectedBgColor;
  final Color? widgetBgColor;
  final TextStyle? numberTextStyle;
  final BorderRadius? selectedBorderRadius;
  final BorderRadius? widgetBorderRadius;
  final Border? selectedBorder;
  final Border? widgetBorder;
  final List<String> options;
  final TextStyle? textStyle;
  final String selected;
  final Function(int) onSelectedItemChanged;

  const NumberPickerWidget(
      {super.key,
      this.selectedBgColor,
      this.widgetBgColor,
      this.selectedBorder,
      this.selectedBorderRadius,
      this.numberTextStyle,
      required this.options,
      this.textStyle,
      this.widgetBorderRadius,
      this.widgetBorder,
      required this.selected,
      required this.onSelectedItemChanged});

  @override
  NumberPickerWidgetState createState() => NumberPickerWidgetState();
}

class NumberPickerWidgetState extends State<NumberPickerWidget> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    int initialIndex = widget.options.indexOf(widget.selected);
    _scrollController = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: widget.widgetBgColor ?? Colors.transparent, borderRadius: widget.widgetBorderRadius, border: widget.widgetBorder),
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Stack(
              children: [
                ListWheelScrollView(
                    controller: _scrollController,
                    itemExtent: 40,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: widget.onSelectedItemChanged,
                    children: widget.options
                        .map((option) => Center(
                              child: Text(option.toString(), style: widget.numberTextStyle ?? textTheme.headlineSmall!.copyWith(color: AppColors.blackColor)),
                            ))
                        .toList()),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 5.h,
                    decoration: BoxDecoration(
                        color: widget.selectedBgColor ?? AppColors.secondaryColor600, borderRadius: widget.selectedBorderRadius ?? BorderRadius.circular(10), border: widget.selectedBorder),
                    child: Center(
                      child: Text(widget.selected, style: widget.textStyle ?? textTheme.headlineLarge!.copyWith(color: AppColors.whiteColor)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
