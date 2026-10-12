import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography builder.
///
/// Uses a geometric family for Latin text (Space Grotesk) and Cairo for
/// Arabic — both from google_fonts, selected by the active locale.
abstract class AppTextStyle {
  const AppTextStyle._();

  static TextTheme buildTextTheme({required bool isArabic}) {
    final base = ThemeData.light().textTheme; // base metrics only
    if (isArabic) {
      return GoogleFonts.cairoTextTheme(base);
    }
    return GoogleFonts.spaceGroteskTextTheme(base);
  }

  /// Headline used for big display text (name, section titles).
  static TextStyle applyGeneric(TextStyle style, {required bool isArabic}) {
    return isArabic
        ? GoogleFonts.cairo(fontSize: style.fontSize, fontWeight: style.fontWeight, height: style.height)
        : GoogleFonts.spaceGrotesk(fontSize: style.fontSize, fontWeight: style.fontWeight, height: style.height);
  }
}