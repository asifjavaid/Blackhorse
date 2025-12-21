
// Data model for categories (unchanged from before)
import 'TrackingItem.dart';

class TrackingCategory {
  final String title;
  final List<TrackingItem> items;

  TrackingCategory({required this.title, required this.items});
}