import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TimeOfDayWidget extends StatelessWidget {
  const TimeOfDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle('What does it mean?', textTheme),
            const SizedBox(height: 24),
            _buildContent(textTheme),
            _ExpandableTextWidget(
              textTheme: textTheme,
              text: 'Some variation is normal, especially with changes in diet, stress, or travel.',
            ),
            _ExpandableTextWidget(
              textTheme: textTheme,
              text: 'Consistent tracking helps you see the bigger picture over time.',
            ),
            _ExpandableTextWidget(
              textTheme: textTheme,
              text: 'Sudden or significant changes, like a lack of bowel movements or discomfort, should be discussed with a healthcare provider.',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Builds the title text
  Widget _buildTitle(String text, TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: textTheme.headlineSmall?.copyWith(
          color: AppColors.neutralColor600,
        ),
      ),
    );
  }

  // Builds the content section with text spans
  Widget _buildContent(TextTheme textTheme) {
    return Text.rich(
      TextSpan(
        children: [
          _buildTextSpan(
              'This graph shows the number of times you’ve tracked a bowel movement based on the time of day. By visualizing when your body tends to go, you can uncover patterns in your digestive health and daily rhythms. \n\n',
              FontWeight.w400,
              textTheme),
          _buildTextSpan('How to use this insight\n', FontWeight.w700, textTheme),
          _buildTextSpan(
              'Regular bowel movements at the same time of day can indicate a healthy digestive system. If patterns change suddenly, it may be worth exploring why.\n\nIf you’re experiencing digestive issues, this data can provide useful insights for discussions with your doctor, helping them pinpoint potential causes.\n\n',
              FontWeight.w400,
              textTheme),
          _buildTextSpan('Things to keep in mind', FontWeight.w700, textTheme),
        ],
      ),
    );
  }

  // Creates a text span with specific text and style
  TextSpan _buildTextSpan(String text, FontWeight fontWeight, TextTheme textTheme) {
    return TextSpan(
      text: text,
      style: textTheme.titleSmall?.copyWith(color: AppColors.neutralColor600, fontWeight: fontWeight),
    );
  }
}

class _ExpandableTextWidget extends StatelessWidget {
  final String text;
  const _ExpandableTextWidget({required this.textTheme, required this.text});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("• "),
          Expanded(
            child: Text(
              text,
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.neutralColor600,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
