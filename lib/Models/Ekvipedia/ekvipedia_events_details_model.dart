import 'ekvipedia_entries_model.dart';

class EventDetailsModel {
  final EntryItem? item;
  final Includes? assets;
  final String? timeData;
  final String? address;
  final String? promoCode;
  final String? eventTitle;
  final List<dynamic>? speakerInformation;
  final List<dynamic>? similarEvents;
  final List<Map<String, dynamic>>? content;
  final String? joinTheEvent;
  final String? factBox;

  EventDetailsModel({
    this.item,
    this.assets,
    this.timeData,
    this.address,
    this.promoCode,
    this.eventTitle,
    this.speakerInformation,
    this.similarEvents,
    this.content,
    this.joinTheEvent,
    this.factBox,
  });
}
