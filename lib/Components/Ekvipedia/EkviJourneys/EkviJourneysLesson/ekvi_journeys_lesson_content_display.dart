import 'package:ekvi/Components/Ekvipedia/EkviJourneys/ekvi_journeys_save_button.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_content_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';

class EkviJourneysLessonContentDisplay extends StatelessWidget {
  final LessonStructure lesson;

  const EkviJourneysLessonContentDisplay({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.ensureAssetsExtracted();
    });

    final contentList = provider.getLessonContentList();

    if (contentList == null || contentList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No lesson content available.'),
      );
    }

    return _buildLessonContentUI(context, contentList, provider);
  }

  Widget _buildLessonContentUI(
    BuildContext context,
    List<Map<String, dynamic>> contentList,
    EkviJourneysProvider provider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                lesson.title ?? '',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const EkviJourneysSaveButton(),
          ],
        ),
        const SizedBox(height: 20),
        ArticleContentManager(
          content: contentList,
          assets: provider.assets,
        ),
      ],
    );
  }
}
