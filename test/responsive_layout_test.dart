import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_page/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:profile_page/src/core/localization/current_language.dart';
import 'package:profile_page/src/core/utils/theme/app_theme.dart';
import 'package:profile_page/src/infrastructure/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The whole page must lay out without overflowing on phone-sized viewports.
///
/// Every section lives in a `SingleChildScrollView`, so a single pump lays out
/// all of them; a RenderFlex overflow surfaces as a thrown exception.
///
/// Everything runs inside one `testWidgets` because `easy_localization` caches
/// the loaded bundle process-wide — a second localized test renders an empty
/// tree.
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    // The harness ships a square-glyph font ("Ahem") whose characters are much
    // wider than a real typeface, which would produce false overflow reports.
    // Load real metrics (Roboto from the Flutter SDK) under the families the
    // theme uses so the assertions match a real browser.
    await _loadRealFonts();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await initSharedPreferences();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('portfolio lays out without overflow from phone to tablet widths',
      (tester) async {
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: ProviderScope(
          child: Builder(
            builder: (context) => MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: AppTheme.build(
                brightness: Brightness.dark,
                isArabic: false,
              ),
              home: const PortfolioScreen(),
            ),
          ),
        ),
      ),
    );

    for (final size in const [
      Size(320, 720),
      Size(360, 800),
      Size(390, 844),
      Size(768, 1024),
      Size(1024, 800),
      Size(1440, 900),
    ]) {
      tester.view.physicalSize = size;
      // Let the entry animation, typewriter and reveals settle a little.
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }

      final errors = <Object>[];
      for (Object? error = tester.takeException();
          error != null;
          error = tester.takeException()) {
        errors.add(error);
      }
      expect(
        errors.map((e) => e.toString()).toList(),
        isEmpty,
        reason: 'layout overflow at ${size.width.toInt()}px',
      );
    }

    // Sanity check that the redesigned sections actually rendered on a phone.
    expect(find.text('Send me a message'), findsOneWidget);
    expect(find.text('Skills & Technologies'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}

Future<void> _loadRealFonts() async {
  final file = _findRoboto();
  if (file == null) return;

  final bytes = file.readAsBytesSync().buffer.asByteData();
  for (final family in const [
    'Space Grotesk',
    'SpaceGrotesk',
    'Cairo',
    'Roboto',
  ]) {
    final loader = FontLoader(family)..addFont(Future.value(bytes));
    await loader.load();
  }
}

File? _findRoboto() {
  final candidates = <Directory>[];
  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot != null) candidates.add(Directory(flutterRoot));

  var dir = File(Platform.resolvedExecutable).parent;
  for (var i = 0; i < 8; i++) {
    candidates.add(dir);
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }

  for (final root in candidates) {
    final file = File(
      '${root.path}/bin/cache/artifacts/material_fonts/Roboto-Regular.ttf',
    );
    if (file.existsSync()) return file;
  }
  return null;
}
