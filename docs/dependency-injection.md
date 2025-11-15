### Dependency Injection

Back to README: [../README.md](../README.md)

The project uses a lightweight, pragmatic approach to DI via singletons and Provider composition rather than a full DI framework.

### Singletons

- `lib/core/di/one_signal_singleton.dart`: Wraps OneSignal initialization and user binding.

```16:24:lib/core/di/one_signal_singleton.dart
Future<void> initialize({bool requireConsent = false}) async {
  if (kDebugMode) _configureOneSignalLogging();
  OneSignal.consentRequired(requireConsent);
  OneSignal.initialize(AppConstant.oneSignalKey);
  OneSignal.LiveActivities.setupDefault();
  _loginUserIfAvailable();
  _addObservers();
}
```

- `lib/core/di/user_singleton.dart`: In-memory + `SharedPreferences` user data store.

```14:21:lib/core/di/user_singleton.dart
Future<void> initialize() async {
  final prefs = await SharedPreferences.getInstance();
  _userId = prefs.getString('userId');
  _email = prefs.getString('userEmail');
}
```

### Composition root

- Providers are created in `lib/Providers/app_providers.dart` and injected at the top level in `lib/main.dart`.

### Testing doubles

- For unit tests, prefer abstracting I/O in Services and injecting test fakes/mocks by replacing the service instances used by Providers.
