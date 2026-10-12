import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infrastructure/storage/local_storage_service.dart';

part 'current_language.g.dart';

/// Supported locales (docs: EN + AR everywhere).
const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

/// Active language code, persisted in [LocalStorageService].
@Riverpod(keepAlive: true)
class CurrentLanguage extends _$CurrentLanguage {
  @override
  String build() => ref.read(localStorageServiceProvider).localeCode ?? 'en';

  bool get isArabic => state == 'ar';

  Future<void> setLanguage(String code) async {
    if (code == state) return;
    state = code;
    await ref.read(localStorageServiceProvider).saveLocale(code);
  }
}