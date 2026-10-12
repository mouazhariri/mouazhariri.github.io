import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_page/src/core/shared_widgets/build_stream_splash.dart';

/// Pixel guards for the "built from code" splash.
///
/// These assert the story actually paints: the laptop screen lights up at the
/// top, code tokens fall through the middle, and the phone screen + app tile
/// light up at the bottom — rather than trusting layout alone.
void main() {
  const design = Size(420, 640);

  /// Counts "brand blue" pixels (indigo/cyan) inside [region].
  Future<int> brandPixels(
    WidgetTester tester,
    GlobalKey key,
    Rect region,
  ) async {
    final bytes = await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 1);
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      return data!.buffer.asUint8List();
    });
    expect(bytes, isNotNull);

    final w = design.width.toInt();
    var count = 0;
    for (var y = region.top.toInt(); y < region.bottom.toInt(); y++) {
      for (var x = region.left.toInt(); x < region.right.toInt(); x++) {
        final i = (y * w + x) * 4;
        final r = bytes![i], b = bytes[i + 2];
        if (b > 90 && b > r + 30) count++;
      }
    }
    return count;
  }

  Future<GlobalKey> pumpSplash(WidgetTester tester, double progress) async {
    tester.view.physicalSize = design;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final key = GlobalKey();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RepaintBoundary(
          key: key,
          child: BuildStreamSplash(
            progress: AlwaysStoppedAnimation<double>(progress),
            isDark: true,
          ),
        ),
      ),
    );
    await tester.pump();
    return key;
  }

  testWidgets('laptop, phone and app tile are all lit at the end',
      (tester) async {
    final key = await pumpSplash(tester, 0.80);

    // Laptop screen (top).
    final laptop = await brandPixels(
      tester,
      key,
      const Rect.fromLTWH(88, 54, 244, 132),
    );
    // Phone screen (bottom).
    final phone = await brandPixels(
      tester,
      key,
      const Rect.fromLTWH(152, 382, 116, 230),
    );

    expect(laptop, greaterThan(1500), reason: 'laptop screen should be lit');
    expect(phone, greaterThan(1500), reason: 'phone screen should be lit');

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('code tokens fall through the gap between the devices',
      (tester) async {
    final key = await pumpSplash(tester, 0.55);

    final gap = await brandPixels(
      tester,
      key,
      const Rect.fromLTWH(110, 214, 200, 150),
    );

    expect(gap, greaterThan(40), reason: 'code tokens should be mid-fall');

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('nothing is painted before the splash starts', (tester) async {
    final key = await pumpSplash(tester, 0.0);

    final all = await brandPixels(
      tester,
      key,
      const Rect.fromLTWH(0, 0, 420, 640),
    );

    expect(all, 0);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
