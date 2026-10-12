import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

/// A refined hero visual: a slowly rotating globe built from an even sphere of
/// light points, wrapped by two glowing orbital rings.
///
/// The field is projected in perspective and reacts with a soft parallax to the
/// pointer. When the platform requests reduced motion it renders a single
/// composed frame instead of animating.
class ParticleField3D extends StatefulWidget {
  const ParticleField3D({
    super.key,
    this.spinDuration = const Duration(seconds: 48),
    this.pointCount = 640,
    this.primary,
    this.secondary,
  });

  final Duration spinDuration;
  final int pointCount;
  final Color? primary;
  final Color? secondary;

  @override
  State<ParticleField3D> createState() => _ParticleField3DState();
}

class _ParticleField3DState extends State<ParticleField3D>
    with SingleTickerProviderStateMixin {
  /// Golden angle — yields an even (Fibonacci) distribution of points.
  static const double _goldenAngle = 2.399963229728653;

  late final AnimationController _spin;
  late final List<vm.Vector3> _points;

  double _pointerX = 0;
  double _pointerY = 0;
  double _targetX = 0;
  double _targetY = 0;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _points = _fibonacciSphere(widget.pointCount);
    _spin = AnimationController(vsync: this, duration: widget.spinDuration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduce == _reduceMotion) {
      if (!reduce && !_spin.isAnimating) _spin.repeat();
      return;
    }
    _reduceMotion = reduce;
    if (reduce) {
      _spin.stop();
      _spin.value = 0.14;
    } else {
      _spin.repeat();
    }
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  static List<vm.Vector3> _fibonacciSphere(int count) {
    final safeCount = math.max(count, 2);
    final points = <vm.Vector3>[];
    for (var i = 0; i < safeCount; i++) {
      final y = 1 - (i / (safeCount - 1)) * 2; // 1 → -1
      final radius = math.sqrt(math.max(0, 1 - y * y));
      final theta = _goldenAngle * i;
      points.add(
        vm.Vector3(math.cos(theta) * radius, y, math.sin(theta) * radius),
      );
    }
    return points;
  }

  void _onHover(PointerHoverEvent event) {
    final size = context.size ?? Size.zero;
    if (size.isEmpty) return;
    _targetX = ((event.localPosition.dx / size.width) - 0.5) * 0.8;
    _targetY = ((event.localPosition.dy / size.height) - 0.5) * 0.8;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onHover: _onHover,
      onExit: (_) {
        _targetX = 0;
        _targetY = 0;
      },
      child: AnimatedBuilder(
        animation: _spin,
        builder: (context, _) {
          // Ease the pointer influence for a soft parallax.
          _pointerX += (_targetX - _pointerX) * 0.07;
          _pointerY += (_targetY - _pointerY) * 0.07;

          return CustomPaint(
            painter: _GlobePainter(
              points: _points,
              rotationX: 0.42 + _pointerY,
              rotationY: _spin.value * math.pi * 2 + _pointerX,
              progress: _spin.value,
              primary: widget.primary ?? scheme.primary,
              secondary: widget.secondary ?? scheme.secondary,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _GlobePainter extends CustomPainter {
  const _GlobePainter({
    required this.points,
    required this.rotationX,
    required this.rotationY,
    required this.progress,
    required this.primary,
    required this.secondary,
  });

  final List<vm.Vector3> points;
  final double rotationX;
  final double rotationY;
  final double progress;
  final Color primary;
  final Color secondary;

  static const double _focal = 4.6;
  static const double _ringRadius = 1.34;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.shortestSide <= 0) return;

    final center = size.center(Offset.zero);
    final scale = size.shortestSide * 0.30;

    final rotation = vm.Matrix4.identity()
      ..rotateX(rotationX)
      ..rotateY(rotationY);

    // Soft ambient halo behind the globe.
    final haloRadius = size.shortestSide * 0.54;
    canvas.drawCircle(
      center,
      haloRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            primary.withValues(alpha: 0.22),
            primary.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: haloRadius)),
    );

    // Orbital rings drawn behind the globe.
    _paintRing(
      canvas,
      center,
      scale,
      rotation,
      tilt: 0,
      color: primary,
      cometPhase: 0.0,
    );
    _paintRing(
      canvas,
      center,
      scale,
      rotation,
      tilt: math.pi / 3,
      color: secondary,
      cometPhase: 0.5,
    );

    // Project the sphere points; draw far → near for correct overlap.
    final dots = <_Dot>[];
    for (final v in points) {
      final r = rotation.transform3(v);
      final perspective = _focal / (_focal - r.z);
      dots.add(
        _Dot(
          x: center.dx + r.x * perspective * scale,
          y: center.dy + r.y * perspective * scale,
          depth: ((r.z + 1) / 2).clamp(0.0, 1.0),
        ),
      );
    }
    dots.sort((a, b) => a.depth.compareTo(b.depth));

    final paint = Paint();
    for (final dot in dots) {
      final depth = dot.depth;
      final color = Color.lerp(secondary.withValues(alpha: 0.4), primary, depth)!;
      paint.color = color.withValues(alpha: 0.10 + depth * 0.72);
      canvas.drawCircle(Offset(dot.x, dot.y), 0.6 + depth * 2.0, paint);
    }
  }

  void _paintRing(
    Canvas canvas,
    Offset center,
    double scale,
    vm.Matrix4 rotation, {
    required double tilt,
    required Color color,
    required double cometPhase,
  }) {
    const steps = 150;
    final tiltMatrix = vm.Matrix4.identity()..rotateX(tilt);

    Offset project(double angle) {
      var v = vm.Vector3(
        math.cos(angle) * _ringRadius,
        0,
        math.sin(angle) * _ringRadius,
      );
      v = tiltMatrix.transform3(v);
      final r = rotation.transform3(v);
      final perspective = _focal / (_focal - r.z);
      return Offset(
        center.dx + r.x * perspective * scale,
        center.dy + r.y * perspective * scale,
      );
    }

    final path = Path()..moveTo(project(0).dx, project(0).dy);
    for (var i = 1; i <= steps; i++) {
      final p = project((i / steps) * math.pi * 2);
      path.lineTo(p.dx, p.dy);
    }

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..strokeCap = StrokeCap.round
        ..color = color.withValues(alpha: 0.20),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.4
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
        ..color = color.withValues(alpha: 0.10),
    );

    // A soft comet travelling along the ring, giving it a sense of motion.
    final head = project(((progress + cometPhase) % 1.0) * math.pi * 2);
    canvas.drawCircle(head, 3.6, Paint()..color = color.withValues(alpha: 0.26));
    canvas.drawCircle(
      head,
      1.7,
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );
  }

  @override
  bool shouldRepaint(covariant _GlobePainter oldDelegate) =>
      oldDelegate.rotationX != rotationX ||
      oldDelegate.rotationY != rotationY ||
      oldDelegate.progress != progress;
}

class _Dot {
  const _Dot({required this.x, required this.y, required this.depth});

  final double x;
  final double y;
  final double depth;
}
