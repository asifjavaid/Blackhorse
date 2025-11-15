### Setup

Back to README: [../README.md](../README.md)

### Toolchains and versions

- Dart/Flutter SDK: `environment sdk: ">=3.0.0 <4.0.0"` in `pubspec.yaml`
- iOS deployment target: `platform :ios, '15.0'` and IPHONEOS_DEPLOYMENT_TARGET 15.0 in `ios/Podfile`
- Android: `minSdkVersion 23`, `targetSdkVersion 35`, `compileSdkVersion 35` in `android/app/build.gradle`

### Prerequisites

- Flutter SDK installed and in PATH
- Xcode + CocoaPods (macOS) for iOS
- Android Studio + Android SDKs and an emulator for Android

### Install dependencies

```bash
flutter pub get
cd ios && pod install && cd ..
```

### Environment variables / secrets

- Many runtime values are embedded in `lib/Utils/constants/app_constant.dart` (e.g., `appBaseURL`, Intercom keys, OneSignal key). For production, consider moving secrets to secure storage or CI/CD variables.
- Android signing config reads `android/key.properties` and an upload keystore. Ensure `key.properties` exists locally and is not committed.

Relevant files:

```37:91:android/app/build.gradle
android {
  namespace "com.ekvi.ekvi"
  compileSdkVersion 35
  defaultConfig { minSdkVersion 23; targetSdkVersion 35 }
  signingConfigs { release { keyAlias keystoreProperties['keyAlias'] ... } }
}
```

```1:46:ios/Podfile
platform :ios, '15.0'
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each { |config| config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0' }
  end
end
```

### Running the app

```bash
flutter run -d ios
flutter run -d android
flutter run -d chrome
```

### Asset setup

- Assets declared in `pubspec.yaml` under `flutter/assets` (`assets/images/`, `assets/icons/`) and fonts under `flutter/fonts`.

```117:147:pubspec.yaml
flutter:
  generate: true
  uses-material-design: true
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

### iOS specific

- Update bundle ID and signing in Xcode (`ios/Runner.xcodeproj`).
- Push and background modes are enabled in `ios/Runner/Info.plist` (remote notifications, fetch).

### Android specific

- Ensure `key.properties` and keystore are configured for release builds.
- `com.google.gms.google-services` plugin is applied; `android/app/google-services.json` exists.
