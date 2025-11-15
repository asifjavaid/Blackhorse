### Troubleshooting

Back to README: [../README.md](../README.md)

### Common issues

- CocoaPods not installed / outdated

  - Run: `sudo gem install cocoapods && pod repo update`
  - Then: `cd ios && pod install && cd ..`

- Gradle/AndroidX mismatches

  - Ensure Android Studio SDKs installed; run `flutter doctor -v`
  - Clean and rebuild: `flutter clean && flutter pub get`

- iOS build failures on deployment target

  - Confirm deployment target 15.0 in `ios/Podfile` and Xcode project settings.

- Missing google-services.json

  - Ensure `android/app/google-services.json` exists and matches the bundle ID.

- Push notification permission issues
  - Check OneSignal setup and entitlements (development vs production).

### Clean/reset commands

```bash
flutter clean
flutter pub get
cd ios && pod deintegrate && pod install && cd ..
```

### Missing info

- CI cache strategies and platform-specific quirks for devices are environment-dependent.
