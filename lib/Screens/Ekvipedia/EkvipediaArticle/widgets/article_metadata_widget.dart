import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';

class ArticleMetaData extends StatelessWidget {
  final String? title;
  final String? preview;
  final String? date;
  final String? readTime;
  final List<String>? tags;
  const ArticleMetaData({super.key, required this.title, required this.preview, required this.readTime, required this.date, required this.tags});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(AppCustomIcons.calendar, size: 16.0, color: AppColors.neutralColor500),
                const SizedBox(width: 6.0),
                date != null
                    ? Text(
                        date!,
                        style: textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor500),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 8.0),
                const Icon(AppCustomIcons.time, size: 16.0, color: AppColors.neutralColor500),
                const SizedBox(width: 6.0),
                readTime != null
                    ? Text(
                        readTime!,
                        style: textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor500),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        tags != null
            ? SizedBox(
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: tags!
                      .map((option) => TagWidget(
                            option: option,
                            callback: () {},
                          ))
                      .toList(),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 32,
        ),
        title != null
            ? Text(
                title!,
                style: textTheme.displayLarge,
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 32,
        ),
        preview != null
            ? Text(
                preview!,
                style: textTheme.displayMedium,
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}

class TagWidget extends StatelessWidget {
  final String option;
  final VoidCallback callback;

  const TagWidget({super.key, required this.option, required this.callback});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Text(
            option,
            style: textTheme.labelMedium!.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
