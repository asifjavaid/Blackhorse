import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final bool isError;
  final TextSpan title;

  const CustomCheckboxListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                isError: isError,
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.actionColor600,
                fillColor: WidgetStateProperty.resolveWith<Color?>(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.actionColor600;
                    }
                    return Colors.white; // inactive background
                  },
                ),
                visualDensity: const VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
                side: isError
                    ? WidgetStateBorderSide.resolveWith(
                        (states) => const BorderSide(width: 2.0, color: AppColors.errorColor500),
                      )
                    : WidgetStateBorderSide.resolveWith(
                        (states) => const BorderSide(width: 2.0, color: AppColors.actionColor600),
                      ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const SizedBox(width: 4.0), // Adjust the space as per your need
              Expanded(child: RichText(text: title)),
            ],
          ),
        ),
        if (isError)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              'At Ekvi, we value your privacy and trust. To be able to continue, we ask you to agree to our terms & conditions and privacy policy',
              style: textTheme.labelMedium!.copyWith(color: AppColors.errorColor500),
            ),
          ),
      ],
    );
  }
}
