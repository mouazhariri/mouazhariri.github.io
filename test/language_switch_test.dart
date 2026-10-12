import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_page/src/core/localization/current_language.dart';
import 'package:profile_page/src/infrastructure/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Minimal harness mirroring `main.dart`: the active locale is owned by
/// [currentLanguageProvider] and `EasyLocalization` is keyed by it, so a
/// language change immediately re-renders localized copy. Regression guard for
/// the bug where toggling the language only persisted the choice but left the
/// UI in the previous language until a reload.
class _Harness extends ConsumerWidget {
  const _Harness();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(currentLanguageProvider);
    return EasyLocalization(
      key: ValueKey<String>('l10n-$code'),
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      startLocale: Locale(code),
      fallbackLocale: const Locale('en'),
      saveLocale: false,
      child: Builder(
        builder: (ctx) => MaterialApp(
          locale: ctx.locale,
          localizationsDelegates: ctx.localizationDelegates,
          supportedLocales: ctx.supportedLocales,
          home: Scaffold(
            body: Builder(builder: (c) => Text(c.tr('nav.about'))),
          ),
        ),
      ),
    );
  }
}

void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await initSharedPreferences();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('changing the language re-renders localized copy live',
      (tester) async {
    await tester.pumpWidget(const ProviderScope(child: _Harness()));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();
    expect(find.text('About'), findsOneWidget);

    final container =
        ProviderScope.containerOf(tester.element(find.byType(_Harness)));
    await container.read(currentLanguageProvider.notifier).setLanguage('ar');
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('About'), findsNothing);
    expect(find.text('من أنا'), findsOneWidget);
  });
}
