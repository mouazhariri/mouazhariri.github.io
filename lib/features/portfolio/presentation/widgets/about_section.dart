import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/core/shared_widgets/animated_counter.dart';
import '../../../../src/core/shared_widgets/app_button.dart';
import '../../../../src/core/shared_widgets/reveal.dart';
import '../../../../src/core/shared_widgets/section_header.dart';
import '../../../../src/core/shared_widgets/section_scaffold.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/functions/cv_downloader.dart';
import '../../../../src/core/utils/functions/launch_utils.dart';
import '../../../../src/core/utils/theme/app_colors.dart';
import '../../../../src/core/utils/theme/app_theme.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/stat_entity.dart';

/// About: avatar, bio, facts, animated stats.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isCompact;

    return SectionScaffold(
      child: Column(
        children: [
          if (!isCompact) const SizedBox(height: 24),
          Reveal(
            id: 'about-header',
            child: SectionHeader(
              overline: context.tr('about.overline'),
              title: context.tr('about.title'),
              subtitle: context.tr('about.subtitle'),
            ),
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 860;
              if (compact) {
                return Column(
                  children: [
                    _Avatar(profile: profile),
                    const SizedBox(height: 40),
                    _AboutBody(profile: profile),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: _Avatar(profile: profile)),
                  const SizedBox(width: 56),
                  Expanded(flex: 6, child: _AboutBody(profile: profile)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return Reveal(
      id: 'about-avatar',
      child: SizedBox(
        width: 280,
        height: 280,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating conic ring
            const SizedBox.expand(child: CustomPaint(painter: _ConicRingPainter())),
            // Avatar
            Container(
              width: 210,
              height: 210,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.brand,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 60,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: Container(
                width: 196,
                height: 196,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Text(
                  profile.monogram,
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withValues(alpha: 0.95),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            // Floating badges
            const Positioned(
              top: 34,
              left: 6,
              child: _Badge(label: 'Clean Architecture'),
            ),
            const Positioned(
              bottom: 30,
              right: 0,
              child: _Badge(label: 'SOLID'),
            ),
            const Positioned(
              bottom: 78,
              left: 26,
              child: _Badge(label: 'Riverpod', colored: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, this.colored = false});

  final String label;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: colored ? AppGradients.brand : null,
        color: colored
            ? null
            : (isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white),
        border: Border.all(
          color: colored
              ? Colors.transparent
              : (isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: colored ? Colors.white : (isDark ? Colors.white : const Color(0xFF334155)),
        ),
      ),
    );
  }
}

class _AboutBody extends StatelessWidget {
  const _AboutBody({required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final isDark = context.isDarkMode;
    final muted = isDark ? AppColors.darkMuted : AppColors.lightMuted;

    final facts = [
      (
        Icons.location_on_rounded,
        context.tr('about.facts.location'),
        profile.location,
      ),
      (
        Icons.alternate_email_rounded,
        context.tr('about.facts.email'),
        profile.email,
      ),
      (
        Icons.phone_rounded,
        context.tr('about.facts.phone'),
        profile.phone,
      ),
      (
        Icons.language_rounded,
        context.tr('about.facts.languages'),
        context.tr('about.facts.languagesValue'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('about.summary'),
          style: text.bodyLarge?.copyWith(fontSize: 16.5, color: muted),
        ),
        const SizedBox(height: 16),
        Text(
          context.tr('about.summary2'),
          style: text.bodyLarge?.copyWith(fontSize: 16.5, color: muted),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 28,
          runSpacing: 18,
          children: [
            for (final fact in facts)
              SizedBox(
                width: 240,
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: AppGradients.brand,
                      ),
                      child: Icon(fact.$1, size: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fact.$2,
                            style: TextStyle(fontSize: 12, color: muted, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            fact.$3,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : AppColors.lightText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 36),
        // Stats
        Wrap(
          spacing: 40,
          runSpacing: 24,
          children: [
            for (final stat in profile.stats)
              _StatBlock(stat: stat, muted: muted),
          ],
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            AppButton(
              label: context.tr('about.downloadCv'),
              icon: Icons.download_rounded,
              onPressed: CvDownloader.download,
            ),
            AppButton(
              label: context.tr('about.letsTalk'),
              icon: Icons.forum_rounded,
              variant: AppButtonVariant.outline,
              onPressed: () => LaunchUtils.sendEmail(to: profile.email),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({required this.stat, required this.muted});

  final StatEntity stat;
  final Color muted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCounter(
              id: 'about-stat-${stat.labelKey}',
              value: stat.value,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
            Text(
              stat.suffix,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          stat.labelKey.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: muted),
        ),
      ],
    );
  }
}

class _ConicRingPainter extends CustomPainter {
  const _ConicRingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..shader = const SweepGradient(
        colors: [Color(0xFF6366F1), Color(0xFF22D3EE), Color(0xFFA78BFA), Color(0xFF6366F1)],
        stops: [0, 0.4, 0.75, 1],
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawArc(rect.deflate(14), -0.8, 2.2, false, ring);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}