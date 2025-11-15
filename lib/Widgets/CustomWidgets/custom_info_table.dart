import 'package:ekvi/Models/DailyTracker/BodyPain/body_pain_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///
/// Added some customizations to the default info table for filled and not filled.
///

class CustomInfoTable extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<PartOfLifeEffect>? partOfLifeEffects;
  final bool elevated;
  final Color backgroundColor;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool? enableHelp;
  final VoidCallback? enableHelpCallback;

  const CustomInfoTable({
    super.key,
    this.title,
    this.subtitle,
    this.partOfLifeEffects,
    this.enableHelp,
    this.enableHelpCallback,
    required this.elevated,
    required this.width,
    required this.height,
    required this.backgroundColor,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: EdgeInsets.only(
            left: 0.05 * width,
            top: 0.03 * height,
            bottom: 0.03 * height,
            right: 0.05 * width),
        child: Column(
          children: [
            if (title != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    style: textTheme.headlineSmall,
                  ),
                  if (enableHelp != null && enableHelp!)
                    GestureDetector(
                      onTap: enableHelpCallback,
                      child: SvgPicture.asset(
                        "${AppConstant.assetIcons}info.svg",
                        semanticsLabel: 'Cycle Calendar Info',
                        width: 24,
                      ),
                    )
                ],
              ),
            if (subtitle != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  subtitle!,
                  style: textTheme.bodySmall!
                      .copyWith(color: AppColors.neutralColor500),
                ),
              ),
            SizedBox(
              height: 0.03 * height,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ...AppStrings.getPainTypes().map((value) {
                return Container(
                  width: 0.12 * width,
                  decoration: BoxDecoration(
                    color: value.filled
                        ? AppColors.primaryColor400
                        : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23)),
                  ),
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    value.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(AppNavigation.currentContext!)
                        .textTheme
                        .labelMedium,
                  ),
                );
              }),
            ]),
            ...partOfLifeEffects!.map((e) {
              return Column(
                children: [
                  _ContentTitles(
                    value: e,
                    width: width,
                    isFilled: e == partOfLifeEffects?.last,
                  ),
                  if (e != partOfLifeEffects?.last)
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: AppColors.primaryColor500,
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ContentTitles extends StatelessWidget {
  const _ContentTitles(
      {required this.value, required this.width, required this.isFilled});
  final PartOfLifeEffect value;
  final double width;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value.type ?? '',
            style:
                Theme.of(AppNavigation.currentContext!).textTheme.titleSmall),
        SizedBox(
          width: 0.48 * width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor400,
                  borderRadius: isFilled
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(23),
                          bottomRight: Radius.circular(23))
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: isFilled ? 10 : 8.0),
                  child: _buildTitlesOption('None', value.none ?? "0", width),
                ),
              ),
              _buildTitlesOption('Mild', value.mild ?? "0", width),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor400,
                  borderRadius: isFilled
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(23),
                          bottomRight: Radius.circular(23))
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: isFilled ? 10 : 8.0),
                  child:
                      _buildTitlesOption('Moderate', value.mod ?? "0", width),
                ),
              ),
              _buildTitlesOption('Severe', value.severe ?? '0', width),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitlesOption(String title, var value, double width) {
    return SizedBox(
      width: 0.12 * width,
      child: Text(
        value.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}

///
/// PainTypesModel will use only the title and filled for selected area.
///
class PainTypesModel {
  String title;
  bool filled;
  PainTypesModel({required this.title, required this.filled});
}
