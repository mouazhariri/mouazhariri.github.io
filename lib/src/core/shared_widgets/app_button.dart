import 'package:flutter/material.dart';

import '../utils/theme/app_theme.dart';

enum AppButtonVariant { primary, outline }

/// Primary CTA / outline button with hover + press feedback.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.expanded = false,
    this.busy = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool expanded;
  final bool busy;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == AppButtonVariant.primary;
    final enabled = widget.onPressed != null && !widget.busy;

    final child = Row(
      mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.busy) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: isPrimary ? Colors.white : Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: 20),
          const SizedBox(width: 10),
        ],
        Flexible(
          child: Text(
            widget.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );

    final button = Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: isPrimary
            ? AppGradients.brand
            : null,
        color: isPrimary ? null : Colors.transparent,
        border: isPrimary
            ? null
            : Border.all(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.55),
                width: 1.4,
              ),
        boxShadow: isPrimary && enabled
            ? [
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: _hover ? 0.5 : 0.3),
                  blurRadius: _hover ? 28 : 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: child,
    );

    final foreground = isPrimary ? Colors.white : Theme.of(context).colorScheme.primary;

    final content = DefaultTextStyle(
      style: TextStyle(color: foreground),
      child: IconTheme(
        data: IconThemeData(color: foreground, size: 20),
        child: button,
      ),
    );

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: enabled ? widget.onPressed : null,
        child: AnimatedScale(
          scale: _hover && enabled ? 1.03 : 1,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: Opacity(opacity: enabled ? 1 : 0.45, child: content),
        ),
      ),
    );
  }
}