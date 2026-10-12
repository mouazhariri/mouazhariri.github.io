import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/storage/local_storage_service.dart';

/// Bootstrap sequence (FLUTTER_PROJECT_STANDARDS.md §4).
abstract class AppInitializer {
  const AppInitializer._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    // Eagerly warm the storage façade before the first frame.
    await initSharedPreferences();
  }
}