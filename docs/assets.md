### Assets

Back to README: [../README.md](../README.md)

### Structure

- Icons: `assets/icons/`
- Images: `assets/images/`
- Fonts: `assets/fonts/`

Declared in `pubspec.yaml`:

```117:147:pubspec.yaml
assets:
  - assets/images/
  - assets/icons/
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

### Usage

- Images/icons via `Image.asset('assets/icons/<file>')` or `Image.asset('assets/images/<file>')`.
- Vector icons via `flutter_svg` where applicable.
- Custom icon font access: see `lib/Utils/helpers/app_custom_icons.dart`.

### Generation scripts

- None; assets are static and referenced directly.
