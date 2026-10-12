import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/theme/app_colors.dart';
import '../utils/theme/app_theme.dart';

/// The "built from code" splash.
///
/// A laptop at the top wakes up and streams glowing code tokens down into a
/// phone at the bottom, where they assemble into the app icon. The phone then
/// launches and the whole scene fades away to reveal the portfolio.
///
/// The scene is drawn in a fixed `420 × 640` design space and scaled to fit the
/// available box, so the composition stays identical on every screen size.
class BuildStreamSplash extends StatelessWidget {
  const BuildStreamSplash({
    super.key,
    required this.progress,
    required this.isDark,
  });

  /// Splash timeline, `0 → 1`.
  final Animation<double> progress;
  final bool isDark;

  /// Matches the exit interval used by the painter's owner.
  static const double exitStart = 0.88;

  @override
  Widget build(BuildContext context) {
    final background =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        final t = progress.value;
        final exit = Curves.easeInCubic.transform(
          ((t - exitStart) / (1 - exitStart)).clamp(0.0, 1.0),
        );
        return Opacity(
          opacity: (1 - exit).clamp(0.0, 1.0),
          child: ColoredBox(
            color: background,
            child: CustomPaint(
              size: Size.infinite,
              painter: _SplashPainter(progress: t, isDark: isDark),
            ),
          ),
        );
      },
    );
  }
}

class _SplashPainter extends CustomPainter {
  _SplashPainter({required this.progress, required this.isDark});

  final double progress;
  final bool isDark;

  // ── Design space ──
  static const double _w = 420;
  static const double _h = 640;

  // ── Timeline (fractions of the controller) ──
  static const double _enterEnd = 0.16;
  static const double _lightStart = 0.16;
  static const double _lightEnd = 0.34;
  static const double _igniteStart = 0.58;
  static const double _igniteEnd = 0.76;
  static const double _tileStart = 0.70;
  static const double _tileEnd = 0.84;
  static const double _popStart = 0.82;
  static const double _popEnd = 0.92;

  // ── Geometry ──
  static const Rect _laptopBezel = Rect.fromLTWH(78, 44, 264, 152);
  static const Rect _laptopScreen = Rect.fromLTWH(88, 54, 244, 132);
  static const Rect _phoneBodyRect = Rect.fromLTWH(144, 372, 132, 250);
  static const Rect _phoneScreenRect = Rect.fromLTWH(152, 382, 116, 230);
  static const Offset _phoneCentre = Offset(210, 497);

  static double _seg(double t, double a, double b, Curve curve) =>
      curve.transform(((t - a) / (b - a)).clamp(0.0, 1.0));

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  // ── Colours ──
  Color get _device => isDark ? const Color(0xFF0D1424) : Colors.white;
  Color get _border =>
      isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
  Color get _base => isDark ? const Color(0xFF131C30) : const Color(0xFFE9EDF4);
  static const Color _screen = Color(0xFF05070C);

  // ── Tokens (deterministic, built once) ──
  static final List<_Token> _tokens = _buildTokens();

  static List<_Token> _buildTokens() {
    final rnd = math.Random(11);
    const glyphs = [
      '</>',
      '{ }',
      ';',
      '( )',
      'Flutter',
      'Dart',
      '=>',
      '[ ]',
      'const',
      '::',
      'await',
      'int',
    ];
    final colors = [AppColors.primary, AppColors.secondary, AppColors.tertiary];
    return List.generate(16, (i) {
      final painter = TextPainter(
        text: TextSpan(
          text: glyphs[i % glyphs.length],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      return _Token(
        elapsed: 0.34 + rnd.nextDouble() * 0.28,
        duration: 0.18 + rnd.nextDouble() * 0.06,
        sway: rnd.nextDouble() * math.pi * 2,
        spread: (rnd.nextDouble() - 0.5) * 140,
        color: colors[i % colors.length],
        painter: painter,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(size.width / _w, size.height / _h);
    canvas.save();
    canvas.translate(
      (size.width - _w * scale) / 2,
      (size.height - _h * scale) / 2,
    );
    canvas.scale(scale);

    _paintBackdrop(canvas);

    final enter = _seg(progress, 0, _enterEnd, Curves.easeOutCubic);
    _paintStream(canvas);
    _paintLaptop(canvas, enter, (1 - enter) * -52);
    _paintTokens(canvas);
    _paintPhone(canvas, enter, (1 - enter) * 64);

    canvas.restore();
  }

  void _paintBackdrop(Canvas canvas) {
    final rect = Rect.fromCircle(center: const Offset(210, 330), radius: 340);
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, _w, _h),
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
            Colors.transparent,
          ],
        ).createShader(rect),
    );
  }

  /// Faint energy band between the laptop and the phone while code is falling.
  void _paintStream(Canvas canvas) {
    final flow = _seg(progress, 0.30, 0.64, Curves.easeOut);
    if (flow <= 0) return;
    final rect = const Rect.fromLTWH(150, 206, 120, 166);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0),
            AppColors.secondary.withValues(alpha: 0.12 * flow),
            AppColors.primary.withValues(alpha: 0),
          ],
        ).createShader(rect),
    );
  }

  void _paintLaptop(Canvas canvas, double appear, double dy) {
    if (appear <= 0) return;
    canvas.saveLayer(
      const Rect.fromLTWH(0, 0, _w, _h),
      Paint()..color = Colors.white.withValues(alpha: appear),
    );
    canvas.translate(0, dy);

    // Base / deck.
    final base = Path()
      ..moveTo(62, 196)
      ..lineTo(358, 196)
      ..lineTo(348, 210)
      ..lineTo(72, 210)
      ..close();
    canvas.drawPath(base, Paint()..color = _base);
    canvas.drawPath(
      base,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = _border,
    );

    // Lid bezel.
    final bezel =
        RRect.fromRectAndRadius(_laptopBezel, const Radius.circular(12));
    canvas.drawRRect(bezel, Paint()..color = _device);
    canvas.drawRRect(
      bezel,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _border,
    );

    // Screen.
    final screen =
        RRect.fromRectAndRadius(_laptopScreen, const Radius.circular(7));
    canvas.save();
    canvas.clipRRect(screen);
    canvas.drawRect(_laptopScreen, Paint()..color = _screen);

    final lit = _seg(progress, _lightStart, _lightEnd, Curves.easeInOut);
    if (lit > 0) {
      canvas.drawRect(
        _laptopScreen,
        Paint()
          ..shader = LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.85 * lit),
              AppColors.secondary.withValues(alpha: 0.85 * lit),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(_laptopScreen),
      );
      _paintCodeLines(canvas, lit);
    }
    canvas.restore();
    canvas.restore();
  }

  void _paintCodeLines(Canvas canvas, double lit) {
    const left = 104.0;
    const lineHeight = 6.0;
    const widths = [92.0, 128.0, 58.0, 108.0, 72.0, 44.0];
    const alphas = [0.90, 0.62, 0.78, 0.52, 0.72, 0.46];
    for (var i = 0; i < widths.length; i++) {
      final top = 72.0 + i * 16;
      final rect = Rect.fromLTWH(left, top, widths[i], lineHeight);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(3)),
        Paint()..color = Colors.white.withValues(alpha: lit * alphas[i]),
      );
    }

    // Blinking caret at the end of the last line.
    final blink = ((progress * 9) % 1) < 0.55 ? 1.0 : 0.2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(left + 50, 150, 3, 10),
        const Radius.circular(1.5),
      ),
      Paint()..color = Colors.white.withValues(alpha: lit * blink),
    );
  }

  void _paintTokens(Canvas canvas) {
    for (final token in _tokens) {
      final p = (progress - token.elapsed) / token.duration;
      if (p <= 0 || p >= 1) continue;

      final opacity = _tokenOpacity(p);
      if (opacity <= 0.01) continue;

      final easeX = Curves.easeInOut.transform(p);
      final x = _lerp(210 + token.spread, 210 + token.spread * 0.12, easeX) +
          math.sin(token.sway + p * 4) * 8 * (1 - p);
      final y = _lerp(206, 470, p * p); // gravity acceleration
      _paintToken(canvas, token, Offset(x, y), opacity);
    }
  }

  double _tokenOpacity(double p) {
    final fadeIn = (p / 0.12).clamp(0.0, 1.0);
    final fadeOut = ((1 - p) / 0.28).clamp(0.0, 1.0);
    return (fadeIn * fadeOut).clamp(0.0, 1.0);
  }

  void _paintToken(Canvas canvas, _Token token, Offset centre, double opacity) {
    final width = token.painter.width + 14;
    final height = token.painter.height + 10;
    final rect = Rect.fromCenter(center: centre, width: width, height: height);
    final chip = RRect.fromRectAndRadius(rect, Radius.circular(height / 2));

    canvas.saveLayer(
      rect.inflate(16),
      Paint()..color = Colors.white.withValues(alpha: opacity),
    );
    canvas.drawRRect(
      chip,
      Paint()
        ..color = token.color.withValues(alpha: 0.26)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
    );
    canvas.drawRRect(chip, Paint()..color = token.color.withValues(alpha: 0.16));
    canvas.drawRRect(
      chip,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = token.color.withValues(alpha: 0.85),
    );
    token.painter.paint(canvas, Offset(rect.left + 7, rect.top + 5));
    canvas.restore();
  }

  void _paintPhone(Canvas canvas, double appear, double dy) {
    if (appear <= 0) return;

    final popT = ((progress - _popStart) / (_popEnd - _popStart))
        .clamp(0.0, 1.0);
    final popScale = 1 + 0.06 * math.sin(popT * math.pi);

    canvas.saveLayer(
      const Rect.fromLTWH(0, 0, _w, _h),
      Paint()..color = Colors.white.withValues(alpha: appear),
    );
    canvas.translate(0, dy);
    if (popT > 0) {
      canvas.translate(_phoneCentre.dx, _phoneCentre.dy);
      canvas.scale(popScale);
      canvas.translate(-_phoneCentre.dx, -_phoneCentre.dy);
    }

    final ignite = _seg(progress, _igniteStart, _igniteEnd, Curves.easeOutCubic);
    final tile = _seg(progress, _tileStart, _tileEnd, Curves.easeOutBack);

    // Body.
    final body =
        RRect.fromRectAndRadius(_phoneBodyRect, const Radius.circular(24));
    canvas.drawRRect(body, Paint()..color = _device);
    canvas.drawRRect(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = _border,
    );

    // Screen.
    final screen =
        RRect.fromRectAndRadius(_phoneScreenRect, const Radius.circular(16));
    canvas.save();
    canvas.clipRRect(screen);
    canvas.drawRect(_phoneScreenRect, Paint()..color = _screen);

    final gridAlpha = (1 - ignite).clamp(0.0, 1.0) * 0.35;
    if (gridAlpha > 0) _paintHomeGrid(canvas, gridAlpha);

    if (ignite > 0) {
      canvas.drawRect(
        _phoneScreenRect,
        Paint()
          ..shader = LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.9 * ignite),
              AppColors.secondary.withValues(alpha: 0.9 * ignite),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(_phoneScreenRect),
      );
    }

    if (tile > 0) _paintAppTile(canvas, tile.clamp(0.0, 1.1), ignite);

    canvas.restore(); // screen clip
    canvas.restore(); // opacity layer
  }

  void _paintHomeGrid(Canvas canvas, double alpha) {
    const size = 16.0;
    const gap = 16.0;
    const cols = 3;
    const rows = 3;
    final totalW = cols * size + (cols - 1) * gap;
    final startX = _phoneScreenRect.center.dx - totalW / 2;
    final startY = _phoneScreenRect.top + 34;
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final rect = Rect.fromLTWH(
          startX + c * (size + gap),
          startY + r * (size + gap),
          size,
          size,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          Paint()..color = Colors.white.withValues(alpha: alpha),
        );
      }
    }
  }

  void _paintAppTile(Canvas canvas, double scale, double ignite) {
    final size = 54.0 * scale;
    if (size <= 0) return;
    final tileRect =
        Rect.fromCenter(center: Offset.zero, width: size, height: size);

    canvas.save();
    canvas.translate(_phoneCentre.dx, _phoneCentre.dy);

    canvas.drawCircle(
      Offset.zero,
      size * 0.95,
      Paint()
        ..color = AppColors.secondary.withValues(alpha: 0.30 * ignite)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(tileRect, Radius.circular(size * 0.28)),
      Paint()..shader = AppGradients.brand.createShader(tileRect),
    );

    final label = TextPainter(
      text: TextSpan(
        text: 'MH',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.42,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label.paint(canvas, Offset(-label.width / 2, -label.height / 2));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SplashPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isDark != isDark;
}

class _Token {
  const _Token({
    required this.elapsed,
    required this.duration,
    required this.sway,
    required this.spread,
    required this.color,
    required this.painter,
  });

  /// Timeline fraction at which the token leaves the laptop.
  final double elapsed;

  /// Lifetime as a fraction of the whole timeline.
  final double duration;
  final double sway;

  /// Horizontal offset from the falling lane's centre.
  final double spread;
  final Color color;
  final TextPainter painter;
}
