import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../src/core/shared_widgets/app_button.dart';
import '../../../../src/core/shared_widgets/app_icon.dart';
import '../../../../src/core/shared_widgets/glass_card.dart';
import '../../../../src/core/shared_widgets/reveal.dart';
import '../../../../src/core/shared_widgets/section_header.dart';
import '../../../../src/core/shared_widgets/section_scaffold.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/functions/launch_utils.dart';
import '../../../../src/core/utils/theme/app_colors.dart';
import '../../domain/entities/portfolio_enums.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/social_link_entity.dart';

/// Contact: direct channels (WhatsApp/Telegram/Gmail/phone), a quick message
/// form (composes an email), and a big call-to-action panel.
class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.profile,
    required this.socialLinks,
  });

  final ProfileEntity profile;
  final List<SocialLinkEntity> socialLinks;

  SocialLinkEntity? _byType(SocialLinkType type) =>
      socialLinks.where((l) => l.type == type).firstOrNull;

  @override
  Widget build(BuildContext context) {
    final whatsapp = _byType(SocialLinkType.whatsapp);
    final telegram = _byType(SocialLinkType.telegram);
    final email = _byType(SocialLinkType.email);

    return SectionScaffold(
      child: Column(
        children: [
          Reveal(
            id: 'contact-header',
            child: SectionHeader(
              overline: context.tr('contact.overline'),
              title: context.tr('contact.title'),
              subtitle: context.tr('contact.subtitle'),
            ),
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1000;
              final info = _ContactInfo(profile: profile);
              final cta = _ContactCtaPanel(
                profile: profile,
                whatsapp: whatsapp,
                telegram: telegram,
                email: email,
              );
              if (!wide) {
                return Column(
                  children: [
                    info,
                    const SizedBox(height: 28),
                    cta,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: info),
                  const SizedBox(width: 28),
                  Expanded(flex: 5, child: cta),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatefulWidget {
  const _ContactInfo({required this.profile});

  final ProfileEntity profile;

  @override
  State<_ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<_ContactInfo> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _send() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final subject = 'Portfolio contact — ${_nameController.text}';
    final body = '${_messageController.text}\n\n---\n'
        'From: ${_nameController.text} '
        '(${_emailController.text})';
    LaunchUtils.sendEmail(to: widget.profile.email, subject: subject, body: body);
  }

  @override
  Widget build(BuildContext context) {
    final cards = <(Object, String, String, String, Color)>[
      (
        Icons.alternate_email_rounded,
        context.tr('contact.info.email'),
        widget.profile.email,
        'mailto:${widget.profile.email}',
        AppColors.primary,
      ),
      (
        Icons.phone_rounded,
        context.tr('contact.info.phone'),
        widget.profile.phone,
        'tel:${widget.profile.phone.replaceAll(' ', '')}',
        AppColors.secondary,
      ),
      (
        FontAwesomeIcons.whatsapp,
        context.tr('contact.info.whatsapp'),
        context.tr('contact.info.whatsappValue'),
        'https://wa.me/${widget.profile.phoneLink}'
            '?text=${Uri.encodeComponent('Hi Mouaz! I found your portfolio.')}',
        const Color(0xFF25D366),
      ),
      (
        FontAwesomeIcons.telegram,
        context.tr('contact.info.telegram'),
        context.tr('contact.info.telegramValue'),
        'https://t.me/mouazHy',
        const Color(0xFF229ED9),
      ),
      (
        Icons.location_on_rounded,
        context.tr('contact.info.location'),
        widget.profile.location,
        'https://www.google.com/maps/search/${Uri.encodeComponent(widget.profile.location)}',
        AppColors.tertiary,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < cards.length; i++)
          Reveal(
            id: 'contact-info-$i',
            delay: Duration(milliseconds: 70 * i),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _InfoCard(
                icon: cards[i].$1,
                label: cards[i].$2,
                value: cards[i].$3,
                url: cards[i].$4,
                accent: cards[i].$5,
              ),
            ),
          ),
        const SizedBox(height: 14),
        Reveal(
          id: 'contact-form',
          child: GlassCard(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('contact.form.title'),
                    style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: context.tr('contact.form.name'),
                      prefixIcon: const Icon(Icons.person_rounded),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? context.tr('contact.form.required')
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: context.tr('contact.form.email'),
                      prefixIcon: const Icon(Icons.alternate_email_rounded),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (v) => (v == null || !v.contains('@'))
                        ? context.tr('contact.form.required')
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _messageController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: context.tr('contact.form.message'),
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.edit_rounded),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? context.tr('contact.form.required')
                        : null,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: context.tr('contact.form.send'),
                    icon: Icons.send_rounded,
                    expanded: true,
                    onPressed: _send,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.accent,
  });

  final Object icon;
  final String label;
  final String value;
  final String url;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      onTap: () => LaunchUtils.open(url),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: accent.withValues(alpha: isDark ? 0.2 : 0.12),
            ),
            child: AppIcon(icon, size: 20, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkMuted : AppColors.lightMuted,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_outward_rounded, size: 18, color: accent),
        ],
      ),
    );
  }
}

class _ContactCtaPanel extends StatelessWidget {
  const _ContactCtaPanel({
    required this.profile,
    required this.whatsapp,
    required this.telegram,
    required this.email,
  });

  final ProfileEntity profile;
  final SocialLinkEntity? whatsapp;
  final SocialLinkEntity? telegram;
  final SocialLinkEntity? email;

  @override
  Widget build(BuildContext context) {
    return Reveal(
      id: 'contact-cta',
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4F46E5), Color(0xFF6366F1), Color(0xFF0EA5E9)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 60,
              spreadRadius: 4,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.18),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                  ),
                  child: Text(
                    profile.monogram,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF34D399),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF34D399).withValues(alpha: 0.8),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          context.tr('contact.availability'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Text(
              context.tr('contact.cta.title'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              context.tr('contact.cta.subtitle'),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            _CtaButton(
              icon: FontAwesomeIcons.whatsapp,
              label: context.tr('contact.cta.whatsapp'),
              color: const Color(0xFF25D366),
              onTap: whatsapp != null
                  ? () => LaunchUtils.open(whatsapp!.url)
                  : null,
            ),
            const SizedBox(height: 12),
            _CtaButton(
              icon: FontAwesomeIcons.telegram,
              label: context.tr('contact.cta.telegram'),
              color: const Color(0xFF229ED9),
              onTap: telegram != null
                  ? () => LaunchUtils.open(telegram!.url)
                  : null,
            ),
            const SizedBox(height: 12),
            _CtaButton(
              icon: FontAwesomeIcons.envelope,
              label: context.tr('contact.cta.email'),
              color: Colors.white,
              onTap: () => LaunchUtils.sendEmail(to: profile.email),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: context.tr('contact.cta.response')),
                  TextSpan(
                    text: context.tr('contact.cta.responseHighlight'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  const _CtaButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final Object icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white.withValues(alpha: widget.onTap == null ? 0.1 : (_hover ? 1 : 0.16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(widget.icon, size: 18, color: widget.onTap == null ? Colors.white38 : widget.color),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: widget.onTap == null ? Colors.white38 : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}