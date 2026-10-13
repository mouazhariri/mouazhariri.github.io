import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/core/shared_widgets/glass_card.dart';
import '../../../../src/core/shared_widgets/icon_mapper.dart';
import '../../../../src/core/shared_widgets/reveal.dart';
import '../../../../src/core/shared_widgets/section_header.dart';
import '../../../../src/core/shared_widgets/section_scaffold.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/theme/app_colors.dart';
import '../../../../src/core/utils/theme/app_theme.dart';
import '../../domain/entities/experience_entity.dart';

/// Professional experience timeline.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.experience});

  final List<ExperienceEntity> experience;

  @override
  Widget build(BuildContext context) {
    final jobs = experience.where((e) => !e.isEducation).toList();

    return SectionScaffold(
      child: Column(
        children: [
          Reveal(
            id: 'experience-header',
            child: SectionHeader(
              overline: context.tr('experience.overline'),
              title: context.tr('experience.title'),
              subtitle: context.tr('experience.subtitle'),
            ),
          ),
          const SizedBox(height: 56),
          _Timeline(items: jobs),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.items});

  final List<ExperienceEntity> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final alternating = constraints.maxWidth >= 860;
        return Stack(
          children: [
            if (alternating)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.5),
                          AppColors.secondary.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Column(
              children: [
                for (var i = 0; i < items.length; i++)
                  alternating
                      ? _AlternatingRow(
                          index: i,
                          item: items[i],
                          isLast: i == items.length - 1,
                        )
                      : _CompactRow(item: items[i]),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AlternatingRow extends StatelessWidget {
  const _AlternatingRow({
    required this.index,
    required this.item,
    required this.isLast,
  });

  final int index;
  final ExperienceEntity item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final left = index.isEven;
    final card = _ExperienceCard(item: item);

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 34),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: left
                ? _AlignedCard(
                    alignment: AlignmentDirectional.topEnd,
                    child: card,
                  )
                : const SizedBox(),
          ),
          SizedBox(
            width: 56,
            child: Column(
              children: [
                const _TimelineDot(),
                if (!isLast)
                  Container(width: 2, height: 60, color: Colors.transparent),
              ],
            ),
          ),
          Expanded(
            child: left
                ? const SizedBox()
                : _AlignedCard(alignment: AlignmentDirectional.topStart, child: card),
          ),
        ],
      ),
    );
  }
}

class _CompactRow extends StatelessWidget {
  const _CompactRow({required this.item});

  final ExperienceEntity item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 32,
            child: Padding(
              padding: EdgeInsets.only(top: 22),
              child: _TimelineDot(size: 18),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(child: _ExperienceCard(item: item)),
        ],
      ),
    );
  }
}

class _AlignedCard extends StatelessWidget {
  const _AlignedCard({required this.alignment, required this.child});

  final AlignmentDirectional alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(alignment: alignment, child: child);
  }
}

class _TimelineDot extends StatelessWidget {
  const _TimelineDot({this.size = 16});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppGradients.brand,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.55),
            blurRadius: 14,
            spreadRadius: 3,
          ),
        ],
      ),
      child: const Center(
        child: CircleAvatar(
          radius: 1,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.item});

  final ExperienceEntity item;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final accent = AppColors.primary;
    final muted = isDark ? AppColors.darkMuted : AppColors.lightMuted;

    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: AppGradients.brand,
                  ),
                  child: Icon(
                    portfolioIcon(item.iconKey),
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.company,
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.tr(item.roleKey),
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetaChip(
                  icon: Icons.calendar_month_rounded,
                  label: context.tr(item.periodKey),
                  accent: accent,
                ),
                _MetaChip(
                  icon: Icons.place_rounded,
                  label: item.location,
                  accent: accent,
                ),
                _MetaChip(
                  icon: Icons.work_outline_rounded,
                  label: context.tr(item.typeKey),
                  accent: accent,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (item.highlights.isNotEmpty) ...[
              const Divider(height: 24),
              for (final highlight in item.highlights)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppGradients.brand,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          context.tr(highlight),
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.5,
                            color: muted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: accent.withValues(alpha: context.isDarkMode ? 0.14 : 0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: accent),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
