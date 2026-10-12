import 'package:flutter/material.dart';

/// Design tokens — all colors of the app live here (FLUTTER_PROJECT_STANDARDS.md §11.1).
///
/// Identity: indigo → cyan, dark-first.
abstract class AppColors {
  const AppColors._();

  // ── Brand ──
  static const Color primary = Color(0xFF6366F1); // indigo
  static const Color secondary = Color(0xFF22D3EE); // cyan
  static const Color tertiary = Color(0xFFA78BFA); // violet
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color secondaryDark = Color(0xFF0E7490);
  static const Color tertiaryDark = Color(0xFF7C3AED);

  // ── Dark surface ──
  static const Color darkBackground = Color(0xFF070B14);
  static const Color darkSurface = Color(0xFF0D1424);
  static const Color darkSurfaceElevated = Color(0xFF131C30);
  static const Color darkBorder = Color(0xFF1E293B);

  // ── Light surface ──
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // ── Text ──
  static const Color darkText = Color(0xFFE2E8F0);
  static const Color darkMuted = Color(0xFF94A3B8);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightMuted = Color(0xFF475569);

  // ── Feedback ──
  static const Color success = Color(0xFF34D399);
  static const Color error = Color(0xFFF87171);
  static const Color warning = Color(0xFFFBBF24);

  // ── Brand gradient ──
  static const List<Color> brandGradient = [primary, secondary];
  static const List<Color> brandGradientViolet = [tertiary, primary];
}