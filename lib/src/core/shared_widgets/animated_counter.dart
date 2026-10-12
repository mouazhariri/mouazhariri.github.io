import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Counts from 0 to [value] with eased motion once visible.
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.id,
    required this.value,
    this.duration = const Duration(milliseconds: 1600),
    this.style,
  });

  final String id;
  final int value;
  final Duration duration;
  final TextStyle? style;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  void _start() {
    if (_started) return;
    _started = true;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('counter-${widget.id}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05) _start();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final current = (widget.value * _animation.value).round();
          return Text(
            _format(current),
            style: widget.style,
          );
        },
      ),
    );
  }

  String _format(int n) {
    final digits = n.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final fromEnd = digits.length - 1 - i;
      buffer.write(digits[i]);
      if (fromEnd > 0 && fromEnd % 3 == 0) buffer.write(',');
    }
    return buffer.toString();
  }
}