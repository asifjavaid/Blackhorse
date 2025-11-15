import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';

class FrequencyDropdown extends StatefulWidget {
  final String? title;
  final ValueChanged<int?>? onChanged;
  final int? selectedFrequencyLevel;

  const FrequencyDropdown({
    super.key,
    this.title,
    required this.onChanged,
    this.selectedFrequencyLevel,
  });

  @override
  State<FrequencyDropdown> createState() => _FrequencyDropdownState();
}

class _FrequencyDropdownState extends State<FrequencyDropdown> {
  bool _isDropdownOpened = false;

  // Private configuration classes
  late final _DropdownButtonConfig _buttonConfig;
  late final _DropdownStyleConfig _styleConfig;
  late final _DropdownItemConfig _itemConfig;

  @override
  void initState() {
    super.initState();
    _buttonConfig = _DropdownButtonConfig(context);
    _styleConfig = _DropdownStyleConfig();
    _itemConfig = _DropdownItemConfig();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _isDropdownOpened ? 350 : 130,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: _buildContainerDecoration(),
      child: Theme(
        data: Theme.of(context).copyWith(platform: TargetPlatform.android),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Text(
                widget.title!,
                style: textTheme.bodyMedium,
              ),
            const SizedBox(height: 16),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                selectedItemBuilder: _itemConfig.buildSelectedItems,
                items: _itemConfig.buildDropdownItems(),
                value: widget.selectedFrequencyLevel?.toString(),
                onChanged: _handleDropdownChange,
                buttonStyleData: _buttonConfig.buttonStyle,
                iconStyleData: _buildIconStyleData(),
                dropdownStyleData: _styleConfig.dropdownStyle,
                menuItemStyleData: _styleConfig.menuItemStyle,
                onMenuStateChange: _handleMenuStateChange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDropdownChange(String? value) {
    if (widget.onChanged != null) {
      widget.onChanged!(int.tryParse(value!));
    }
  }

  IconStyleData _buildIconStyleData() {
    return IconStyleData(
      icon: Icon(
        _isDropdownOpened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
      ),
      iconSize: 28,
      iconEnabledColor: AppColors.actionColor600,
      iconDisabledColor: AppColors.actionColor600,
    );
  }

  ShapeDecoration _buildContainerDecoration() {
    return ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadows: const [AppThemes.shadowDown],
    );
  }

  void _handleMenuStateChange(bool isOpen) {
    setState(() {
      _isDropdownOpened = isOpen;
    });
  }
}

// Private configuration class for dropdown button styling
class _DropdownButtonConfig {
  final ButtonStyleData buttonStyle;

  _DropdownButtonConfig(BuildContext context)
      : buttonStyle = ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.primaryColor500,
              width: 1,
            ),
            color: AppColors.primaryColor400,
          ),
        );
}

// Private configuration class for dropdown style
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
            thumbColor: MaterialStateProperty.all(
              AppColors.primaryColor600,
            ),
          ),
        ),
        menuItemStyle = const MenuItemStyleData(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
        );
}

// Private configuration class for dropdown items
class _DropdownItemConfig {
  List<Widget> buildSelectedItems(BuildContext context) {
    return List.generate(10, (index) => (index + 1).toString()).map<Widget>((String item) => _buildSelectedItemContainer(item)).toList();
  }

  List<DropdownMenuItem<String>> buildDropdownItems() {
    return List.generate(10, (index) => (index + 1).toString()).map((String item) => _buildDropdownItem(item)).toList();
  }

  Container _buildSelectedItemContainer(String item) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(item, textAlign: TextAlign.start),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Center(
        child: Text(
          item,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
