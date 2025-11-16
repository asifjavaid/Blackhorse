import 'package:flutter/material.dart';

Widget iconBuilder(Widget icon, Color backgroundColor) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(60),
      color: backgroundColor,
    ),
    child: icon,
  );
}
