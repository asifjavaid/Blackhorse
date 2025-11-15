### Theming

Back to README: [../README.md](../README.md)

Theme configuration lives in `lib/core/themes/app_themes.dart` and uses fonts and colors defined under `assets/fonts/` and `lib/Utils/constants/app_colors.dart`.

```5:18:lib/core/themes/app_themes.dart
class AppThemes {
  static const BoxShadow shadowDown = BoxShadow(/* ... */);
  static const BoxShadow shadowUp = BoxShadow(/* ... */);
  static const TextTheme _textTheme = TextTheme(/* Zitter & Poppins */);
}
```

Primary theme:

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
  inputDecorationTheme: _inputDecorationTheme);
```

Fonts declared in `pubspec.yaml`:

```133:147:pubspec.yaml
fonts:
  - family: YesevaOne
    fonts:
      - asset: assets/fonts/YesevaOne-Regular.ttf
  - family: Poppins
    fonts:
      - asset: assets/fonts/Poppins-Regular.ttf
  - family: Zitter
    fonts:
      - asset: assets/fonts/Zitter-Extrabold.ttf
  - family: AppCustomIcons
    fonts:
      - asset: assets/fonts/AppCustomIcons.ttf
```

### Adding variants

- Extend `TextTheme` entries or define dark theme variants mirroring `defaultTheme` structure.
- Keep component themes (buttons, inputs, list tiles) consistent with `AppColors`.

### Missing info

- Exact `AppColors` values come from `lib/Utils/constants/app_colors.dart`.
