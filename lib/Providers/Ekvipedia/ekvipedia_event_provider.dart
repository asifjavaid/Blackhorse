import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_events_details_model.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EkvipediaEventProvider with ChangeNotifier {
  EventDetailsModel? model;
  List<EntryItem> authorEntries = [];
  dynamic selectedSpeakerData;
  String? errorMessage;

  final PanelController panelController = PanelController();

  EkvipediaEventProvider(ScreenArguments? arguments) {
    _initData(arguments);
  }

  void _initData(ScreenArguments? arguments) {
    if (arguments?.article?.article == null) {
      errorMessage = "No article data provided.";
      notifyListeners();
      return;
    }

    final article = arguments!.article!.article!;
    final assets = arguments.article?.articleAssets;

    String? timeData;
    if (article.fields.containsKey('startTime') && article.fields.containsKey('endTime')) {
      final startTime = article.fields['startTime'] as String?;
      final endTime = article.fields['endTime'] as String?;
      timeData = "$startTime - $endTime";
    } else {
      timeData = null;
    }

    model = EventDetailsModel(
      item: article,
      assets: assets,
      eventTitle: article.fields["eventTitle"] ?? "",
      speakerInformation: article.fields["speakerInformation"] ?? [],
      content: ((article.fields["eventDescription"]?["content"] as List<dynamic>?) ?? []).map((item) => item as Map<String, dynamic>).toList(),
      joinTheEvent: article.fields["joinTheEvent"] as String?,
      factBox: article.fields["factBox"] != null ? (article.fields["factBox"]["sys"]?["id"] as String?) : null,
      timeData: timeData,
      similarEvents: article.fields["similarEvents"] ?? [],
    );

    // Populate author entries based on speakerInformation.
    authorEntries.clear();
    final speakerInfo = model?.speakerInformation ?? [];
    for (var speaker in speakerInfo) {
      final entryId = speaker["sys"]?["id"];
      if (entryId != null && assets != null) {
        final entryItem = EkvipediaContentEntries.getIncludesEntryById(entryId, assets);
        if (entryItem != null) {
          authorEntries.add(entryItem);
        }
      }
    }

    notifyListeners();
  }

  void togglePanel() {
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();
    }
  }

  void selectSpeaker(int index) {
    if (index >= 0 && index < authorEntries.length) {
      selectedSpeakerData = authorEntries[index].fields;
      togglePanel();
      notifyListeners();
    }
  }
}
