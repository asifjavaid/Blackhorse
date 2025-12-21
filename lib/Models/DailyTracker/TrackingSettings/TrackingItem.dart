// Data model for tracking items (unchanged from before)
class TrackingItem {
  final String title;
  bool isEnabled;

  TrackingItem({required this.title, this.isEnabled = true});
}