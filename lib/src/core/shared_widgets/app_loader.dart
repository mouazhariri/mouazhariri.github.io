import 'package:flutter/material.dart';

/// Brand gradient loading ring.
class AppLoader extends StatefulWidget {
  const AppLoader({super.key, this.label});

  final String? label;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: RotationTransition(
              turns: _controller,
              child: CustomPaint(
                painter: _GradientRingPainter(),
              ),
            ),
          ),
          if (widget.label != null) ...[
            const SizedBox(height: 18),
            Text(widget.label!,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

class _GradientRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [Color(0xFF6366F1), Color(0xFF22D3EE), Color(0xFF6366F1)],
        transform: GradientRotation(0.5),
      ).createShader(rect);
    // Open arc so rotation is visible.
    canvas.drawArc(rect.deflate(5), 0, 2.4, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}