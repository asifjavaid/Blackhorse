import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';

class GridRadioSelection extends StatefulWidget {
  final String title;
  final double? width;
  final ImpactGrid impactGrid;
  final Function(OptionModel, int) callback;

  const GridRadioSelection(
      {super.key,
      required this.title,
      this.width,
      required this.impactGrid,
      required this.callback});

  @override
  GridRadioSelectionState createState() => GridRadioSelectionState();
}

class GridRadioSelectionState extends State<GridRadioSelection> {
  List<String> columns = ["None", "Mild", "Mod", "Severe"];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(17),
          boxShadow: const [AppThemes.shadowDown]),
      child: Padding(
        padding: EdgeInsets.only(
            left: 0.06 * width,
            top: 0.03 * height,
            bottom: 0.03 * height,
            right: 0.06 * width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: textTheme.headlineSmall,
            ),
            SizedBox(
              height: 0.03 * height,
            ),
            _buildColumns(width),
            _buildRow(
                'Work',
                widget.impactGrid.workValue,
                (value) => widget.callback(OptionModel(text: "Work"), value),
                width),
            const Divider(
              thickness: 1,
              color: AppColors.primaryColor500,
            ),
            _buildRow(
                'Social Life',
                widget.impactGrid.socialLifeValue,
                (value) =>
                    widget.callback(OptionModel(text: "Social life"), value),
                width),
            const Divider(
              thickness: 1,
              color: AppColors.primaryColor500,
            ),
            _buildRow(
                'Sleep',
                widget.impactGrid.sleepValue,
                (value) => widget.callback(OptionModel(text: "Sleep"), value),
                width),
            const Divider(
              thickness: 1,
              color: AppColors.primaryColor500,
            ),
            _buildRow(
                'Quality of Life',
                widget.impactGrid.qualityOfLifeValue,
                (value) => widget.callback(
                    OptionModel(text: "Quality of life"), value),
                width),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
      String title, int value, Function(int) onChanged, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: Theme.of(AppNavigation.currentContext!)
                  .textTheme
                  .headlineMedium),
          SizedBox(
            width: 0.44 * width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRadioOption('None', 0, value, onChanged, width),
                _buildRadioOption('Mild', 1, value, onChanged, width),
                _buildRadioOption('Moderate', 2, value, onChanged, width),
                _buildRadioOption('Severe', 3, value, onChanged, width),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumns(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 0.44 * width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...columns.map(
                  (e) => Text(e,
                      style: Theme.of(AppNavigation.currentContext!)
                          .textTheme
                          .labelMedium),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String title, int radioValue, int groupValue,
      Function(int) onChanged, double width) {
    return GestureDetector(
        onTap: () => onChanged(radioValue),
        child: Container(
          width: 0.1 * width,
          height: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: AppColors.actionColor600),
          ),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: groupValue == radioValue
                  ? AppColors.actionColor600
                  : AppColors.whiteColor,
              border: Border.all(width: 2.0, color: AppColors.whiteColor),
            )),
          ),
        ));
  }
}
