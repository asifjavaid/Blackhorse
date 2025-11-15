import 'package:ekvi/Models/Amplitude/amplitude_event.dart';

class PurchaseAccessedEvent extends BaseEvent {
  final String feature;
  final String? accessMethod;

  PurchaseAccessedEvent({
    required this.feature,
    this.accessMethod,
  });

  @override
  String get eventName => 'PurchaseAccessed';
  @override
  String get description => 'User accesses the subscription option screen';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'accessMethod': accessMethod ?? "N/A",
      };
}

class PurchaseStartedEvent extends BaseEvent {
  final String productId;

  PurchaseStartedEvent({
    required this.productId,
  });

  @override
  String get eventName => 'PurchaseStarted';

  @override
  String get description => 'User has initiated the purchase flow';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'productId': productId,
      };
}

class PurchaseSuccessfulEvent extends BaseEvent {
  final String productId;

  PurchaseSuccessfulEvent({
    required this.productId,
  });

  @override
  String get eventName => 'PurchaseSuccessful';

  @override
  String get description => 'User successfully completed a purchase';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'productId': productId,
      };
}

class PurchaseErrorEvent extends BaseEvent {
  final String errorMessage;

  PurchaseErrorEvent({
    required this.errorMessage,
  });

  @override
  String get eventName => 'PurchaseError';

  @override
  String get description => 'User encountered an error during purchase';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'errorMessage': errorMessage,
      };
}
