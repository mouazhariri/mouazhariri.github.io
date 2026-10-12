import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../src/core/shared_widgets/social_icon_button.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/functions/launch_utils.dart';
import '../../../../src/core/utils/theme/app_theme.dart';
import '../../domain/entities/portfolio_enums.dart';
import '../../domain/entities/social_link_entity.dart';

/// Footer: brand, quick links, socials and credits.
class FooterSection extends StatelessWidget {
  const FooterSection({
    super.key,
    required this.onNavigate,
    required this.socialLinks,
  });

  final ValueChanged<int> onNavigate;
  final List<SocialLinkEntity> socialLinks;

  static const _links = [
    ('nav.home', 0),
    ('nav.about', 1),
    ('nav.services', 2),
    ('nav.skills', 3),
    ('nav.experience', 4),
    ('nav.projects', 5),
    ('nav.contact', 6),
  ];

  SocialLinkEntity? _byType(SocialLinkType type) =>
      socialLinks.where((l) => l.type == type).firstOrNull;

  @override
  Widget build(BuildContext context) {
    final muted = context.isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Container(
      margin: const EdgeInsets.only(top: 72),
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 36),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.isDarkMode ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppGradients.brand,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.35),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Text(
              'MH',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Mouaz Hariri',
            style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            context.tr('footer.tagline'),
            style: TextStyle(color: muted, fontSize: 14),
          ),
          const SizedBox(height: 26),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final (key, index) in _links)
                _FooterLink(
                  label: context.tr(key),
                  onTap: () => onNavigate(index),
                ),
            ],
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 14,
            runSpacing: 12,
            children: [
              for (final (type, icon) in const [
                (SocialLinkType.github, FontAwesomeIcons.github),
                (SocialLinkType.linkedin, FontAwesomeIcons.linkedinIn),
                (SocialLinkType.whatsapp, FontAwesomeIcons.whatsapp),
                (SocialLinkType.telegram, FontAwesomeIcons.telegram),
                (SocialLinkType.email, FontAwesomeIcons.envelope),
              ])
                SocialIconButton(
                  icon: icon,
                  tooltip: context.tr(_byType(type)?.labelKey ?? ''),
                  size: 44,
                  onTap: _byType(type) == null
                      ? null
                      : () => LaunchUtils.open(_byType(type)!.url),
                ),
            ],
          ),
          const SizedBox(height: 30),
          Divider(color: muted.withValues(alpha: 0.2)),
          const SizedBox(height: 22),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '© 2026 ${context.tr('footer.rights')}',
                style: TextStyle(color: muted, fontSize: 13),
              ),
              Text('•', style: TextStyle(color: muted)),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: context.tr('footer.builtWith')),
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 14,
                          color: Color(0xFFF87171),
                        ),
                      ),
                    ),
                    const TextSpan(text: 'Flutter'),
                  ],
                ),
                style: TextStyle(color: muted, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: _hover ? FontWeight.w700 : FontWeight.w500,
            color: _hover ? accent : (context.isDarkMode ? Colors.white70 : const Color(0xFF475569)),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}