import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Ambient drifting gradient blobs behind the page content.
class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRect(
          child: IgnorePointer(
            child: Stack(
              fit: StackFit.expand,
              children: [
                _DriftBlob(
                  color: scheme.primary.withValues(alpha: 0.16),
                  size: 520,
                  alignment: const Alignment(-0.9, -0.6),
                  drift: const Offset(140, 90),
                  duration: const Duration(seconds: 16),
                ),
                _DriftBlob(
                  color: scheme.secondary.withValues(alpha: 0.14),
                  size: 420,
                  alignment: const Alignment(1.1, -0.9),
                  drift: const Offset(-120, 140),
                  duration: const Duration(seconds: 19),
                ),
                _DriftBlob(
                  color: scheme.tertiary.withValues(alpha: 0.12),
                  size: 460,
                  alignment: const Alignment(0.3, 1.2),
                  drift: const Offset(-160, -120),
                  duration: const Duration(seconds: 22),
                ),
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _DriftBlob extends StatelessWidget {
  const _DriftBlob({
    required this.color,
    required this.size,
    required this.alignment,
    required this.drift,
    required this.duration,
  });

  final Color color;
  final double size;
  final Alignment alignment;
  final Offset drift;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .move(
            begin: Offset.zero,
            end: drift,
            duration: duration,
            curve: Curves.easeInOutSine,
          )
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.15, 1.15),
            duration: duration,
            curve: Curves.easeInOutSine,
          ),
    );
  }
}