import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';

class CustomFieldDropdown extends StatefulWidget {
  final List<String>? options;
  final String value;
  final String Function(String) getLabel;
  final void Function(String?)? onChanged;

  const CustomFieldDropdown({super.key, this.options = const [], required this.getLabel, required this.value, required this.onChanged});

  @override
  State<CustomFieldDropdown> createState() => _CustomFieldDropdownState();
}

class _CustomFieldDropdownState<T> extends State<CustomFieldDropdown> {
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: const InputDecoration(
            fillColor: AppColors.primaryColor400,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(36)), borderSide: BorderSide.none),
            contentPadding: EdgeInsets.only(left: 20, right: 24, top: 5, bottom: 5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              menuMaxHeight: 40.h,
              borderRadius: BorderRadius.circular(9),
              value: widget.value,
              style: Theme.of(context).textTheme.titleSmall,
              icon: widget.onChanged != null
                  ? SvgPicture.asset(
                      Assets.customiconsArrowDown,
                      height: 16,
                      width: 16,
                      color: AppColors.actionColor600,
                    )
                  : null,
              onChanged: widget.onChanged,
              items: widget.options?.map((String value) {
                return DropdownMenuItem(
                  alignment: Alignment.center,
                  value: value,
                  child: Text(
                    widget.getLabel(value),
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
