import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../src/core/shared_widgets/app_button.dart';
import '../../../../src/core/shared_widgets/magnetic_hover.dart';
import '../../../../src/core/shared_widgets/particle_field_3d.dart';
import '../../../../src/core/shared_widgets/social_icon_button.dart';
import '../../../../src/core/shared_widgets/typewriter_text.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/functions/cv_downloader.dart';
import '../../../../src/core/utils/functions/launch_utils.dart';
import '../../../../src/core/utils/theme/app_colors.dart';
import '../../domain/entities/portfolio_enums.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/social_link_entity.dart';
import '../../domain/entities/stat_entity.dart';

Object _iconFor(SocialLinkType type) {
  switch (type) {
    case SocialLinkType.github:
      return FontAwesomeIcons.github;
    case SocialLinkType.linkedin:
      return FontAwesomeIcons.linkedinIn;
    case SocialLinkType.whatsapp:
      return FontAwesomeIcons.whatsapp;
    case SocialLinkType.telegram:
      return FontAwesomeIcons.telegram;
    case SocialLinkType.email:
      return FontAwesomeIcons.envelope;
  }
}

/// Full-viewport hero: headline, typewriter roles, CTAs, socials and the
/// rotating 3D particle field.
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.profile,
    required this.socialLinks,
    required this.onContact,
    required this.onExplore,
  });

  final ProfileEntity profile;
  final List<SocialLinkEntity> socialLinks;
  final VoidCallback onContact;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isCompact;
    final height = math.max(640.0, context.screenHeight * 0.94);

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          if (isCompact)
            const Positioned.fill(
              child: Opacity(
                opacity: 0.45,
                child: IgnorePointer(child: ParticleField3D()),
              ),
            ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 96, 24, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _HeroCopy(
                          profile: profile,
                          socialLinks: socialLinks,
                          isCompact: isCompact,
                          onContact: onContact,
                        ),
                      ),
                      if (!isCompact) ...[
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 4,
                          child: _HeroVisual(stats: profile.stats),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Scroll hint
          Positioned(
            left: 0,
            right: 0,
            bottom: 18,
            child: Center(
              child: _ScrollHint(onTap: onExplore),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.profile,
    required this.socialLinks,
    required this.isCompact,
    required this.onContact,
  });

  final ProfileEntity profile;
  final List<SocialLinkEntity> socialLinks;
  final bool isCompact;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final isDark = context.isDarkMode;
    final nameShader = const LinearGradient(
      colors: AppColors.brandGradient,
    ).createShader(const Rect.fromLTWH(0, 0, 360, 80));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AvailabilityChip().animate().fadeIn(duration: 500.ms).slideX(begin: -24, end: 0),
        const SizedBox(height: 22),
        Text(
          context.tr('hero.hello'),
          style: text.bodyLarge?.copyWith(fontSize: 20),
        ).animate().fadeIn(duration: 500.ms).slideX(begin: -24, end: 0, delay: 150.ms),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${profile.name.split(' ').first} ',
                style: text.displayLarge?.copyWith(fontSize: isCompact ? 44 : 60, height: 1.05),
              ),
              TextSpan(
                text: profile.name.split(' ').sublist(1).join(' '),
                style: text.displayLarge?.copyWith(
                  fontSize: isCompact ? 44 : 60,
                  height: 1.05,
                  foreground: Paint()..shader = nameShader,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 24, end: 0, delay: 250.ms),
        const SizedBox(height: 14),
        TypewriterText(
          words: profile.roleTitles.map(context.tr).toList(),
          style: text.headlineSmall!.copyWith(
            fontSize: isCompact ? 18 : 24,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.secondary : AppColors.secondaryDark,
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 350.ms),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            context.tr(profile.summaryKey),
            style: text.bodyLarge?.copyWith(
              color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
              fontSize: 16.5,
            ),
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 20, end: 0, delay: 450.ms),
        const SizedBox(height: 30),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            AppButton(
              label: context.tr('hero.cta.contact'),
              icon: Icons.send_rounded,
              onPressed: onContact,
            ),
            AppButton(
              label: context.tr('hero.cta.cv'),
              icon: Icons.download_rounded,
              variant: AppButtonVariant.outline,
              onPressed: CvDownloader.download,
            ),
          ],
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 20, end: 0, delay: 550.ms),
        const SizedBox(height: 30),
        Row(
          children: [
            for (final link in socialLinks)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: MagneticHover(
                  child: SocialIconButton(
                    icon: _iconFor(link.type),
                    tooltip: context.tr(link.labelKey),
                    onTap: () => LaunchUtils.open(link.url),
                    size: 48,
                  ),
                ),
              ),
          ],
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 20, end: 0, delay: 650.ms),
      ],
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.05)
            : AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.success.withValues(alpha: 0.8),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
            begin: const Offset(1, 1),
            end: const Offset(1.5, 1.5),
            duration: 900.ms,
          ),
          const SizedBox(width: 10),
          Text(
            context.tr('hero.available'),
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({required this.stats});

  final List<StatEntity> stats;

  int get _years => stats
      .where((s) => s.labelKey == 'stats.years')
      .map((s) => s.value)
      .firstOrNull ??
      5;

  int get _projects => stats
      .where((s) => s.labelKey == 'stats.projects')
      .map((s) => s.value)
      .firstOrNull ??
      20;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return SizedBox(
      height: 460,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glass panel hosting the 3D field
          Container(
            width: 460,
            height: 460,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.08),
              ),
              gradient: RadialGradient(
                center: const Alignment(0.2, -0.2),
                colors: [
                  (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: isDark ? 0.22 : 0.12),
                  blurRadius: 80,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: ParticleField3D(),
            ),
          ),
          // Floating stat chips
          PositionedDirectional(
            top: 8,
            end: 4,
            child: _FloatChip(
              icon: Icons.emoji_events_rounded,
              title: '$_years+',
              subtitle: Text(context.tr('hero.floating.years')),
            ),
          ),
          PositionedDirectional(
            bottom: 40,
            start: 0,
            child: _FloatChip(
              icon: Icons.rocket_launch_rounded,
              title: '$_projects+',
              subtitle: Text(context.tr('hero.floating.projects')),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatChip extends StatelessWidget {
  const _FloatChip({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: isDark ? 0.06 : 0.05),
        border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: AppColors.secondary),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              DefaultTextStyle(
                style: TextStyle(fontSize: 12.5, color: context.isDarkMode ? AppColors.darkMuted : AppColors.lightMuted),
                child: subtitle,
              ),
            ],
          ),
        ],
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
          begin: 8,
          end: -8,
          duration: 2600.ms,
          curve: Curves.easeInOut,
        );
  }
}

class _ScrollHint extends StatefulWidget {
  const _ScrollHint({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_ScrollHint> createState() => _ScrollHintState();
}

class _ScrollHintState extends State<_ScrollHint> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final muted = context.isDarkMode ? AppColors.darkMuted : AppColors.lightMuted;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: FadeTransition(
          opacity: Tween(begin: 0.3, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr('hero.scroll'),
                style: TextStyle(fontSize: 12.5, color: muted, letterSpacing: 1),
              ),
              const SizedBox(height: 6),
              Icon(Icons.keyboard_double_arrow_down_rounded, color: muted),
            ],
          ),
        ),
      ),
    );
  }
}