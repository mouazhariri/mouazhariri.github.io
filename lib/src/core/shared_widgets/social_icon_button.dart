import 'package:flutter/material.dart';

import '../utils/extensions/context_extension.dart';
import 'app_icon.dart';

/// Round icon button with a soft hover glow (social / quick actions).
class SocialIconButton extends StatefulWidget {
  const SocialIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onTap,
    this.background,
    this.iconColor,
    this.size = 46,
  });

  final Object icon;
  final String tooltip;
  final VoidCallback? onTap;
  final Color? background;
  final Color? iconColor;
  final double size;

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bg = widget.background ??
        (isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.04));
    final fg = widget.iconColor ??
        (isDark ? Colors.white : const Color(0xFF0F172A));

    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 300),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: widget.size,
            height: widget.size,
            // Centering the glyph explicitly matters for Font Awesome icons:
            // `FaIcon` (unlike Material's `Icon`) does not wrap itself in a
            // centered square, so without this it hugs the top-start corner.
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hover ? Theme.of(context).colorScheme.primary : bg,
              border: Border.all(
                color: _hover
                    ? Colors.transparent
                    : (isDark ? Colors.white12 : Colors.black12),
              ),
              boxShadow: _hover
                  ? [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.45),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: AppIcon(
              widget.icon,
              size: widget.size * 0.44,
              color: _hover ? Colors.white : fg,
            ),
          ),
        ),
      ),
    );
  }
}