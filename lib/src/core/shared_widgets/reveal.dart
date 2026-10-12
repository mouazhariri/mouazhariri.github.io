import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Reveals its child with an entrance animation the first time it scrolls
/// into view. Pass a unique [id] per usage site — it keys the detector.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.id,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 700),
    this.offset = const Offset(0, 32),
    this.axis = Axis.vertical,
    this.triggerOnce = true,
  });

  final String id;
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final Axis axis;
  final bool triggerOnce;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('reveal-${widget.id}'),
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0.05) {
          setState(() => _visible = true);
        } else if (!widget.triggerOnce && _visible && info.visibleFraction <= 0) {
          setState(() => _visible = false);
        }
      },
      child: widget.child.animate(target: _visible ? 1 : 0).fadeIn(
            duration: widget.duration,
            delay: widget.delay,
          ).slide(
            begin: widget.offset * (_visible ? 0 : 1),
            end: Offset.zero,
            duration: widget.duration,
            delay: widget.delay,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}