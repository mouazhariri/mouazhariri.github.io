import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../src/core/shared_widgets/glass_card.dart';
import '../../../../src/core/shared_widgets/icon_mapper.dart';
import '../../../../src/core/shared_widgets/reveal.dart';
import '../../../../src/core/shared_widgets/section_header.dart';
import '../../../../src/core/shared_widgets/section_scaffold.dart';
import '../../../../src/core/shared_widgets/tilt_card_3d.dart';
import '../../../../src/core/utils/extensions/context_extension.dart';
import '../../../../src/core/utils/functions/color_utils.dart';
import '../../../../src/core/utils/theme/app_colors.dart';
import '../../domain/entities/service_entity.dart';

/// Services grid — 1/2/3 columns by width.
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key, required this.services, required this.onHire});

  final List<ServiceEntity> services;
  final VoidCallback onHire;

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      child: Column(
        children: [
          Reveal(
            id: 'services-header',
            child: SectionHeader(
              overline: context.tr('services.overline'),
              title: context.tr('services.title'),
              subtitle: context.tr('services.subtitle'),
            ),
          ),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1000
                  ? 3
                  : constraints.maxWidth >= 640
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) => Reveal(
                  id: 'service-$index',
                  delay: Duration(milliseconds: 90 * index),
                  child: TiltCard3D(
                    glow: true,
                    maxTilt: 0.06,
                    child: _ServiceCard(service: services[index], onHire: onHire),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.onHire});

  final ServiceEntity service;
  final VoidCallback onHire;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final accent = colorFromHex(service.accentHex);
    final muted = isDark ? AppColors.darkMuted : AppColors.lightMuted;

    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.55)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(portfolioIcon(service.iconKey), color: Colors.white, size: 25),
              ),
              const Spacer(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onHire,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      size: 20,
                      color: accent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            context.tr(service.titleKey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              context.tr(service.descriptionKey),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: context.text.bodyMedium?.copyWith(color: muted, fontSize: 14),
            ),
          ),
          // divider + tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in service.tags)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: accent.withValues(alpha: isDark ? 0.16 : 0.1),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: accent),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}