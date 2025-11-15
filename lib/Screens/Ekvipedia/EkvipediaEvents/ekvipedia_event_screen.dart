import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_event_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_content_manager.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/embedded_entry_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/thumbnail_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaEvents/widgets/ekvipedia_event_author.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaEvents/widgets/ekvipedia_join_event.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widgets/ekvipedia_event_metadata.dart';

class EkvipediaEventScreen extends StatelessWidget {
  final ScreenArguments? arguments;
  const EkvipediaEventScreen({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EkvipediaEventProvider>(
      create: (_) => EkvipediaEventProvider(arguments),
      child: Scaffold(
        body: GradientBackground(
          child: Consumer<EkvipediaEventProvider>(
            builder: (context, provider, _) {
              final textTheme = Theme.of(context).textTheme;
              if (provider.model == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SlidingUpPanel(
                  controller: provider.panelController,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  backdropEnabled: false,
                  minHeight: 0,
                  maxHeight: 550,
                  panel: provider.selectedSpeakerData != null
                      ? SpeakerHelperSheet(
                          textTheme: textTheme,
                          fields: provider.selectedSpeakerData,
                          assets: provider.model!.assets,
                        )
                      : const SizedBox.shrink(),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ArticleThumbnail(
                          imageURL: EkvipediaContentEntries.getFaturedImageURL(
                            provider.model!.item,
                            provider.model!.assets,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EventsMetaData(model: provider.model!),
                              if (provider.model?.content != null)
                                ArticleContentManager(
                                  content: provider.model!.content!,
                                  assets: provider.model!.assets,
                                ),
                              if (provider.model?.factBox != null && provider.model!.factBox!.isNotEmpty)
                                EmbeddedEntryWidget(
                                  assets: provider.model!.assets,
                                  id: provider.model!.factBox!,
                                ),
                              const SizedBox(height: 32),
                              if (provider.model?.joinTheEvent != null && provider.model!.joinTheEvent!.isNotEmpty)
                                EkvipediaJoinEvent(
                                  url: provider.model!.joinTheEvent!,
                                  title: 'Join the event',
                                ),
                              if (provider.authorEntries.isNotEmpty)
                                EventsAuthor(
                                  items: provider.authorEntries,
                                  assets: provider.model!.assets,
                                  onTap: provider.selectSpeaker,
                                ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
