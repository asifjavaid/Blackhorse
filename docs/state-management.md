### State Management

Back to README: [../README.md](../README.md)

The app uses Provider with `ChangeNotifier` classes per feature. All providers are aggregated in `lib/Providers/app_providers.dart` and injected via `MultiProvider` in `lib/main.dart`.

```18:23:lib/main.dart
runApp(MultiProvider(providers: appProviders, child: const MyApp()));
```

```69:100:lib/Providers/app_providers.dart
List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => SplashProvider()),
  ChangeNotifierProvider(create: (_) => RegisterProvider()),
  // ... many feature providers ...
  ...getRemindersProviders(),
  ...getInsightsProviders(),
  ...getDailyTrackerProviders(),
  ...ekvipediaProviders(),
  ...painKillerProviders(),
  ...getMovementProviders(),
  ...getSelfcareProviders(),
  ...getPainReliefProviders(),
  ...getWellnessWeeklyProviders(),
];
```

### Lifecycles and updates

- Providers expose methods to fetch/update feature data.
- UI uses `Consumer<T>` or `Provider.of<T>` to rebuild on `notifyListeners()`.
- Initialization: `HelperFunctions.initializeApplication()` sets up services and may trigger provider actions (locale, notifications, purchases, OneSignal, Firebase).

### Best practices

- Keep network and parsing in Services; Providers should orchestrate and hold UI state.
- Avoid heavy work in `build`; call provider methods in `initState` of widgets.
- Use selectors or granular providers to reduce rebuilds.

### Missing info

- Exact public API per provider varies by feature. Inspect files under `lib/Providers/**` for details.
