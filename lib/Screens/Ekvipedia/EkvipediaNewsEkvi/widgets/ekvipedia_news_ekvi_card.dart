import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/assets.dart';

class EkvipediaNewsEkviCard extends StatelessWidget {
  final String? imagePath;
  final String? date;
  final String? readTime;
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final int? thumbnailFlex;
  final int? textFlex;

  const EkvipediaNewsEkviCard({
    required this.imagePath,
    this.date,
    this.readTime,
    required this.title,
    required this.onPressed,
    this.height,
    this.thumbnailFlex,
    this.textFlex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: height ?? 100,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: const [AppThemes.shadowDown], color: AppColors.whiteColor),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onPressed,
          child: Ink(
            child: Row(
              children: [
                Expanded(
                  flex: thumbnailFlex ?? 29,
                  child: imagePath != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                          child: Image.network(
                            imagePath!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Expanded(
                  flex: textFlex ?? 71,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                if (date != null) ...{
                                  SvgPicture.asset(
                                    Assets.customiconsCalendar,
                                    color: AppColors.neutralColor500,
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    date ?? "",
                                    style: textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor500),
                                  ),
                                  const SizedBox(width: 16.0)
                                },
                                readTime != null
                                    ? Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.customiconsTime,
                                            color: AppColors.neutralColor500,
                                            height: 16,
                                            width: 16,
                                          ),
                                          const SizedBox(width: 6.0),
                                          Text(
                                            readTime!,
                                            style: textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor500),
                                          )
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                        Text(title, style: textTheme.titleSmall),
                      ],
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
