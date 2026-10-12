import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Renders either a Material [IconData] or a Font Awesome [FaIconData].
///
/// Font Awesome v11 wraps its glyphs in [FaIconData], which must be rendered
/// with [FaIcon] instead of [Icon]. This widget centralizes that branching so
/// callers can pass either type interchangeably.
class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size, this.color});

  final Object icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final value = icon;
    if (value is FaIconData) {
      return FaIcon(value, size: size, color: color);
    }
    if (value is IconData) {
      return Icon(value, size: size, color: color);
    }
    return Icon(Icons.category_rounded, size: size, color: color);
  }
}