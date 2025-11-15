import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridCategories extends StatelessWidget {
  final String? title;
  final bool elevated;
  final List<CategoriesData> options;
  final Function(String) callback;
  final Color backgroundColor;
  final double height;
  final double width;
  final List<int> indicesWithLargeContent;
  final int? numberOfColumnsForGrid;

  const GridCategories({
    super.key,
    this.title,
    required this.indicesWithLargeContent,
    required this.elevated,
    required this.options,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.callback,
    this.numberOfColumnsForGrid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(17),
        boxShadow: elevated ? [AppThemes.shadowDown] : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(color: Colors.black, fontFamily: "LivvicMedium", fontSize: 18, fontWeight: FontWeight.w600),
            ),
          SizedBox(
            width: double.infinity,
            child: buildStaggeredGrid(),
          ),
        ],
      ),
    );
  }

  Widget buildStaggeredGrid() {
    return StaggeredGrid.count(
      crossAxisCount: numberOfColumnsForGrid ?? 10,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: List.generate(options.length, (index) => buildStaggeredGridTile(index)),
    );
  }

  Widget buildStaggeredGridTile(int index) {
    return StaggeredGridTile.count(
      crossAxisCellCount: indicesWithLargeContent.contains(index) ? 5 : 3,
      mainAxisCellCount: 3.2,
      child: GestureDetector(
        onTap: () => callback(options[index].title),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: options[index].bgColor,
              border: Border.all(
                width: 1,
                color: AppColors.whiteColor,
              ),
              boxShadow: const [AppThemes.shadowDown]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (options[index].icon != null) HelperFunctions.giveBackgroundToIcon(options[index].icon!, bgColor: AppColors.actionColor400),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  options[index].title,
                  textAlign: TextAlign.center,
                  style: Theme.of(AppNavigation.currentContext!).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
