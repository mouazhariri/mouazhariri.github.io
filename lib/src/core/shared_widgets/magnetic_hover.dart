import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Moves [child] slightly toward the pointer — a "magnetic" hover effect.
class MagneticHover extends StatefulWidget {
  const MagneticHover({
    super.key,
    required this.child,
    this.strength = 8,
    this.duration = const Duration(milliseconds: 220),
  });

  final Widget child;
  final double strength;
  final Duration duration;

  @override
  State<MagneticHover> createState() => _MagneticHoverState();
}

class _MagneticHoverState extends State<MagneticHover> {
  Offset _offset = Offset.zero;

  void _onHover(PointerHoverEvent event) {
    final size = context.size ?? Size.zero;
    if (size.isEmpty) return;
    final dx = (event.localPosition.dx / size.width - 0.5) * 2;
    final dy = (event.localPosition.dy / size.height - 0.5) * 2;
    setState(() {
      _offset = Offset(dx * widget.strength, dy * widget.strength);
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _offset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: _onHover,
      onExit: _onExit,
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(begin: Offset.zero, end: _offset),
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        builder: (context, value, child) =>
            Transform.translate(offset: value, child: child),
        child: widget.child,
      ),
    );
  }
}