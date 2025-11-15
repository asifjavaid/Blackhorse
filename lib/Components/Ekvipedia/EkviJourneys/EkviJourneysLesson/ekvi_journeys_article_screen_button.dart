import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';

class EkviJourneysArticleScreenButton extends StatelessWidget {
  const EkviJourneysArticleScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EkviJourneysProvider>(context, listen: false);

    return Container(
      height: 104,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.neutralColor100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Center(
        child: CustomButton(
          title: "Mark as Complete",
          onPressed: () => provider.handleLessonCompletion(context),
        ),
      ),
    );
  }
}
