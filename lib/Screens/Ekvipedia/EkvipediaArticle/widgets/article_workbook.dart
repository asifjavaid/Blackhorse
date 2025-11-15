import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/url_launcher_helper.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';

class ArticleWorkbook extends StatelessWidget {
  final EntryItem? item;
  final Includes? assets;

  const ArticleWorkbook({super.key, required this.item, required this.assets});

  @override
  Widget build(BuildContext context) {
    final String? title = item?.fields["title"];
    final String? description = item?.fields["description"];
    final String? fileUrl = item?.fields["fileUrl"];

    if (title == null || description == null || fileUrl == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.neutralColor50,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralColor300.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutralColor600,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.neutralColor500,
                ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: CustomButton(
              buttonType: ButtonType.secondary,
              title: "Download PDF",
              onPressed: () => _downloadPdf(fileUrl),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPdf(String fileUrl) async {
    try {
      // Ensure the URL has the proper protocol
      String url = fileUrl;
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https:$url';
      }

      await UrlLauncherService.openUrl(url);
    } catch (e) {
      // Handle error - could show a snackbar or dialog if needed
      debugPrint('Error downloading PDF: $e');
    }
  }
}
