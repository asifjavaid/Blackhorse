import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectButton extends StatelessWidget {
  final EntryItem? item;
  final Includes? assets;
  const RedirectButton({required this.item, required this.assets, super.key});

  @override
  Widget build(BuildContext context) {
    final String? title = item?.fields["name"];
    final String? url = item?.fields["redirectUrl"];

    return CustomButton(
      buttonType: ButtonType.secondary,
        title: title ?? '',
        onPressed: () async {
          if (url != null && await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        });
  }
}
