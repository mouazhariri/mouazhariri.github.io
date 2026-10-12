import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

/// Wraps [child] with a subtle 3D perspective tilt that follows the pointer.
///
/// The effect is deliberately restrained — a few degrees of rotation plus a
/// small scale — so it reads as premium depth rather than a gimmick. It is
/// disabled when the platform requests reduced motion.
class TiltCard3D extends StatefulWidget {
  const TiltCard3D({
    super.key,
    required this.child,
    this.maxTilt = 0.06,
    this.hoverScale = 1.012,
    this.duration = const Duration(milliseconds: 240),
    this.glow = false,
  });

  final Widget child;
  final double maxTilt;
  final double hoverScale;
  final Duration duration;
  final bool glow;

  @override
  State<TiltCard3D> createState() => _TiltCard3DState();
}

class _TiltCard3DState extends State<TiltCard3D> {
  double _rx = 0;
  double _ry = 0;
  bool _hover = false;

  void _onHover(PointerHoverEvent event) {
    final size = context.size ?? Size.zero;
    if (size.isEmpty) return;
    final dx = (event.localPosition.dx / size.width - 0.5) * 2; // -1..1
    final dy = (event.localPosition.dy / size.height - 0.5) * 2;
    setState(() {
      _ry = dx * widget.maxTilt;
      _rx = -dy * widget.maxTilt;
      _hover = true;
    });
  }

  void _onExit(PointerEvent event) {
    if (!_hover && _rx == 0 && _ry == 0) return;
    setState(() {
      _rx = 0;
      _ry = 0;
      _hover = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: reduceMotion ? null : _onHover,
      onExit: _onExit,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: _hover && !reduceMotion ? 1 : 0),
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        builder: (context, t, child) {
          final matrix = vm.Matrix4.identity()
            ..setEntry(3, 2, 0.0012)
            ..rotateX(_rx * t)
            ..rotateY(_ry * t);
          final scale = 1 + (widget.hoverScale - 1) * t;
          return AnimatedContainer(
            duration: widget.duration,
            curve: Curves.easeOut,
            decoration: widget.glow
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: scheme.primary.withValues(alpha: t * 0.30),
                        blurRadius: 24 + t * 24,
                        spreadRadius: t * 5,
                      ),
                    ],
                  )
                : null,
            child: Transform(
              alignment: Alignment.center,
              transform: matrix.scaledByDouble(scale, scale, 1, 1),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
