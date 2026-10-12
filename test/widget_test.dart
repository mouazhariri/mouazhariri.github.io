import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_page/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:profile_page/src/core/localization/current_language.dart';
import 'package:profile_page/src/core/utils/theme/app_theme.dart';
import 'package:profile_page/src/infrastructure/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Avoid runtime network fetches (which leave pending timers) in tests.
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await initSharedPreferences();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('PortfolioScreen renders the hero for the loaded content',
      (tester) async {
    tester.view.physicalSize = const Size(700, 1200);
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

    // Let localization, the async content load and a few animation frames run.
    // (Continuous background animations mean `pumpAndSettle` would never end.)
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }

    expect(find.text('Mouaz Hariri'), findsWidgets);

    // Tear the tree down inside the test so all animation timers are cancelled
    // before the framework's pending-timer check runs.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}