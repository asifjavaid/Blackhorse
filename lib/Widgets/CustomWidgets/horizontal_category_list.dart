import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';

class HorizontalCategoryList extends StatelessWidget {
  final String title;
  final List<CategoriesData> options;
  final Function(String) callback;
  final Color? cardTitleColor;

  const HorizontalCategoryList({super.key, required this.options, required this.callback, required this.title, this.cardTitleColor});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: SizedBox(
            height: 108,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: options.length,
              itemBuilder: (context, index) => buildCategoryItem(options[index], index, cardTitleColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCategoryItem(CategoriesData category, int index, Color? cardTitleColor) {
    TextTheme textTheme = Theme.of(AppNavigation.currentContext!).textTheme;

    return Padding(
      padding: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
      child: GestureDetector(
        onTap: () => callback(category.title),
        child: Container(
          width: 144,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: category.bgColor, boxShadow: const [AppThemes.shadowDown]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (category.icon != null) HelperFunctions.giveBackgroundToIcon(category.icon!, bgColor: AppColors.actionColor400),
              const SizedBox(
                height: 8,
              ),
              Flexible(
                child: Text(
                  category.title,
                  textAlign: TextAlign.center,
                  style: textTheme.labelMedium!.copyWith(color: cardTitleColor ?? AppColors.neutralColor600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
