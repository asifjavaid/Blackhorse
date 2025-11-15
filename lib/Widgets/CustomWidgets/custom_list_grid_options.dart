import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_grid_options.dart';

// ignore: must_be_immutable
class ListGridOptions extends StatefulWidget {
  String? title;
  String? subtitle;
  bool elevated;
  final List<OptionModel> options;
  final Function callback;
  Color backgroundColor;
  double height;
  double width;
  List<GridOptions>? subCategoryOptions;
  EdgeInsets? margin;
  EdgeInsets? padding;
  bool? enableHelp;
  VoidCallback? enableHelpCallback;

  ListGridOptions({
    super.key,
    this.title,
    this.subtitle,
    this.enableHelp,
    this.enableHelpCallback,
    required this.elevated,
    required this.options,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.callback,
    this.margin,
    this.padding,
    this.subCategoryOptions,
  });

  @override
  ListGridOptionsState createState() => ListGridOptionsState();
}

class ListGridOptionsState extends State<ListGridOptions> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 16.0),
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(11),
          boxShadow: widget.elevated ? [AppThemes.shadowDown] : []),
      padding: widget.padding ??
          const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.title != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title!,
                      style: textTheme.headlineSmall,
                    ),
                    widget.enableHelp != null /* && widget.enableHelp!*/
                        ? GestureDetector(
                            onTap: widget.enableHelpCallback,
                            child: SvgPicture.asset(
                              "${AppConstant.assetIcons}info.svg",
                              semanticsLabel: 'Cycle Calendar Info',
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                )
              : const SizedBox.shrink(),
          widget.subtitle != null
              ? Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    widget.subtitle!,
                    style: textTheme.bodySmall!
                        .copyWith(color: AppColors.neutralColor500),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                  direction: Axis.horizontal,
                  children: widget.options
                      .asMap()
                      .entries
                      .map((e) => OptionWidget(
                            index: e.key,
                            options: widget.options,
                            callback: widget.callback,
                          ))
                      .toList()),
            ),
          ),
          if (widget.subCategoryOptions != null &&
              widget.subCategoryOptions!.isNotEmpty)
            ...widget.subCategoryOptions!
        ],
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final List<OptionModel> options;
  final int index;
  final Function callback;

  const OptionWidget(
      {super.key,
      required this.options,
      required this.index,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    final option = options[index];
    final isSelected = option.isSelected;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: GestureDetector(
        onTap: () => callback(index),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: option.value != null
                ? AppColors.primaryColor400
                : isSelected
                    ? AppColors.secondaryColor600
                    : AppColors.secondaryColor400,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  option.text,
                  style: textTheme.titleSmall!.copyWith(
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                ),
                if (option.value != null)
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        option.value.toString(),
                        style: textTheme.titleSmall!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
