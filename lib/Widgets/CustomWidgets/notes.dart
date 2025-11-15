import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Notes extends StatefulWidget {
  final String? title;
  final String? placeholderText;
  final FontStyle? placeHolderFontStyle;

  final String notesText;

  final void Function(String) callback;

  const Notes({super.key, required this.notesText, required this.callback, this.title, this.placeholderText, this.placeHolderFontStyle});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => AppNavigation.navigateTo(AppRoutes.notesRoute, arguments: ScreenArguments(notesCallback: widget.callback, notes: widget.notesText)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          boxShadow: [AppThemes.shadowDown],
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title ?? "Notes",
                style: textTheme.headlineSmall,
              ),
              GestureDetector(
                  child: SvgPicture.asset(
                    '${AppConstant.assetIcons}edit.svg',
                    height: 36,
                  ),
                  onTap: () => AppNavigation.navigateTo(AppRoutes.notesRoute, arguments: ScreenArguments(notesCallback: widget.callback, notes: widget.notesText)))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.notesText.isEmpty ? widget.placeholderText ?? "Leave notes here. It will only be visible to you." : widget.notesText,
            style: textTheme.bodySmall!.copyWith(color: AppColors.neutralColor500, fontStyle: widget.placeholderText != null ? widget.placeHolderFontStyle ?? FontStyle.italic : null),
          ),
        ]),
      ),
    );
  }
}
