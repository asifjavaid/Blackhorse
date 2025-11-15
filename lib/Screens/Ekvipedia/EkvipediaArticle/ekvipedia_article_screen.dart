import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_article_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_author.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_content_manager.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_metadata_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_references.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/thumbnail_widget.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EkvipediaArticleScreen extends StatefulWidget {
  final ScreenArguments? arguments;

  const EkvipediaArticleScreen({super.key, this.arguments});
  @override
  State<EkvipediaArticleScreen> createState() => _EkvipediaArticleScreenState();
}

class _EkvipediaArticleScreenState extends State<EkvipediaArticleScreen> {
  final ScrollController _scrollController = ScrollController();
  late EkvipediaArticleProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<EkvipediaArticleProvider>(context, listen: false);
    _provider.initialize(widget.arguments);

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        _provider.logScrollEndEvent();
      }
    });
  }

  @override
  void dispose() {
    _provider.logArticleExitEvent();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EkvipediaArticleProvider>(
        builder: (context, articleProvider, child) {
          final textTheme = Theme.of(context).textTheme;

          return GradientBackground(
            child: SlidingUpPanel(
              controller: articleProvider.panelController,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              backdropEnabled: false,
              minHeight: 0,
              maxHeight: 550,
              panel: articleProvider.selectedSpeakerData != null
                  ? AuthorHelperSheet(
                      textTheme: textTheme,
                      fields: articleProvider.authorEntry?.fields,
                      assets: articleProvider.assets,
                    )
                  : const SizedBox.shrink(),
              body: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ArticleThumbnail(
                      imageURL: EkvipediaContentEntries.getFaturedImageURL(articleProvider.item, articleProvider.assets),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ArticleMetaData(
                            title: articleProvider.title,
                            preview: articleProvider.preview,
                            date: articleProvider.date,
                            readTime: articleProvider.readTime,
                            tags: articleProvider.tags,
                          ),
                          ArticleContentManager(content: articleProvider.content, assets: articleProvider.assets),
                          ArticleReferencesPreview(articleReferences: articleProvider.articleReferences, assets: articleProvider.assets),
                          articleProvider.authorEntry != null
                              ? ArticleAuthor(
                                  item: articleProvider.authorEntry,
                                  assets: articleProvider.assets,
                                  onTap: () => articleProvider.selectSpeaker(),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 64),
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
    );
  }
}
