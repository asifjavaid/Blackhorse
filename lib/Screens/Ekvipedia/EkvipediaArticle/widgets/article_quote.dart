import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ArticleQuote extends StatelessWidget {
  final EntryItem? item;

  const ArticleQuote({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    String? quote = item?.fields["quote"];
    String? source = item?.fields["source"];

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote ?? "",
            style: textTheme.displayMedium!.copyWith(color: AppColors.actionColor600),
          ),
          Text(
            source ?? "",
            style: textTheme.displaySmall!.copyWith(color: AppColors.actionColor600),
          ),
        ],
      ),
    );
  }
}
