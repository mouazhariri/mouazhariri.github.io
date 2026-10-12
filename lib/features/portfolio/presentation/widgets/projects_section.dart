import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../src/core/shared_widgets/app_icon.dart';
import '../../../../src/core/shared_widgets/glass_card.dart';
import '../../../../src/core/shared_widgets/icon_mapper.dart';
import '../../../../src/core/shared_widgets/reveal.dart';
import '../../../../src/core/shared_widgets/section_header.dart';
import '../../../../src/core/shared_widgets/section_scaffold.dart';
import '../../../../src/core/shared_widgets/tilt_card_3d.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/functions/color_utils.dart';
import '../../../../src/core/utils/functions/launch_utils.dart';
import '../../../../src/core/utils/theme/app_colors.dart';
import '../../../../src/core/utils/theme/app_theme.dart';
import '../../domain/entities/portfolio_enums.dart';
import '../../domain/entities/project_entity.dart';

/// Projects grid with category filtering.
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key, required this.projects});

  final List<ProjectEntity> projects;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectCategory? _selected;

  List<ProjectEntity> get _visible => _selected == null
      ? widget.projects
      : widget.projects.where((p) => p.category == _selected).toList();

  @override
  Widget build(BuildContext context) {
    final categories = widget.projects.map((p) => p.category).toSet().toList();

    return SectionScaffold(
      child: Column(
        children: [
          Reveal(
            id: 'projects-header',
            child: SectionHeader(
              overline: context.tr('projects.overline'),
              title: context.tr('projects.title'),
              subtitle: context.tr('projects.subtitle'),
            ),
          ),
          const SizedBox(height: 36),
          Reveal(
            id: 'projects-filters',
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                _FilterChip(
                  label: context.tr('projects.filter.all'),
                  selected: _selected == null,
                  onTap: () => setState(() => _selected = null),
                ),
                for (final category in categories)
                  _FilterChip(
                    label: context.tr('projects.cat.${projectCategoryKey(category)}'),
                    selected: _selected == category,
                    onTap: () => setState(() => _selected = category),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 44),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 420),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeIn,
            child: LayoutBuilder(
              key: ValueKey(_selected),
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 1100
                    ? 3
                    : constraints.maxWidth >= 700
                        ? 2
                        : 1;
                final visible = _visible;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: visible.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 22,
                    mainAxisSpacing: 22,
                    mainAxisExtent: columns == 1 ? 360 : 400,
                  ),
                  itemBuilder: (context, index) {
                    final baseIndex = widget.projects.indexOf(visible[index]);
                    return Reveal(
                      id: 'project-$baseIndex',
                      delay: Duration(milliseconds: 80 * (index % columns)),
                      child: TiltCard3D(
                        glow: true,
                        maxTilt: 0.05,
                        child: _ProjectCard(project: visible[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Stable snake_case key for a [ProjectCategory] (matches translation keys).
String projectCategoryKey(ProjectCategory category) => switch (category) {
      ProjectCategory.eCommerce => 'e_commerce',
      ProjectCategory.services => 'services',
      ProjectCategory.delivery => 'delivery',
      ProjectCategory.productivity => 'productivity',
      ProjectCategory.social => 'social',
      ProjectCategory.entertainment => 'entertainment',
      ProjectCategory.webBackend => 'web_backend',
      ProjectCategory.finance => 'finance',
      ProjectCategory.other => 'other',
    };

class _FilterChip extends StatefulWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: widget.selected ? AppGradients.brand : null,
            color: widget.selected ? null : Colors.transparent,
            border: widget.selected
                ? null
                : Border.all(
                    color: context.isDarkMode
                        ? Colors.white12
                        : Colors.black.withValues(alpha: 0.1),
                  ),
            boxShadow: widget.selected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 16,
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: widget.selected ? FontWeight.w700 : FontWeight.w500,
              color: widget.selected
                  ? Colors.white
                  : (context.isDarkMode ? Colors.white70 : const Color(0xFF475569)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final accent = colorFromHex(project.accentHex);
    final muted = isDark ? AppColors.darkMuted : AppColors.lightMuted;
    final shownTech = project.tech.take(3).toList();
    final extraTech = project.tech.length - shownTech.length;

    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.55)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  portfolioIcon(project.iconKey),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: accent.withValues(alpha: isDark ? 0.16 : 0.1),
                ),
                child: Text(
                  context.tr('projects.cat.${projectCategoryKey(project.category)}'),
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            context.tr(project.titleKey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              context.tr(project.descriptionKey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.text.bodyMedium?.copyWith(color: muted, fontSize: 14),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tech in shownTech)
                _TechTag(label: tech, accent: accent),
              if (extraTech > 0)
                _TechTag(label: '+$extraTech', accent: accent, ghost: true),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final link in project.links)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: _LinkChip(
                    type: link.type,
                    onTap: () => LaunchUtils.open(link.url),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  const _TechTag({required this.label, required this.accent, this.ghost = false});

  final String label;
  final Color accent;
  final bool ghost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ghost
            ? Colors.transparent
            : accent.withValues(alpha: context.isDarkMode ? 0.14 : 0.08),
        border: ghost ? Border.all(color: accent.withValues(alpha: 0.4)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: ghost ? accent : accent,
        ),
      ),
    );
  }
}

class _LinkChip extends StatefulWidget {
  const _LinkChip({required this.type, required this.onTap});

  final ProjectLinkType type;
  final VoidCallback onTap;

  @override
  State<_LinkChip> createState() => _LinkChipState();
}

class _LinkChipState extends State<_LinkChip> {
  bool _hover = false;

  Object get _icon => switch (widget.type) {
        ProjectLinkType.appStore => FontAwesomeIcons.appStore,
        ProjectLinkType.playStore => FontAwesomeIcons.googlePlay,
        ProjectLinkType.web => Icons.public_rounded,
        ProjectLinkType.github => FontAwesomeIcons.github,
      };

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: _hover ? AppGradients.brand : null,
            color: _hover ? null : Colors.transparent,
            border: Border.all(
              color: _hover
                  ? Colors.transparent
                  : (context.isDarkMode ? Colors.white12 : Colors.black12),
            ),
          ),
          child: AppIcon(_icon, size: 16, color: _hover ? Colors.white : accent),
        ),
      ),
    );
  }
}