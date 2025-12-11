import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_events_details_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/assets.dart';

class EventsMetaData extends StatelessWidget {
  final EventDetailsModel model;
  const EventsMetaData({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Wrap(
            direction: Axis.horizontal,
            children: EkvipediaContentEntries.getTags(model.item, model.assets)
                .map((option) => TagWidget(
                      option: option,
                      callback: () {},
                    ))
                .toList(),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        model.eventTitle != null
            ? Text(
                model.eventTitle!,
                style: textTheme.displayLarge,
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.customiconsCalendar,
              color: AppColors.neutralColor600,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 16.0),
            HelperFunctions.formatDateTime(model.item?.fields["date"]) != null
                ? Text(
                    HelperFunctions.formatDateTime(model.item?.fields["date"])!,
                    style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor600),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        model.timeData != null
            ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.customiconsTime,
                      color: AppColors.neutralColor600,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      model.timeData!,
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor600),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("${AppConstant.assetIcons}location.svg", width: 24.0, color: AppColors.neutralColor600),
              const SizedBox(width: 16.0),
              model.item!.fields["location"] != null
                  ? Expanded(
                      child: Text(
                        model.item!.fields["location"] ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor600),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("${AppConstant.assetIcons}message.svg", width: 24.0, color: AppColors.neutralColor600),
            const SizedBox(width: 16.0),
            Text(
              model.item?.fields['language'] ?? "",
              style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400, color: AppColors.neutralColor600),
            )
          ],
        ),
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
