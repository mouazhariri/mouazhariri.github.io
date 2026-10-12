import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/storage/local_storage_service.dart';

part 'theme_controller.g.dart';

/// Active [ThemeMode], persisted in [LocalStorageService]. Dark-first.
@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() => ref.watch(localStorageServiceProvider).themeMode;

  Future<void> setMode(ThemeMode mode) async {
    if (mode == state) return;
    state = mode;
    await ref.read(localStorageServiceProvider).saveThemeMode(mode);
  }

  Future<void> toggle() => setMode(
        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
      );
}