import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_page/src/core/localization/current_language.dart';
import 'package:profile_page/src/core/shared_widgets/intro_gate.dart';
import 'package:profile_page/src/core/utils/theme/app_theme.dart';
import 'package:profile_page/src/infrastructure/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Regression guard for the brand splash.
///
/// The previous splash could not be dismissed — tapping it called `forward()`
/// on a controller that was already running, so the tap was a no-op and the
/// overlay stayed until its full (long) timeline elapsed.
///
/// Both scenarios live in one test on purpose: `EasyLocalization` caches state
/// process-wide, so remounting it in a second test would not reload its assets.
void main() {
  const splashKey = ValueKey('intro_splash');
  const portfolioKey = ValueKey('portfolio_marker');

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await initSharedPreferences();
    await EasyLocalization.ensureInitialized();
  });

  Widget harness({required Key scopeKey}) => EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        startLocale: const Locale('en'),
        fallbackLocale: const Locale('en'),
        saveLocale: false,
        child: Builder(
          builder: (context) => MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            theme: AppTheme.build(brightness: Brightness.dark, isArabic: false),
            // A fresh scope key resets `introDoneProvider` without touching the
            // (already loaded) localization controller above it.
            home: ProviderScope(
              key: scopeKey,
              child: const IntroGate(
                child: Scaffold(
                  body: Center(child: Text('PORTFOLIO', key: portfolioKey)),
                ),
              ),
            ),
          ),
        ),
      );

  Future<void> boot(WidgetTester tester, Widget app) async {
    await tester.pumpWidget(app);
    for (var i = 0; i < 40; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump();
      if (find.byKey(splashKey).evaluate().isNotEmpty) return;
    }
    fail('The splash never mounted — localization likely failed to load.');
  }

  testWidgets('the splash overlays the app, skips on tap, and self-completes',
      (tester) async {
    // ── Scenario 1: tapping skips the splash immediately. ──
    await boot(tester, harness(scopeKey: const ValueKey('scope-1')));

    expect(find.byKey(splashKey), findsOneWidget);
    // The portfolio is mounted underneath the splash from the very first frame.
    expect(find.byKey(portfolioKey), findsOneWidget);

    await tester.tap(find.byKey(splashKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byKey(splashKey), findsNothing);
    expect(find.byKey(portfolioKey), findsOneWidget);

    // ── Scenario 2: left alone, it completes and reveals the app. ──
    await boot(tester, harness(scopeKey: const ValueKey('scope-2')));

    expect(find.byKey(splashKey), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2900));
    await tester.pump();

    expect(find.byKey(splashKey), findsNothing);
    expect(find.byKey(portfolioKey), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
