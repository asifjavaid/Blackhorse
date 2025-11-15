import 'package:ekvi/Models/Ekvipedia/ekvipedia_amplitude_events.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EkvipediaArticleProvider extends ChangeNotifier {
  EntryItem? item;
  Includes? assets;
  String? title;
  String? preview;
  EntryItem? authorEntry;
  List<Map<String, dynamic>> content = [];
  List<Map<String, dynamic>> articleReferences = [];
  String? date;
  String? readTime;
  List<String>? tags;
  final PanelController panelController = PanelController();
  dynamic selectedSpeakerData;

  void initialize(ScreenArguments? arguments) {
    item = arguments?.article?.article;
    assets = arguments?.article?.articleAssets;
    title = item?.fields["title"];
    preview = item?.fields["preview"];
    Map<String, dynamic>? authorData = item?.fields["author"];
    authorEntry = authorData != null ? EkvipediaContentEntries.getIncludesEntryById(authorData["sys"]?["id"], assets) : null;
    content = ((item?.fields["text"]?["content"] as List<dynamic>?) ?? []).map((item) => item as Map<String, dynamic>).toList();
    articleReferences = ((item?.fields["articleReferences"]?["content"] as List<dynamic>?) ?? []).map((item) => item as Map<String, dynamic>).toList();
    date = HelperFunctions.formatDateTimetoMonthYear(item?.fields["date"]);
    readTime = item != null ? "${item?.fields["readTime"]} minutes" : null;
    tags = EkvipediaContentEntries.getTags(item, assets);
    _logArticleViewEvent();
  }

  void _logArticleViewEvent() {
    EkvipediaArticleViewedEvent(articleTitle: item?.fields["title"] ?? '').log();
  }

  void logScrollEndEvent() {
    EkvipediaArticleCompleteEvent(articleTitle: item?.fields["title"] ?? '').log();
  }

  void logArticleExitEvent() {
    EkvipediaArticleExitEvent(articleTitle: item?.fields["title"] ?? '').log();
  }

  void togglePanel() {
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();
    }
  }

  void selectSpeaker() {
    selectedSpeakerData = authorEntry?.fields;
    togglePanel();
    notifyListeners();
  }
}
