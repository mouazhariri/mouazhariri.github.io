import 'package:flutter/material.dart';

/// Small set of context helpers shared by presentation widgets.
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get scheme => Theme.of(this).colorScheme;

  TextTheme get text => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  // ── Responsive breakpoints ──
  bool get isCompact => screenWidth < 760;

  bool get isMedium => screenWidth >= 760 && screenWidth < 1100;

  bool get isExpanded => screenWidth >= 1100;
}