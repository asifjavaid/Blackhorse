import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DosageField extends StatefulWidget {
  final TextEditingController dosageController;
  final String selectedEntity;
  final ValueChanged<String> onEntityChanged;
  final ValueChanged<String?>? onDosageChanged;

  final FormFieldValidator<String>? validator;
  final bool isOpen;

  const DosageField({
    super.key,
    required this.dosageController,
    required this.selectedEntity,
    required this.onEntityChanged,
    required this.onDosageChanged,
    this.validator,
    required this.isOpen,
  });

  @override
  State<DosageField> createState() => _DosageFieldState();
}

class _DosageFieldState extends State<DosageField> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    const entities = [
      'mg',
      'IU',
      'mcg',
      'mcg/hr',
      'mcg/ml',
      'mEq',
      'mg/g',
      'mg/ml',
      'mL',
      'g',
      'mg/cm²',
      'µg',
      'pill',
      'patch',
      'drop',
      'mL/hr',
      'mg/kg',
    ];
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: widget.isOpen ? AppColors.primaryColor400 : AppColors.neutralColor200,
        border: Border.all(
          color: widget.isOpen ? Colors.transparent : AppColors.actionColor600,
        ),
        borderRadius: BorderRadius.circular(36),
      ),
      padding: const EdgeInsets.only(left: 16, right: 12),
      child: IgnorePointer(
        ignoring: !widget.isOpen,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.dosageController,
                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                style: textTheme.bodyMedium?.copyWith(color: AppColors.neutralColor600),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: 'Dosage per unit',
                  hintStyle: textTheme.titleSmall!.copyWith(color: AppColors.neutralColor500, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                ),
                validator: widget.validator,
                onChanged: widget.onDosageChanged,
              ),
            ),
            VerticalDivider(
              color: widget.isOpen ? AppColors.primaryColor600 : AppColors.actionColor600,
              thickness: 0.8,
              indent: 10,
              endIndent: 10,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                value: widget.selectedEntity,
                isExpanded: false,
                isDense: true,
                onChanged: (val) {
                  if (val != null) widget.onEntityChanged(val);
                },
                items: entities
                    .map((unit) => DropdownMenuItem<String>(
                          value: unit,
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 63,
                            child: Text(
                              unit,
                              textAlign: TextAlign.center,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.neutralColor600,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                buttonStyleData: const ButtonStyleData(
                  // width: 65,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
                dropdownStyleData: DropdownStyleData(
                  elevation: 10,
                  maxHeight: 180,
                  padding: EdgeInsets.zero,
                  scrollPadding: EdgeInsets.zero,
                  offset: const Offset(0, -4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor600),
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    thumbVisibility: MaterialStateProperty.all(false),
                    thickness: MaterialStateProperty.all(0),
                    radius: const Radius.circular(8),
                    thumbColor: MaterialStateProperty.all(AppColors.primaryColor600),
                    trackVisibility: MaterialStateProperty.all(true),
                    crossAxisMargin: 2,
                    mainAxisMargin: 4,
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: widget.isOpen
                      ? Icon(
                          _isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 28,
                          color: AppColors.actionColor600,
                        )
                      : const SizedBox.shrink(),
                  iconSize: widget.isOpen ? 28 : 0,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  // height: 30,
                ),
                onMenuStateChange: (isOpen) {
                  setState(() {
                    _isDropdownOpen = isOpen;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
