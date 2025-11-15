import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Labels extends StatelessWidget {
  final List<Label> labels;
  final Color? backgroundColor;
  const Labels({super.key, required this.labels, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor ?? AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: labels
              .map(
                (e) => Row(
                  children: [
                    SizedBox(
                      width: 1.w,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: e.color,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      e.label,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Label {
  String label;
  Color color;

  Label({required this.color, required this.label});
}
