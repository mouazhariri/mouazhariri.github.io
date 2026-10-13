import 'package:flutter/material.dart';

import '../utils/extensions/context_extension.dart';

/// Consistent horizontal rhythm for every page section: center + max width.
///
/// When no explicit [padding] is given, the spacing adapts to the viewport so
/// sections stay comfortable on phones without feeling cramped on desktop.
class SectionScaffold extends StatelessWidget {
  const SectionScaffold({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: context.isCompact ? 18 : 24,
          vertical: context.isCompact ? 64 : 96,
        );
    return Padding(
      padding: effectivePadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
