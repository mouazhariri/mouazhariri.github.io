import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

/// Builds the light & dark [ThemeData] for the portfolio.
///
/// Indigo → cyan identity, dark-first. Rounded, glass-friendly surfaces.
abstract class AppTheme {
  const AppTheme._();

  static ThemeData build({required Brightness brightness, required bool isArabic}) {
    final dark = brightness == Brightness.dark;
    final base = _baseTheme(dark: dark, isArabic: isArabic);

    return base.copyWith(
      scaffoldBackgroundColor: dark ? AppColors.darkBackground : AppColors.lightBackground,
      canvasColor: dark ? AppColors.darkSurface : AppColors.lightSurface,
      colorScheme: _scheme(dark: dark),
      textTheme: base.textTheme
          .apply(bodyColor: dark ? AppColors.darkText : AppColors.lightText)
          .copyWith(
            displayLarge: _display(dark),
            displayMedium: _display(dark),
            headlineLarge: _display(dark).copyWith(fontWeight: FontWeight.w700),
            headlineMedium: _display(dark).copyWith(fontWeight: FontWeight.w700),
            titleLarge: _display(dark).copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            bodyLarge: TextStyle(height: 1.6, color: dark ? AppColors.darkText : AppColors.lightText),
            bodyMedium: TextStyle(height: 1.6, color: dark ? AppColors.darkMuted : AppColors.lightMuted),
            labelLarge: const TextStyle(fontWeight: FontWeight.w600),
          ),
      cardTheme: CardThemeData(
        color: dark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: dark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: dark ? AppColors.darkBorder : AppColors.lightBorder,
      ),
      dividerColor: dark ? AppColors.darkBorder : AppColors.lightBorder,
      splashFactory: InkSparkle.splashFactory,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: dark ? AppColors.secondary : AppColors.primaryDark,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: dark ? AppColors.darkSurfaceElevated : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(color: dark ? AppColors.darkText : AppColors.lightText),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dark ? AppColors.darkSurface : Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  static ThemeData _baseTheme({required bool dark, required bool isArabic}) {
    final seed = dark ? AppColors.primary : AppColors.primaryDark;
    return ThemeData(
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      colorScheme: _scheme(dark: dark),
      textTheme: AppTextStyle.buildTextTheme(isArabic: isArabic),
      fontFamily: isArabic ? 'Cairo' : 'Space Grotesk',
    ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: dark ? Brightness.dark : Brightness.light));
  }

  static ColorScheme _scheme({required bool dark}) {
    final primary = dark ? AppColors.primary : AppColors.primaryDark;
    final secondary = dark ? AppColors.secondary : AppColors.secondaryDark;
    final tertiary = dark ? AppColors.tertiary : AppColors.tertiaryDark;
    if (dark) {
      return ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        surface: AppColors.darkSurface,
        onPrimary: Colors.white,
        onSurface: AppColors.darkText,
      );
    }
    return ColorScheme.light(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: AppColors.lightSurface,
      onPrimary: Colors.white,
      onSurface: AppColors.lightText,
    );
  }

  static TextStyle _display(bool dark) {
    return TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -0.5,
      color: dark ? AppColors.darkText : AppColors.lightText,
    );
  }
}

/// Brand gradient used across the app.
abstract class AppGradients {
  const AppGradients._();

  static const LinearGradient brand = LinearGradient(
    colors: AppColors.brandGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient violet = LinearGradient(
    colors: AppColors.brandGradientViolet,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}