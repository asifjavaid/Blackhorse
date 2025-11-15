import 'package:flutter/material.dart';

class BottomSheetHelper {
  OverlayEntry? overlayEntry;
  bool isExpanded = false;

  Widget Function() _builder = () => const SizedBox.shrink();

  double get sheetHeight => isExpanded ? 435 : 180;

  void insertOverlay(BuildContext context, Widget Function() builder) {
    removeOverlay();
    _builder = builder;

    overlayEntry = OverlayEntry(builder: (_) => _builder());
    Overlay.of(context).insert(overlayEntry!);
  }

  void toggleHeight() {
    isExpanded = !isExpanded;
    rebuildOverlay();
  }

  void rebuildOverlay() {
    overlayEntry?.markNeedsBuild();
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
