import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewsCard extends StatelessWidget {
  final String? imagePath;
  final String? date;
  final String? readTime;
  final String? location;
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final int? thumbnailFlex;
  final int? textFlex;
  final int index;
  final int? maxLines;
  final bool isPaid; // New parameter to indicate if the content is paid

  const NewsCard({
    this.imagePath,
    required this.date,
    required this.readTime,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    this.thumbnailFlex,
    this.textFlex,
    required this.index,
    this.maxLines,
    required this.isPaid,
    this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: width ?? 300,
      height: height ?? 200,
      margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: const [AppThemes.shadowDown], color: AppColors.whiteColor),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onPressed,
          child: Ink(
            child: Column(
              children: [
                imagePath != null
                    ? Expanded(
                        flex: thumbnailFlex ?? 1,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                imagePath!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            if (isPaid) const Positioned(top: 8.0, right: 8.0, child: PremiumIconWidget()),
                          ],
                        ),
                      )
                    : Expanded(flex: thumbnailFlex ?? 1, child: const SizedBox()),
                Expanded(
                  flex: textFlex ?? 1,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            date != null
                                ? Row(
                                    children: [
                                      const Icon(AppCustomIcons.calendar, size: 16.0, color: AppColors.neutralColor500),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        date!,
                                        style: textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor500),
                                      )
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(width: 16.0),
                            readTime != null
                                ? Row(
                                    children: [
                                      const Icon(AppCustomIcons.time, size: 16.0, color: AppColors.neutralColor500),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        readTime!,
                                        style: textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor500),
                                      )
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            location != null
                                ? Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset("${AppConstant.assetIcons}location.svg", width: 16.0, height: 16, color: AppColors.neutralColor500),
                                        const SizedBox(width: 6.0),
                                        Expanded(
                                          child: Text(
                                            location!,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor500),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          title,
                          style: textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: maxLines ?? 1,
                        ),
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
