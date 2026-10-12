import 'package:flutter/material.dart';

/// Parses `#RRGGBB` (or `RRGGBB`) hex strings into a [Color].
Color colorFromHex(String hex) {
  final cleaned = hex.replaceFirst('#', '').padLeft(6, '0');
  final value = int.tryParse(cleaned, radix: 16) ?? 0x6366F1;
  return Color(0xFF000000 | value);
}