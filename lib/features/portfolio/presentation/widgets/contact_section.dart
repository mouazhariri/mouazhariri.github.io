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
import '../../../../src/core/utils/theme/app_theme.dart';
import '../../domain/entities/portfolio_enums.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/social_link_entity.dart';

/// Contact: a gradient panel with the direct channels (WhatsApp/Telegram/
/// email/phone) paired with a message form that composes an email.
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
              final panel = _ContactPanel(
                profile: profile,
                whatsapp: whatsapp,
                telegram: telegram,
                email: email,
              );
              final form = _MessageForm(profile: profile);
              if (!wide) {
                return Column(
                  children: [
                    panel,
                    const SizedBox(height: 26),
                    form,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: panel),
                  const SizedBox(width: 28),
                  Expanded(child: form),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// One tappable channel rendered inside the gradient panel.
class _Channel {
  const _Channel({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final Object icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
}

class _ContactPanel extends StatelessWidget {
  const _ContactPanel({
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
    final channels = <_Channel>[
      _Channel(
        icon: FontAwesomeIcons.whatsapp,
        label: context.tr('contact.info.whatsapp'),
        value: context.tr('contact.info.whatsappValue'),
        onTap: whatsapp != null ? () => LaunchUtils.open(whatsapp!.url) : null,
      ),
      _Channel(
        icon: FontAwesomeIcons.telegram,
        label: context.tr('contact.info.telegram'),
        value: context.tr('contact.info.telegramValue'),
        onTap: telegram != null ? () => LaunchUtils.open(telegram!.url) : null,
      ),
      _Channel(
        icon: FontAwesomeIcons.envelope,
        label: context.tr('contact.info.email'),
        value: profile.email,
        onTap: () => LaunchUtils.sendEmail(to: profile.email),
      ),
      _Channel(
        icon: FontAwesomeIcons.phone,
        label: context.tr('contact.info.phone'),
        value: profile.phone,
        onTap: () => LaunchUtils.open(
          'tel:${profile.phone.replaceAll(' ', '')}',
        ),
      ),
    ];

    return Reveal(
      id: 'contact-panel',
      child: Container(
        padding: const EdgeInsets.all(28),
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
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    profile.monogram,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(child: _AvailabilityPill()),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              context.tr('contact.cta.title'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              context.tr('contact.cta.subtitle'),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 24),
            for (var i = 0; i < channels.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              _ChannelRow(channel: channels[i]),
            ],
            const SizedBox(height: 20),
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

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.success.withValues(alpha: 0.18),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.success.withValues(alpha: 0.8),
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
    );
  }
}

class _ChannelRow extends StatefulWidget {
  const _ChannelRow({required this.channel});

  final _Channel channel;

  @override
  State<_ChannelRow> createState() => _ChannelRowState();
}

class _ChannelRowState extends State<_ChannelRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final channel = widget.channel;
    final enabled = channel.onTap != null;
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: channel.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(
              alpha: enabled && _hover ? 0.24 : 0.12,
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.18),
                ),
                child: AppIcon(channel.icon, size: 17, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channel.label,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      channel.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_outward_rounded,
                size: 18,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageForm extends StatefulWidget {
  const _MessageForm({required this.profile});

  final ProfileEntity profile;

  @override
  State<_MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<_MessageForm> {
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
    final isDark = context.isDarkMode;
    final scheme = Theme.of(context).colorScheme;
    final muted = isDark ? AppColors.darkMuted : AppColors.lightMuted;
    final fill = isDark
        ? Colors.white.withValues(alpha: 0.04)
        : Colors.black.withValues(alpha: 0.02);
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.6);

    OutlineInputBorder rounded(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );

    return Reveal(
      id: 'contact-form',
      child: GlassCard(
        padding: const EdgeInsets.all(26),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: AppGradients.brand,
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.tr('contact.form.title'),
                      style: context.text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                context.tr('contact.form.note'),
                style: TextStyle(fontSize: 13, color: muted, height: 1.4),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: context.tr('contact.form.name'),
                  prefixIcon: const Icon(Icons.person_rounded, size: 20),
                  filled: true,
                  fillColor: fill,
                  border: rounded(borderColor),
                  enabledBorder: rounded(borderColor),
                  focusedBorder: rounded(scheme.primary, 1.6),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? context.tr('contact.form.required')
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: context.tr('contact.form.email'),
                  prefixIcon: const Icon(Icons.alternate_email_rounded, size: 20),
                  filled: true,
                  fillColor: fill,
                  border: rounded(borderColor),
                  enabledBorder: rounded(borderColor),
                  focusedBorder: rounded(scheme.primary, 1.6),
                ),
                validator: (v) => (v == null || !v.contains('@'))
                    ? context.tr('contact.form.required')
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _messageController,
                minLines: 4,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: context.tr('contact.form.message'),
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: fill,
                  border: rounded(borderColor),
                  enabledBorder: rounded(borderColor),
                  focusedBorder: rounded(scheme.primary, 1.6),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? context.tr('contact.form.required')
                    : null,
              ),
              const SizedBox(height: 18),
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
    );
  }
}
