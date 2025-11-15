import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MovementDropdown<T> extends StatefulWidget {
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T?)? onChanged;
  final String? title;

  const MovementDropdown({
    super.key,
    this.options = const [],
    required this.value,
    required this.getLabel,
    required this.onChanged,
    this.title,
  });

  @override
  State<MovementDropdown<T>> createState() => _StyledDropdownState<T>();
}

class _StyledDropdownState<T> extends State<MovementDropdown<T>> {
  bool _isDropdownOpened = false;

  late final _DropdownButtonConfig _buttonConfig;
  late final _DropdownStyleConfig _styleConfig;

  @override
  void initState() {
    super.initState();
    _buttonConfig = _DropdownButtonConfig(context);
    _styleConfig = _DropdownStyleConfig();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _isDropdownOpened ? 280 : 56,
      child: Theme(
        data: Theme.of(context).copyWith(platform: TargetPlatform.android),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<T>(
                isExpanded: true,
                value: widget.value,
                items: _buildDropdownItems(textTheme),
                selectedItemBuilder: (ctx) => widget.options.map((item) => _buildSelectedItem(item, textTheme)).toList(),
                onChanged: widget.onChanged,
                buttonStyleData: _buttonConfig.buttonStyle,
                iconStyleData: _buildIconStyleData(),
                dropdownStyleData: _styleConfig.dropdownStyle,
                menuItemStyleData: _styleConfig.menuItemStyle,
                onMenuStateChange: (open) => setState(() => _isDropdownOpened = open),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------  Helpers ----------------------------------------------------------

  Widget _buildSelectedItem(T item, TextTheme textTheme) => Container(
        alignment: Alignment.centerLeft,
        child: Text(widget.getLabel(item), style: textTheme.bodySmall),
      );

  DropdownMenuItem<T> _buildDropdownItem(T item, TextTheme textTheme) => DropdownMenuItem<T>(
        value: item,
        child: Center(
          child: Text(
            widget.getLabel(item),
            textAlign: TextAlign.center,
            style: textTheme.bodySmall,
          ),
        ),
      );

  List<DropdownMenuItem<T>> _buildDropdownItems(TextTheme textTheme) => widget.options.map((item) => _buildDropdownItem(item, textTheme)).toList();

  IconStyleData _buildIconStyleData() => IconStyleData(
        icon: Icon(_isDropdownOpened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
        iconSize: 28,
        iconEnabledColor: AppColors.actionColor600,
        iconDisabledColor: AppColors.actionColor600,
      );
}

// ---------------- Style helper classes (unchanged from FrequencyDropdown) ---
class _DropdownButtonConfig {
  final ButtonStyleData buttonStyle;
  _DropdownButtonConfig(BuildContext context)
      : buttonStyle = ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.primaryColor500, width: 1),
            color: AppColors.primaryColor400,
          ),
        );
}

class _DropdownStyleConfig {
  final DropdownStyleData dropdownStyle;
  final MenuItemStyleData menuItemStyle;
  _DropdownStyleConfig()
      : dropdownStyle = DropdownStyleData(
          elevation: 10,
          maxHeight: 232,
          offset: const Offset(0, -4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            border: Border.all(color: AppColors.primaryColor500),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            thickness: MaterialStateProperty.all(10),
            thumbVisibility: MaterialStateProperty.all(true),
            thumbColor: MaterialStateProperty.all(AppColors.primaryColor600),
          ),
        ),
        menuItemStyle = const MenuItemStyleData(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
        );
}
