### Ekvi Mobile App

Ekvi is a cross-platform Flutter application focused on women’s health tracking and guided journeys. This repository contains the complete mobile client for iOS, Android, web, and desktop targets.

This README gives a concise overview and links into the full documentation under `docs/`.

### Key value proposition

- Personalized daily tracking for symptoms and well-being
- Evidence-based insights and content (“Ekvipedia” and “Ekvi Journeys”)
- Reminders, notifications, and subscriptions

### Architecture summary

- **Entry point**: `lib/main.dart` initializes services and providers, and sets up navigation, theming, and i18n.
- **State management**: Provider (`lib/Providers/**`) with many `ChangeNotifier`-backed features; aggregated in `lib/Providers/app_providers.dart`.
- **Networking**: Centralized helper in `lib/Network/api_base_helper.dart` and endpoints in `lib/Network/api_links.dart`; errors via `lib/Network/api_exception.dart`.
- **Routing**: Static route map in `lib/Routes/app_routes.dart` with dynamic `onGenerateRoute` in `lib/Routes/route_generator.dart` and global navigation via `lib/Routes/app_navigation.dart`.
- **Theming**: `lib/core/themes/app_themes.dart` defines typography, colors, components.
- **DI/Services**: Lightweight singletons in `lib/core/di/**` for OneSignal and user session state.
- **Localization**: Generated l10n configured via `l10n.yaml` and `lib/l10n/**`.

Code references:

```14:47:lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HelperFunctions.initializeApplication();
  runApp(MultiProvider(providers: appProviders, child: const MyApp()));
}
```

```200:209:lib/core/themes/app_themes.dart
static ThemeData defaultTheme = ThemeData(
  colorScheme: const ColorScheme.light(primary: AppColors.primaryColor600),
  bottomSheetTheme: _bottomSheetThemeData,
  textTheme: _textTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  outlinedButtonTheme: _outlinedButtonTheme,
  iconTheme: _iconTheme,
  switchTheme: _switchTheme,
  listTileTheme: _listTileThemeData,
  inputDecorationTheme: _inputDecorationTheme,
);
```

### Quick start

Prerequisites:

- Flutter SDK (matching Dart `>=3.0.0 <4.0.0`) — see `pubspec.yaml`
- Xcode with CocoaPods for iOS (`platform :ios, '15.0'` in `ios/Podfile`)
- Android Studio/SDK (minSdk 23, target/compile 35 in `android/app/build.gradle`)

Install dependencies:

```bash
flutter --version
flutter pub get
```

iOS setup:

```bash
cd ios && pod install && cd ..
```

Run:

```bash
flutter run -d ios      # iOS Simulator or device
flutter run -d android  # Android emulator or device
flutter run -d chrome   # Web
```

Build (release examples):

```bash
flutter build ios --release
flutter build apk --release
```

### Table of Contents

- [Architecture](docs/architecture.md)
- [Setup](docs/setup.md)
- [Development](docs/development.md)
- [Features](docs/features.md)
- [Data Models](docs/data-models.md)
- [State Management](docs/state-management.md)
- [Navigation](docs/navigation.md)
- [Networking](docs/networking.md)
- [Dependency Injection](docs/dependency-injection.md)
- [Theming](docs/theming.md)
- [Internationalization (i18n)](docs/i18n.md)
- [Assets](docs/assets.md)
- [Platform: Android](docs/platform-android.md)
- [Platform: iOS](docs/platform-ios.md)
- [Testing](docs/testing.md)
- [Security & Privacy](docs/security-privacy.md)
- [Performance](docs/performance.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Glossary](docs/glossary.md)
- [Changelog](docs/changelog.md)
- [ADRs](docs/adr/ADR-000-template.md)

### Support / Contributing

- File issues and feature requests via repository issues.
- Follow Provider patterns used in `lib/Providers/**`.
- Run analyzer and fix lints per `analysis_options.yaml`.

Back to docs: [docs/](docs/)

Missing info:

- Store provisioning/signing details and environment secrets are not in repo.

Flutter

- Version: 3.32.5 (stable) via FVM
- Dart: 3.8.1

Getting started

1. Install FVM and use the pinned version
   - fvm install
   - fvm flutter --version
2. Install dependencies
   - fvm flutter pub get
3. iOS setup (first run or after Pod changes)
   - cd ios && pod install && cd ..
   - If CocoaPods encoding error appears, set: export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8
4. Run
   - fvm flutter run

Notes

- Dart SDK constraint in `pubspec.yaml` is `>=3.0.0 <4.0.0`, which is compatible with Dart 3.8.x.
