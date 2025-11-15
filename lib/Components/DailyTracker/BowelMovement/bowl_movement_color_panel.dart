import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Understanding your stool colour', style: textTheme.headlineSmall),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Text.rich(
              TextSpan(
                children: [
                  subtitleText(
                      'Keeping track of your stool colour can give you important insights into your digestive health and overall well-being. Here’s a quick guide to help you understand what different stool colours might mean:\n\n',
                      textTheme),
                  titleText('Brown (normal):', textTheme),
                  subtitleText(
                      '	Great news! This is the typical colour of healthy stool and indicates your digestive system is functioning as it should. Keep doing what you’re doing!\n\n', textTheme),
                  titleText('Green: ', textTheme),
                  subtitleText(
                      'This can happen when food moves through your digestive tract quickly, leaving less time for bile to break down. It may also result from eating lots of leafy greens or taking iron supplements. If you’re feeling fine otherwise, it’s usually nothing to worry about.\n\n',
                      textTheme),
                  titleText('Yellow:', textTheme),
                  subtitleText(
                      ' Yellow stool may indicate your body is having trouble digesting fat, possibly due to conditions like celiac disease or a pancreas issue. If you notice a greasy or foul smell along with yellow stool, consult a healthcare provider.\n\n',
                      textTheme),
                  titleText('Orange: ', textTheme),
                  subtitleText(
                      'Eating foods rich in beta-carotene (like carrots) or certain medications can cause orange stool. If it persists, it might point to a bile issue, so consider consulting a healthcare provider.\n\n',
                      textTheme),
                  titleText('Black: ', textTheme),
                  subtitleText(
                      'This can be caused by certain foods (like black liquorice) or supplements (like iron), but it may also indicate bleeding in your upper digestive tract. If you can’t link it to diet or medications, consult a healthcare provider right away.\n\n',
                      textTheme),
                  titleText('Red:', textTheme),
                  subtitleText(
                      ' Bright red stool might result from eating red foods (like beets) but could also signal bleeding in your lower digestive tract, such as from haemorrhoids or other conditions. Persistent red stool should be evaluated by a healthcare provider.\n\n',
                      textTheme),
                  titleText('Pale or Clay:', textTheme),
                  subtitleText(
                      ' This could suggest a problem with bile flow, possibly linked to liver or gallbladder issues. If this persists, it’s a good idea to check with a healthcare provider.\n\nBy tracking the colour of your stool, you can get a better understanding of your gut health and digestion. If you ever have concerns or notice persistent changes, don’t hesitate to reach out to a healthcare provider for advice.',
                      textTheme),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  TextSpan titleText(title, textTheme) {
    return TextSpan(
      text: title,
      style: textTheme.titleSmall?.copyWith(
        color: AppColors.neutralColor600,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  TextSpan subtitleText(subtitle, textTheme) {
    return TextSpan(
      text: subtitle,
      style: textTheme.bodySmall?.copyWith(
        color: AppColors.neutralColor600,
        height: 1.60,
      ),
    );
  }
}
