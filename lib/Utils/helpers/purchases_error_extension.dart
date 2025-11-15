extension SubscriptionPeriodExtension on String {
  String get toSubscriptionPeriodString {
    if (this == 'P1M') {
      return 'monthly';
    } else if (this == 'P1Y') {
      return 'yearly';
    } else if (this == 'P1W') {
      return 'week';
    } else {
      return '';
    }
  }
}
