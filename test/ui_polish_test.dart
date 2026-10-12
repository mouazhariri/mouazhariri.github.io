import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_page/features/portfolio/domain/entities/skill_entity.dart';
import 'package:profile_page/features/portfolio/presentation/widgets/skills_section.dart';
import 'package:profile_page/src/core/localization/current_language.dart';
import 'package:profile_page/src/core/shared_widgets/particle_field_3d.dart';
import 'package:profile_page/src/core/shared_widgets/social_icon_button.dart';
import 'package:profile_page/src/core/utils/theme/app_theme.dart';
import 'package:profile_page/src/infrastructure/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await initSharedPreferences();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('icons are painted at the centre of the circular social button',
      (tester) async {
    const canvas = 120.0;
    const buttonSize = 64.0;
    tester.view.physicalSize = const Size(canvas, canvas);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final boundaryKey = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.build(brightness: Brightness.dark, isArabic: false),
        home: Scaffold(
          backgroundColor: Colors.black,
          body: RepaintBoundary(
            key: boundaryKey,
            child: const Center(
              child: SocialIconButton(
                icon: FontAwesomeIcons.github,
                tooltip: 'GitHub',
                size: buttonSize,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    // The button's background/border are faint; the white glyph is the only
    // bright content. Locate its painted centroid and compare with the centre.
    final bytes = await tester.runAsync(() async {
      final boundary = boundaryKey.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 1);
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      return data!.buffer.asUint8List();
    });
    expect(bytes, isNotNull);

    var sumX = 0.0, sumY = 0.0, count = 0;
    for (var y = 0; y < canvas.toInt(); y++) {
      for (var x = 0; x < canvas.toInt(); x++) {
        final i = (y * canvas.toInt() + x) * 4;
        if (bytes![i] > 180 && bytes[i + 1] > 180 && bytes[i + 2] > 180) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }

    // The glyph must actually render...
    expect(count, greaterThan(30));
    // ...and its centre of mass must sit on the button's centre.
    final centre = canvas / 2;
    expect((sumX / count - centre).abs(), lessThan(4.0));
    expect((sumY / count - centre).abs(), lessThan(4.0));

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('the hero globe paints a wide field of points', (tester) async {
    const canvas = 400.0;
    tester.view.physicalSize = const Size(canvas, canvas);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.build(brightness: Brightness.dark, isArabic: false),
        home: Scaffold(
          backgroundColor: Colors.black,
          body: RepaintBoundary(
            key: key,
            child: const SizedBox(
              width: canvas,
              height: canvas,
              child: ParticleField3D(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    final bytes = await tester.runAsync(() async {
      final boundary = key.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 1);
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      return data!.buffer.asUint8List();
    });
    expect(bytes, isNotNull);

    // Points are strongly blue-ish; the halo and rings are far dimmer, so
    // thresholding the blue channel isolates the globe's dot field.
    var dots = 0;
    var minX = 1 << 30, maxX = -1, minY = 1 << 30, maxY = -1;
    final n = canvas.toInt();
    for (var y = 0; y < n; y++) {
      for (var x = 0; x < n; x++) {
        final i = (y * n + x) * 4;
        if (bytes![i + 2] > 90) {
          dots++;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }

    // A real dot globe paints many points...
    expect(dots, greaterThan(150));
    // ...that it is a field, not a solid disc...
    expect(dots, lessThan(n * n ~/ 2));
    // ...spread across a wide, centred area (not a single corner blob).
    expect(maxX - minX, greaterThan(canvas * 0.4));
    expect(maxY - minY, greaterThan(canvas * 0.4));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('skills render as plain tags, never as percentage ratings',
      (tester) async {
    tester.view.physicalSize = const Size(1100, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const skills = [
      SkillGroupEntity(
        id: 'mobile',
        groupKey: 'skills.group.mobile',
        iconKey: 'smartphone',
        items: [SkillEntity(name: 'Flutter'), SkillEntity(name: 'Dart')],
      ),
      SkillGroupEntity(
        id: 'api',
        groupKey: 'skills.group.api',
        iconKey: 'api',
        items: [SkillEntity(name: 'GraphQL'), SkillEntity(name: 'GetX')],
      ),
    ];

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        startLocale: const Locale('en'),
        fallbackLocale: const Locale('en'),
        saveLocale: false,
        child: Builder(
          builder: (context) => MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            theme: AppTheme.build(brightness: Brightness.dark, isArabic: false),
            home: const Scaffold(body: SkillsSection(skills: skills)),
          ),
        ),
      ),
    );
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }

    expect(find.text('Skills & Technologies'), findsOneWidget);
    expect(find.text('GraphQL'), findsOneWidget);
    expect(find.text('GetX'), findsOneWidget);
    expect(find.textContaining('%'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
