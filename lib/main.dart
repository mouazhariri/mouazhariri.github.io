import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/application/di/app_initializer.dart';
import 'src/application/router/app_router.dart';
import 'src/core/localization/current_language.dart';
import 'src/core/shared_widgets/intro_gate.dart';
import 'src/core/utils/theme/app_theme.dart';
import 'src/core/utils/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  runApp(const ProviderScope(child: PortfolioApp()));
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeCode = ref.watch(currentLanguageProvider);
    final themeMode = ref.watch(themeControllerProvider);
    final router = ref.watch(appRouterProvider);

    return EasyLocalization(
      // Keying by locale rebuilds the localization controller (with a fresh
      // `startLocale`) whenever the language changes. `EasyLocalization`
      // ignores `startLocale` updates after init, so this is what makes the
      // in-app language toggle take effect immediately.
      key: ValueKey<String>('l10n-$localeCode'),
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      startLocale: Locale(localeCode),
      fallbackLocale: const Locale('en'),
      saveLocale: false,
      child: Builder(
        builder: (context) {
          // Resolved below [EasyLocalization] so delegates/locale are available.
          final isArabic = context.locale.languageCode == 'ar';
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.build(brightness: Brightness.light, isArabic: isArabic),
            darkTheme: AppTheme.build(brightness: Brightness.dark, isArabic: isArabic),
            themeMode: themeMode,
            builder: (context, child) =>
                IntroGate(child: child ?? const SizedBox.shrink()),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
