class CircuitBreaker {
  final int failureThreshold;
  final Duration resetTimeout;
  int failureCount = 0;
  DateTime? lastFailureTime;

  CircuitBreaker({required this.failureThreshold, required this.resetTimeout});

  bool get isOpen => lastFailureTime != null && DateTime.now().difference(lastFailureTime!).compareTo(resetTimeout) < 0;

  bool canProceed() {
    return !(isOpen && failureCount >= failureThreshold);
  }

  void recordFailure() {
    lastFailureTime = DateTime.now();
    failureCount++;
  }

  void reset() {
    lastFailureTime = null;
    failureCount = 0;
  }
}

class CircuitBreakerOpenException implements Exception {
  final String message;
  CircuitBreakerOpenException(this.message);
}
