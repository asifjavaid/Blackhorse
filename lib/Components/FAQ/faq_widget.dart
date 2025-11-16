import 'package:ekvi/Models/FAQs/faq_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';

class FAQWidget extends StatefulWidget {
  final FAQ faq;

  const FAQWidget({super.key, required this.faq});

  @override
  FAQWidgetState createState() => FAQWidgetState();
}

class FAQWidgetState extends State<FAQWidget> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _sizeFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeFactor = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            title: Text(
              widget.faq.question,
              style: textTheme.titleSmall!.copyWith(color: AppColors.blackColor, fontWeight: FontWeight.w600),
            ),
            trailing: SvgPicture.asset(
                _isExpanded ?
                Assets.customiconsArrowUp :
                Assets.customiconsArrowDown,
                height: 16.0,
                width: 16.0,
                color: AppColors.blackColor
            ),
          ),
          SizeTransition(
            sizeFactor: _sizeFactor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.faq.answer,
                  style: textTheme.bodySmall!.copyWith(color: AppColors.blackColor),
                ),
              ),
            ),
          ),
          const Divider(height: 1.0, thickness: 1.0, color: AppColors.neutralColor200),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
