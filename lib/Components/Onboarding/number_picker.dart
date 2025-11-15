import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class NumberPickerOnboarding extends StatelessWidget {
  final String selectedNumber;
  final Function(int) onSelectedItemChanged;

  const NumberPickerOnboarding({
    super.key,
    required this.selectedNumber,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final int selectedNumberParsed = int.tryParse(selectedNumber) ?? 0;
    final FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: selectedNumberParsed);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 33),
      child: SizedBox(
        height: 250,
        child: ListWheelScrollView.useDelegate(
          controller: scrollController,
          itemExtent: 40,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: onSelectedItemChanged,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              return Column(
                children: [
                  if (index == selectedNumberParsed)
                    Divider(
                      height: 0.3,
                      color: AppColors.blackColor.withOpacity(0.1),
                    ),
                  Center(
                    child: Text(
                      index.toString(),
                      style: index == selectedNumberParsed ? textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w600) : textTheme.headlineLarge!.copyWith(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                  if (index == selectedNumberParsed)
                    Divider(
                      height: 0.3,
                      color: AppColors.blackColor.withOpacity(0.1),
                    ),
                ],
              );
            },
            childCount: 100,
          ),
        ),
      ),
    );
  }
}
