import 'package:flutter/material.dart';

import '../utils/extensions/context_extension.dart';
import '../utils/theme/app_colors.dart';
import '../utils/theme/app_theme.dart';

/// Section heading: overline chip + title + subtitle, centered by default.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.overline,
    required this.title,
    this.subtitle,
    this.centered = true,
  });

  final String overline;
  final String title;
  final String? subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final alignment = centered ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        _OverlineChip(label: overline),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: alignment,
          style: text.headlineMedium?.copyWith(
            fontSize: 40,
            height: 1.1,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              textAlign: alignment,
              style: text.bodyLarge?.copyWith(
                color: context.isDarkMode ? AppColors.darkMuted : AppColors.lightMuted,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _OverlineChip extends StatelessWidget {
  const _OverlineChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: AppGradients.brand,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 18,
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}