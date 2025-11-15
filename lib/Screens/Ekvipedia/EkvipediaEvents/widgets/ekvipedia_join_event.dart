import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EkvipediaJoinEvent extends StatelessWidget {
  final String url;
  final String? title;
  const EkvipediaJoinEvent({required this.title, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        buttonType: ButtonType.secondary,
        title: title ?? '',
        onPressed: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        });
  }
}
