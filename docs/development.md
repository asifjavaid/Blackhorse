### Development

Back to README: [../README.md](../README.md)

### Project layout tour

- `lib/main.dart`: App entry; sets up Providers, navigation, theming, i18n.
- `lib/Routes/**`: Route constants (`app_routes.dart`), generator, navigator.
- `lib/Providers/**`: `ChangeNotifier` classes composing feature state; aggregated in `lib/Providers/app_providers.dart`.
- `lib/Services/**`: Feature services for networking/domain logic.
- `lib/Network/**`: `ApiBaseHelper`, `ApiLinks`, and exceptions.
- `lib/Models/**`: Data models.
- `lib/core/themes/app_themes.dart`: Theme definition.
- `lib/core/di/**`: Singletons: `one_signal_singleton.dart`, `user_singleton.dart`.
- `lib/Utils/**`: Constants, helpers (analytics, auth, notifications, time, purchases, etc.).
- `assets/**`: Icons, images, fonts.

### Common dev tasks

- Hot reload: `r` in the Flutter run console.
- Debugging: set breakpoints in IDE; use Flutter DevTools.
- Logging: use `dart:developer` or `print` (note: `deprecated_member_use` is ignored in analyzer config).

### Code style and linting

- Analyzer configured in `analysis_options.yaml`:

```10:16:analysis_options.yaml
analyzer:
  errors:
    deprecated_member_use: ignore
include: package:flutter_lints/flutter.yaml
```

- Run analyzer:

```bash
flutter analyze
```

### Running and builds

```bash
flutter run -d ios
flutter run -d android
flutter build ios --release
flutter build apk --release
```

### Branching/commits

- Not enforced in repo; follow conventional commits where possible.
