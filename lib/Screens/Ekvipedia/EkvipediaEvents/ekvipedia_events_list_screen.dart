// ignore_for_file: library_private_types_in_public_api
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/thumbnail_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaEvents/widgets/ekvipedia_event_card.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkviEventsListScreen extends StatefulWidget {
  const EkviEventsListScreen({super.key});

  @override
  _EkviEventsListScreenState createState() => _EkviEventsListScreenState();
}

class _EkviEventsListScreenState extends State<EkviEventsListScreen> {
  late EkvipediaProvider ekvipediaProvider;

  @override
  void initState() {
    super.initState();
    ekvipediaProvider = context.read<EkvipediaProvider>();
    ekvipediaProvider.fetchLatestEvents();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientBackground(
        child: SafeArea(
          top: false,
          child: EventListContent(),
        ),
      ),
    );
  }
}

class EventListContent extends StatelessWidget {
  const EventListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EkvipediaProvider>(
      builder: (context, provider, _) {
        return SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ArticleThumbnail(imagePath: "${AppConstant.assetImages}events_thumbnail.jpg"),
              const SizedBox(height: 32),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: EventsListSection(provider: provider),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

class EventsListSection extends StatelessWidget {
  final EkvipediaProvider provider;

  const EventsListSection({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Events from Ekvi", style: textTheme.displaySmall),
        const SizedBox(height: 16),
        Expanded(
          child: EventListView(provider: provider),
        ),
      ],
    );
  }
}

class EventListView extends StatelessWidget {
  final EkvipediaProvider provider;

  const EventListView({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final items = provider.latestEvents.items;
    final includes = provider.latestEvents.includes;

    if (items == null || items.isEmpty) {
      return const Center(child: Text("No events available"));
    }

    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = items[index];
        return EventCard(
          imagePath: EkvipediaContentEntries.getFaturedImageURL(item, includes),
          date: HelperFunctions.formatDateTimetoMonthYear(item.fields["date"]),
          location: item.fields["location"] ?? "",
          title: item.fields["eventTitle"] ?? "",
          onPressed: () => AppNavigation.navigateTo(
            AppRoutes.ekvipediaEvents,
            arguments: ScreenArguments(
              article: ArticleContent(
                article: item,
                articleAssets: includes,
              ),
            ),
          ),
        );
      },
    );
  }
}
