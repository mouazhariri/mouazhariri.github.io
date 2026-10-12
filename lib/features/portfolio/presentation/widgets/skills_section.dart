import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/core/shared_widgets/glass_card.dart';
import '../../../../src/core/shared_widgets/icon_mapper.dart';
import '../../../../src/core/shared_widgets/reveal.dart';
import '../../../../src/core/shared_widgets/section_header.dart';
import '../../../../src/core/shared_widgets/section_scaffold.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/theme/app_theme.dart';
import '../../domain/entities/skill_entity.dart';

/// Skills grouped by discipline, presented as clean tag lists.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.skills});

  final List<SkillGroupEntity> skills;

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      child: Column(
        children: [
          Reveal(
            id: 'skills-header',
            child: SectionHeader(
              overline: context.tr('skills.overline'),
              title: context.tr('skills.title'),
              subtitle: context.tr('skills.subtitle'),
            ),
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 22.0;
              final columns = constraints.maxWidth >= 1000
                  ? 3
                  : constraints.maxWidth >= 640
                      ? 2
                      : 1;
              final cardWidth =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (var i = 0; i < skills.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: Reveal(
                        id: 'skill-$i',
                        delay: Duration(milliseconds: 70 * i),
                        child: GlassCard(
                          padding: const EdgeInsets.all(22),
                          child: _SkillGroupCard(group: skills[i]),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group});

  final SkillGroupEntity group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: AppGradients.brand,
              ),
              child: Icon(
                portfolioIcon(group.iconKey),
                color: Colors.white,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.tr(group.groupKey),
                style: context.text.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final skill in group.items) _SkillChip(label: skill.name),
          ],
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: scheme.primary.withValues(alpha: isDark ? 0.14 : 0.08),
        border: Border.all(
          color: scheme.primary.withValues(alpha: isDark ? 0.30 : 0.18),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF1E293B),
        ),
      ),
    );
  }
}
