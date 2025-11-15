import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale; // start it as nullable since it will be set in init()

  Locale get locale => _locale ?? const Locale("en"); // provide a default if it's null
  set locale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  LocaleProvider() {
    init(); // initialize locale when the provider is created
  }

  Future<void> init() async {
    final languageCode = await SharedPreferencesHelper.getStringPrefValue(key: 'languageCode') ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    if (!L10n.all.contains(newLocale)) return;
    locale = newLocale;
    await SharedPreferencesHelper.setStringPrefValue(key: 'languageCode', value: newLocale.languageCode);
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale("en");
    notifyListeners();
  }
}
