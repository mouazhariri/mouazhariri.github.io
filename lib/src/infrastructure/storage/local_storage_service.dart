import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/constants/keys.dart';

part 'local_storage_service.g.dart';

/// Holds the single [SharedPreferences] instance loaded during bootstrap.
///
/// [initSharedPreferences] is called from `AppInitializer.init()` before the
/// first frame, so [sharedPreferencesProvider] can hand it out synchronously
/// (no `AsyncValue` / `requireValue` at build time).
SharedPreferences? _prefsInstance;

/// Eagerly loads [SharedPreferences]. Call once during app/ test bootstrap.
Future<void> initSharedPreferences() async {
  _prefsInstance ??= await SharedPreferences.getInstance();
}

/// Synchronous access to the bootstrapped [SharedPreferences].
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  final prefs = _prefsInstance;
  if (prefs == null) {
    throw StateError(
      'SharedPreferences has not been initialized. '
      'Call initSharedPreferences() during bootstrap.',
    );
  }
  return prefs;
}

/// Single persistence façade (FLUTTER_PROJECT_STANDARDS.md §9.1).
///
/// For this static portfolio we persist only two user preferences:
/// theme mode and locale. Every `SharedPreferences` access lives here.
class LocalStorageService {
  LocalStorageService(this._prefs);

  final SharedPreferences _prefs;

  ThemeMode get themeMode {
    final raw = _prefs.getString(Keys.themeMode);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == raw,
      orElse: () => ThemeMode.dark,
    );
  }

  Future<void> saveThemeMode(ThemeMode mode) =>
      _prefs.setString(Keys.themeMode, mode.name);

  String? get localeCode => _prefs.getString(Keys.locale);

  Future<void> saveLocale(String code) => _prefs.setString(Keys.locale, code);
}

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) =>
    LocalStorageService(ref.watch(sharedPreferencesProvider));