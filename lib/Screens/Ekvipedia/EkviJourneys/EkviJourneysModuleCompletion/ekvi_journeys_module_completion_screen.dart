import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/ekvi_journeys_module_completion_footer.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/ekvi_journeys_module_completion_header.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/module_completion_content.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/module_completion_content_renderer.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';

class EkviJourneysModuleCompletionScreen extends StatelessWidget {
  const EkviJourneysModuleCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const EkviJourneysModuleCompletionHeader(),
            Expanded(
              child: Consumer<EkviJourneysProvider>(
                builder: (context, provider, child) {
                  final moduleCompletion = provider.moduleCompletionResponse;
                  final content = moduleCompletion?.moduleCompletionContent;

                  if (content == null || content['content'] == null) {
                    return const ModuleCompletionContent();
                  }
                  final List<Map<String, dynamic>> contentList =
                      List<Map<String, dynamic>>.from(content['content']);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: ModuleCompletionContentRenderer(
                      content: contentList,
                      assets:
                          provider.extractAssetsFromModuleCompletionContent(),
                    ),
                  );
                },
              ),
            ),
            const EkviJourneysModuleCompletionFooter(),
          ],
        ),
      ),
    );
  }
}
