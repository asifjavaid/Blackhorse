import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';

class PainKillerDropdown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final String? selectedPainKillerLevel;
  final List<String> items;
  final String hintText;
  final bool isOpen;

  const PainKillerDropdown({
    super.key,
    required this.onChanged,
    this.selectedPainKillerLevel,
    required this.items,
    required this.isOpen,
    required this.hintText,
  });

  @override
  State<PainKillerDropdown> createState() => _PainKillerDropdownState();
}

class _PainKillerDropdownState extends State<PainKillerDropdown> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredItems = [];
  bool _isDropdownOpened = false;
  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _controller.text = widget.selectedPainKillerLevel ?? '';
    _focusNode.addListener(() {
      setState(() {
        _isDropdownOpened = _focusNode.hasFocus;
        if (_isDropdownOpened) {
          _filteredItems = widget.items; // Show all if focused
        }
      });
    });
  }

  void _onTextChanged(String text) {
    if (widget.onChanged != null) {
      widget.onChanged!(null);
    }
    setState(() {
      _isDropdownOpened = text.isNotEmpty;
      _filteredItems = widget.items.where((item) => item.toLowerCase().contains(text.toLowerCase())).toList();
    });
  }

  void _onItemSelected(String item) {
    setState(() {
      _controller.text = item;
      _isDropdownOpened = false;
    });
    widget.onChanged?.call(item);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: _buildContainerDecoration(),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.isOpen ? false : true,
            onChanged: _onTextChanged,
            style: textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: widget.isOpen ? AppColors.neutralColor200 : null,
              hintStyle: textTheme.titleSmall!.copyWith(color: AppColors.neutralColor500, fontStyle: FontStyle.italic),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              suffixIcon: const Icon(Icons.search, color: AppColors.actionColor600),
            ),
          ),
        ),
        if (_isDropdownOpened)
          Container(
              constraints: const BoxConstraints(maxHeight: 200),
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.primaryColor500),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  radius: const Radius.circular(10),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                  thumbColor: MaterialStateProperty.all(AppColors.primaryColor600),
                ),
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return InkWell(
                        onTap: () => _onItemSelected(item),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // custom padding
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item,
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )),
      ],
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
}
