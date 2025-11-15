import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/Bleeding/bleeding_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/veritcal_wheel_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Bleeding extends StatefulWidget {
  const Bleeding({super.key});

  @override
  State<Bleeding> createState() => _BleedingState();
}

class _BleedingState extends State<Bleeding> {
  List<String> options = List.generate(51, (index) => (index).toString());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<BleedingProvider>(
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GridOptions(
                    title: "When did it happen?",
                    elevated: true,
                    options: value.bleedingData.painTimeOptions,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    callback: (index) {
                      value.handleTimeSelection(value.bleedingData.painTimeOptions[index]);
                    }),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [AppThemes.shadowDown],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "How much did you bleed?",
                        textAlign: TextAlign.start,
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ...value.bleedingData.options.map((option) {
                        return bleedingContainer(option, value);
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GridOptions(
                  title: "Colour",
                  elevated: true,
                  options: value.bleedingData.colour,
                  width: 100.w,
                  height: 100.h,
                  backgroundColor: AppColors.whiteColor,
                  callback: (index) {
                    value.handleColourSelection(value.bleedingData.colour[index]);
                  },
                  subCategoryOptions: GridOptions(
                    title: "Consistency",
                    elevated: false,
                    options: value.bleedingData.consistency,
                    width: 100.w,
                    height: 100.h,
                    backgroundColor: AppColors.whiteColor,
                    padding: const EdgeInsets.only(top: 16),
                    margin: EdgeInsets.zero,
                    callback: (index) {
                      value.handleConsistencySelection(value.bleedingData.consistency[index]);
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [AppThemes.shadowDown],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Menstrual Pads",
                        textAlign: TextAlign.start,
                        style: textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("How many menstrual pads or Tampons did you go through today", textAlign: TextAlign.start, style: textTheme.bodySmall),
                      const SizedBox(
                        height: 16,
                      ),
                      NumberPickerWidget(
                        selectedBorder: const Border(
                          top: BorderSide(
                            color: AppColors.neutralColor300,
                            width: 0.5,
                          ),
                          bottom: BorderSide(
                            color: AppColors.neutralColor300,
                            width: 0.5,
                          ),
                        ),
                        widgetBorder: Border.all(color: AppColors.primaryColor400, width: 1),
                        widgetBorderRadius: BorderRadius.circular(12),
                        selectedBorderRadius: BorderRadius.circular(0),
                        selectedBgColor: Colors.white,
                        textStyle: const TextStyle(color: AppColors.neutralColor600, fontSize: 23, fontWeight: FontWeight.w400, decorationColor: AppColors.neutralColor600),
                        numberTextStyle: const TextStyle(color: AppColors.neutralColor400, fontSize: 18, fontWeight: FontWeight.w400, decorationColor: AppColors.neutralColor400),
                        options: options,
                        selected: value.bleedingData.pads.toString(),
                        onSelectedItemChanged: (int index) {
                          value.handlePadsSelection(int.parse(options[index]));
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  title: "Track Bleeding",
                  onPressed: () => value.handleSaveBleedingData(),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ));
  }
}

Widget bleedingContainer(OptionModel option, BleedingProvider value) {
  TextTheme textTheme = Theme.of(AppNavigation.currentContext!).textTheme;
  return Container(
    margin: EdgeInsets.only(
      top: 1.h,
    ),
    child: ElevatedButton(
      onPressed: () => value.handleIntensitySelection(option),
      style: ElevatedButton.styleFrom(
          shadowColor: Colors.grey.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          elevation: 0,
          backgroundColor: option.isSelected ? AppColors.secondaryColor600 : AppColors.secondaryColor400,
          textStyle: textTheme.titleSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            option.text,
            textAlign: option.trailingIcon != null ? TextAlign.left : TextAlign.center,
            style: textTheme.titleSmall!.copyWith(
              color: option.isSelected ? AppColors.whiteColor : AppColors.blackColor,
            ),
          ),
          option.trailingIcon!.endsWith("png") ? Image.asset(option.trailingIcon!, fit: BoxFit.fill) : SvgPicture.asset(option.trailingIcon!)
        ],
      ),
    ),
  );
}
