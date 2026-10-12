import 'package:flutter/foundation.dart';

/// Minimal project logger.
///
/// Follows FLUTTER_PROJECT_STANDARDS.md §8.7: no `print` in app code, all
/// logging goes through this class and is gated behind `kDebugMode`.
class Dev {
  const Dev._();

  static bool get _enabled => kDebugMode;

  static void logLine(String message) {
    if (_enabled) debugPrint(message);
  }

  static void logError(String message, [Object? error, StackTrace? stack]) {
    if (_enabled) debugPrint('❌ $message${error == null ? '' : ' | $error'}');
    if (_enabled && stack != null) debugPrint(stack.toString());
  }

  static void logSuccess(String message) {
    if (_enabled) debugPrint('✅ $message');
  }
}