import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_page/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

/// Boots the *real* application entry point.
///
/// Regression guard: `PortfolioApp` is a `ConsumerWidget` that reads providers,
/// so `main()` must install a `ProviderScope`. Previously the scope was missing
/// and the app crashed at startup with `Bad state: No ProviderScope found`.
void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  testWidgets('main() boots the app under a ProviderScope', (tester) async {
    tester.view.physicalSize = const Size(700, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await app.main();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // A missing ProviderScope throws while building the root widget.
    expect(tester.takeException(), isNull);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Mouaz Hariri'), findsWidgets);

    // Unmount so animation timers/tickers are cancelled before teardown.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
